<?php
 include '../library/configServer.php';
 include '../library/consulSQL.php';

 sleep(4);

 // Obtener el código del producto a eliminar
 $codigo = $_POST['prod-code'];
 
 // Conectar a la base de datos
 $conexion = mysqli_connect(SERVER, USER, PASS, BD);
 
 // Llamar al procedimiento almacenado
 $query = "CALL EliminarProducto($codigo)"; 
 $resultado = mysqli_query($conexion, $query);
 
 // Mostrar el resultado de la operación
 if (EliminarProducto($codigo) > 0) {
    if(consultasSQL::DeleteSQL('producto', "CodigoProd='".$codigo."'")){
        $carpeta='../assets/img-products/';
        $directorio=$carpeta.$imagen;
        chmod($directorio, 0777);
        unlink($directorio);
        echo '<img src="assets/img/correcto.png" class="center-all-contens"><br><p class="lead text-center">El producto se elimino de la tienda con éxito</p>';
    }else{
        echo '<img src="assets/img/correcto.png" class="center-all-contens"><br><p class="lead text-center">El producto se elimino de la tienda con éxito</p>'; 
    }
 }else{
     echo '<img src="assets/img/correcto.png" class="center-all-contens"><br><p class="lead text-center">El producto se elimino de la tienda con éxito</p>';
 }
 
 // Cerrar la conexión a la base de datos
 mysqli_close($conexion);
 ?>