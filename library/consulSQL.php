<?php
/* Clase para ejecutar las consultas a la Base de Datos*/
class ejecutarSQL {
    public static function conectar(){
        $con = new mysqli(SERVER, USER, PASS, BD);
        if ($con->connect_errno) {
            die("Error en el servidor, verifique sus datos: " . $con->connect_error);
        }
        /* Codificar la información de la base de datos a UTF8*/
        $con->set_charset('utf8');
        return $con;
    }
    public static function consultar($query) {
        $consul = ejecutarSQL::conectar()->query($query);
        if (!$consul) {
            die("Error en la consulta SQL ejecutada: " . ejecutarSQL::conectar()->error);
        }
        return $consul;
    }
}
/* Clase para hacer las consultas Insertar, Eliminar y Actualizar */
class consultasSQL{
    public static function InsertSQL($tabla, $campos, $valores) {
        $consul = ejecutarSQL::consultar("insert into $tabla ($campos) VALUES($valores)");
        if (!$consul) {
            die("Ha ocurrido un error al insertar los datos en la tabla $tabla: " . ejecutarSQL::conectar()->error);
        }
        return $consul;
    }
    public static function DeleteSQL($tabla, $condicion) {
        $consul = ejecutarSQL::consultar("delete from $tabla where $condicion");
        if (!$consul) {
            die("Ha ocurrido un error al eliminar los registros en la tabla $tabla: " . ejecutarSQL::conectar()->error);
        }
        return $consul;
    }
    public static function UpdateSQL($tabla, $campos, $condicion) {
        $consul = ejecutarSQL::consultar("update $tabla set $campos where $condicion");
        if (!$consul) {
            die("Ha ocurrido un error al actualizar los datos en la tabla $tabla: " . ejecutarSQL::conectar()->error);
        }
        return $consul;
    }
}
