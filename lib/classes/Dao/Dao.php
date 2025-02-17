<?php

class Dao {
    //The query adapter that handles the database connection, query builder and the queries themselves.
    protected QueryAdapter $queryAdapter;
    //The table names
    protected $table;
    //The primary key fields
    protected $primaryKeyField;
    //The particular Entity
    protected ?Entity $entity;
    //Array of Data Access Objects
    protected array $daos = [];
    //Array of Database fields
    protected array $fields = [];
    //Pagination page size
    protected $pageSize = 10;
    //caching options
    protected $cache;
    //queryBuilder options
    protected ISQLQueryBuilder $queryBuilder;
    //Handling error Messages
    protected $errorMessage;

    public function __construct(QueryAdapter $queryAdapter, array $daos=[], ICache $cache = null){
        $this->queryAdapter = $queryAdapter;
        
        if($daos){
            $this->daos = $daos;
        }

        if($cache){
            $this->cache = $cache;
        }

        //Means that current Dao object ($this) is being stored in the $daos array using the value of $this->table as the key
        $this->daos[$this->table] = $this;

        //Adding the setter methods for our query adapter(Setter for the table, primary key and pageSize)
        //Will get to understanding why when we finish the dao creation
        $this->queryAdapter->setTable($this->table);
        $this->queryAdapter->setPrimaryKey($this->primaryKeyField);
        $this->queryAdapter->setPageSize($this->pageSize);

        //Calling the init function that is within each individual Dao object(which is responsible for creating each entity instance)
        $this->init();
    }

    public function init(){
        throw new Exception("Call from child class");
    }

    function save(Entity $entity)
    {

        //insert query
        // get field Names for the Table
        $fields = [];
        $values = [];
        $updates = [];
        $primaryKey = null;

        foreach($entity->__mapping as $key=>$value)
        {
    
            if($value == $this->primaryKeyField){
                $primaryKey = $key;
            }
          
             $fields[]="$value";          

             if(!$entity->{$key}){
                $values[] =null;  
             }
             else{
                $values[] =$entity->{$key};    
             }
                     
            

        }  
        
        $recordsExists = $this->findById($entity->{$primaryKey});

        $result = null;
        try{
        if(!$recordsExists)
       {
        //we only insert if there is no value for the primary key field
        //eg. if $employee->manNo = 0 or $employee->manNo = null or $employee->manNo = ''

       $result= $this->queryAdapter->insert($fields, $values);
     
      }
      else
      {

        $result= $this->queryAdapter->update($fields, $values, $entity->{$primaryKey});

      }
    
    
       if($result!==0){          
            
             $entity->{$this->$primaryKey}=$result;       
       
        }
        //invalidate cache
        if($this->cache){
          $this->cache->destroyAll();
         }
        return $entity;

    }catch(Exception $ex)
    {
        if(preg_match('/Duplicate entry\s\'(.*?)\'/',$ex->getMessage(),$matches))
        {
            $value = $matches[1];
            $this->errorMessage = "The value $value already exits";
           
        }
        else{
            $this->errorMessage = "Error occurred when saving record";
        }
        LoggingUtil::writeLog($ex,get_class($this->entity));
    }

        return null;

    }

    /**
     * Summary of findAll: Fetches all records
     * @param ?int $page : the size of the page for records 
     * @param ?int $nextPageSize : if set, this is the number of records to fetch per page
     * @return array : array of objects of type entity
     */
    function findAll($page = null,$nextPageSize=null, $whereClause=""): array
    {

       $index = $this->table.($page??'').($nextPageSize??'');//unique index based on my parameters
       //if the parameters are the same, then it entails, the return data is the same
       //unset($_SESSION[$index]); //invalidate cache
       //invalidate cache
       //$this->cache->destroy($index);

       //if there is already data in the cache, then simply return that data
       if($this->cache){
         if($this->cache->get($index)){
           print("<span style=\"color:green\">Getting Cached copy</span><br/>");
            return $this->cache->get($index);
         }
       }

       $records = [];
    
        $result = $this->queryAdapter->select(null, $whereClause,$page,$nextPageSize);
        if ($result) {

            foreach ($result as $row) {
                
                $records[] = $this->extractObject($row);
            }
        }
        if($this->cache){
         print("<span style=\"color:red\">Fetching database copy</span><br/>");
         $this->cache->put($index,$records);
        }

        return $records;
    }

    function findById($id): Entity|null
    {
        $entity = null;         
        
        $result = $this->queryAdapter->select($id);
        if ($result) {
            foreach ($result as $row) {
                $entity = $this->extractObject($row);
            }
        }
        return $entity;
    }

    function searchTerm($page ,$searchTerm): array {
        // Retrieving all employees based on page and size
        $employees = $this->findAll(null, null , null);
        
        // Filtering employees based on the search term
        $rows = [];
        if ($searchTerm) {
            $rows = array_filter($employees, function ($employee) use ($searchTerm) {
                return str_contains(strtolower($employee->name), strtolower($searchTerm)) ||
                       str_contains(strtolower($employee->manNo), strtolower($searchTerm)) ||
                       str_contains(strtolower($employee->emailAddress), strtolower($searchTerm)) ||
                       str_contains(strtolower($employee->department->name), strtolower($searchTerm));
            });
        }

        return PaginationUtil::paginatePages($rows, $this->pageSize, $page)['items']??[];

       
    }   

    public function delete(Entity $entity){
        $id = null;
        foreach($entity->__mapping as $key => $value){
            if($value === $this->primaryKeyField){
                $id = $entity->{$key};
                break;
            }
        }

        if(!$id){
            throw new Exception("No value supplied for Id");
        }

        if($this->cache){
            $this->cache->destroyAll();
        }

        return $this->queryAdapter->delete($id);
    }

    public function drop(){

    }

    public function getFieldDetails(){
        $rows = $this->queryAdapter->describe();
        if($rows){
            foreach($rows as $row){
                $this->fields[$row['Field']] = $row;
            }
        }
    }

    function extractObject($row): ?Entity
    {
        //$this->init();

        if (!$this->entity)
         {
            throw new Exception("Extract Object failed. Call Init first.");
         }

            // a new entity instance
            $entity = clone $this->entity;

            //extract the table values mapped to the entities
            foreach ($this->entity->__mapping as $key => $value) {
                $entity->{$key} = $row[$value];
            
            }

         
            //checking the variable is a type of Department object
            if ($this->entity->__relationships) {

                foreach ($this->entity->__relationships as $prop=>$values) { 

                       $id = $entity->{$values['field']}; //carries the actual value

                       if($id){
                         $entity->{$prop} = $this->daos[$values['table']]->findById($id);
                       }
                    
                }
            }
        

        return $entity;
    }
}