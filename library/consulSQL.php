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

class ConexionPDO {
    private static $conexion;
  
    public static function conectar() {
      $usuario = "root";
      $password = "";
      $host = "localhost:3307";
      $nombreBaseDatos = "store";
  
      try {
        self::$conexion = new PDO("mysql:host=$host;dbname=$nombreBaseDatos", $usuario, $password);
        self::$conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        self::$conexion->exec("SET CHARACTER SET utf8");
      } catch (PDOException $e) {
        die("Error de conexión: " . $e->getMessage());
      }
    }
  
    public static function desconectar() {
      self::$conexion = null;
    }
  
    public static function obtenerConexion() {
      if (!self::$conexion) {
        self::conectar();
      }
  
      return self::$conexion;
    }
  }
  
function EliminarProducto($codeProd) {
    $pdo = ConexionPDO::obtenerConexion();
    $stmt = $pdo->prepare("CALL EliminarProducto(?)");
    $stmt->bindParam(1, $codeProd, PDO::PARAM_INT);
    $stmt->execute();
    $rowCount = $stmt->rowCount();
    return $rowCount;
  }
  
