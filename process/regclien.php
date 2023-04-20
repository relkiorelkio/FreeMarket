<?php
include '../library/configServer.php';
include '../library/consulSQL.php';

sleep(3);
$rfcCliente= $_POST['clien-rfc'];
$nameCliente= $_POST['clien-name'];
$fullnameCliente= $_POST['clien-fullname'];
$apeCliente= $_POST['clien-lastname'];
$passCliente= md5($_POST['clien-pass']); //encrypt password
$dirCliente= $_POST['clien-dir'];
$phoneCliente= $_POST['clien-phone'];
$emailCliente= $_POST['clien-email'];

$conexion = mysqli_connect(SERVER, USER, PASS, BD);

if(!$rfcCliente=="" && !$nameCliente=="" && !$apeCliente=="" && !$dirCliente=="" && !$phoneCliente=="" && !$emailCliente=="" && !$fullnameCliente==""){
    $verificar=  ejecutarSQL::consultar("select * from cliente where RFC='".$rfcCliente."'");
    $verificaltotal = mysqli_num_rows($verificar);
    if($verificaltotal<=0){
        // Inicia transacción
        mysqli_begin_transaction($conexion);

        $insertado = consultasSQL::InsertSQL("cliente", "RFC, Nombre, NombreCompleto, Apellido, Direccion, Clave, Telefono, Email", "'$rfcCliente','$nameCliente','$fullnameCliente','$apeCliente','$dirCliente', '$passCliente','$phoneCliente','$emailCliente'");

        if($insertado){
            // Confirmar transacción
            mysqli_commit($conexion);

            echo '<img src="assets/img/ok.png" class="center-all-contens"><br>El registro se completo con éxito';
        }else{
            // Revertir transacción
            mysqli_rollback($conexion);

            echo '<img src="assets/img/error.png" class="center-all-contens"><br>Ha ocurrido un error.<br>Por favor intente nuevamente'; 
        }
    }else{
        echo '<img src="assets/img/error.png" class="center-all-contens"><br>El RFC que ha ingresado ya esta registrado.<br>Por favor ingrese otro número de RFC';
    }
}else {
    echo '<img src="assets/img/error.png" class="center-all-contens"><br>Error los campos no deben de estar vacíos';
}

mysqli_close($conexion);
?>
