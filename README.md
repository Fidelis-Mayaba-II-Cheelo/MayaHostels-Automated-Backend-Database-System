## 📘 About This Project

**MayaHostels – Automated Backend Database System** is a backend-only database solution designed to power student accommodation platforms such as hostel or boarding house systems. It focuses entirely on robust backend logic, database integrity, and automation using SQL.

The system is compatible with both **PostgreSQL** and **MySQL**, and serves as a reusable foundation for frontend applications built in any language or framework.

---

### 🧠 Core Components

- ⚙️ **Stored Procedures**  
  Used to handle key business operations such as registering students, assigning bedspaces, and updating room occupancy—while enforcing rules like max capacity.

- 🔁 **Triggers**  
  Automatically maintain data integrity by executing logic before/after insertions, updates, or deletions (e.g., prevent overbooking, update room status when full).

- 🧩 **Functions**  
  Modular functions for checking room availability, counting current occupants, and validating student applications.

- 🗂️ **Database Design Document**  
  Includes ERD diagrams, table schemas, constraints, and relationships to guide future integration with frontend systems.

---

### 🛠️ System Capabilities

- Fully dynamic room and bedspace allocation logic
- Enforcement of room type constraints (e.g., single, double, triple, quadruple)
- Isolation of taken vs available rooms and bedspaces
- Designed for seamless integration into PHP, Python, or JavaScript-based apps

---

### 🧾 Project Includes

- 📄 SQL scripts for:
  - Creating all tables with constraints
  - Defining triggers, procedures, and functions
- 📘 Database design documentation (ERD + narrative)
- 🔄 Compatible scripts for both MySQL and PostgreSQL

---

> This system was developed to demonstrate backend automation, data integrity enforcement, and real-world database modeling using SQL.
