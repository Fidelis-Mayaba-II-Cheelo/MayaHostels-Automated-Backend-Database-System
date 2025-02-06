<?php

class InputUtil {
    public static function sanitizeInput($input) {
        return trim(htmlspecialchars($input));
    }
}