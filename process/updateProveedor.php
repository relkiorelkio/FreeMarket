<?php
include '../library/configServer.php';
include '../library/consulSQL.php';

sleep(5);

$rfcOldProveUp=$_POST['rfc-prove-old'];
$rfcProveUp=$_POST['rfc-prove'];
$nameProveUp=$_POST['prove-name'];
$dirProveUp=$_POST['prove-dir'];
$telProveUp=$_POST['prove-tel'];
$webProveUp=$_POST['prove-web'];

if(consultasSQL::UpdateSQL("proveedor", "RFCProveedor='$rfcProveUp',NombreProveedor='$nameProveUp',Direccion='$dirProveUp',Telefono='$telProveUp',PaginaWeb='$webProveUp'", "RFCProveedor='$rfcOldProveUp'")){
    echo '
    <br>
    <img class="center-all-contens" src="assets/img/Check.png">
    <p><strong>Hecho</strong></p>
    <p class="text-center">
        Recargando<br>
        en 7 segundos
    </p>
    <script>
        setTimeout(function(){
        url ="configAdmin.php";
        $(location).attr("href",url);
        },7000);
    </script>
 ';
}else{
    echo '
    <br>
    <img class="center-all-contens" src="assets/img/cancel.png">
    <p><strong>Error</strong></p>
    <p class="text-center">
        Recargando<br>
        en 7 segundos
    </p>
    <script>
        setTimeout(function(){
        url ="configAdmin.php";
        $(location).attr("href",url);
        },7000);
    </script>
 ';
}