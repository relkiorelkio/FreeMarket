<?php
session_start();
include '../library/configServer.php';
include '../library/consulSQL.php';

sleep(5);
$rfcProve= $_POST['rfc-prove'];
$cons=  ejecutarSQL::consultar("select * from proveedor where RFCProveedor='$rfcProve'");
$totalprove = mysqli_num_rows($cons);

if($totalprove>0){
    if(consultasSQL::DeleteSQL('proveedor', "RFCProveedor='".$rfcProve."'")){
        echo '<img src="assets/img/correcto.png" class="center-all-contens"><br><p class="lead text-center">Proveedor eliminado éxitosamente</p>';
    }else{
       echo '<img src="assets/img/incorrecto.png" class="center-all-contens"><br><p class="lead text-center">Ha ocurrido un error.<br>Por favor intente nuevamente</p>'; 
    }
}else{
    echo '<img src="assets/img/incorrecto.png" class="center-all-contens"><br><p class="lead text-center">El código de proveedor no existe</p>';
}