<?php
session_start(); 

include '../library/configServer.php';
include '../library/consulSQL.php';

$num=$_POST['clien-number'];
if($num=='notlog'){
   $nameClien=$_POST['clien-name'];
   $passClien= password_hash($_POST['clien-pass'], PASSWORD_DEFAULT); 
}
if($num=='log'){
   $nameClien=$_POST['clien-name'];
   $passClien=$_POST['clien-pass']; 

}

$miArray = array();

if(isset($miArray['contador'])){
  // Acceso seguro a la clave "contador"
} else {
  // La clave "contador" no está definida en el array
}

$verdata=  ejecutarSQL::consultar("select * from cliente where Clave='".$passClien."' and Nombre='".$nameClien."'", true);
$num=  mysqli_num_rows($verdata);
if($num>0){
  if($_SESSION['sumaTotal']>0){

    $data= mysqli_fetch_array($verdata);
    $rfcC=$data['RFC'];
    $StatusV="Pendiente";
  
    /*Insertando datos en tabla venta*/
    consultasSQL::InsertSQL("venta", "Fecha, RFC, Descuento, TotalPagar, Estado", "'".date('d-m-Y')."','".$rfcC."','0','".$_SESSION['sumaTotal']."','".$StatusV."'");
  
    /*recuperando el número del pedido actual*/
    $verId=ejecutarSQL::consultar("select * from venta where RFC='$rfcC' order by NumPedido desc limit 1", true);
    while($fila=mysqli_fetch_array($verId)){
       $Numpedido=$fila['NumPedido'];
    }
  
    /*Insertando datos en detalle de la venta*/
    for($i = 0;$i< $_SESSION['contador'];$i++){
        consultasSQL::InsertSQL("detalle", "NumPedido, CodigoProd, CantidadProductos", "'$Numpedido', '".$_SESSION['producto'][$i]."', '1'");

        /*Restando un stock a cada producto seleccionado en el carrito*/
        $prodStock=ejecutarSQL::consultar("select * from producto where CodigoProd='".$_SESSION['producto'][$i]."'", true);
        while($fila = mysqli_fetch_array($prodStock)) {
            $existencias = $fila['Stock'];
            consultasSQL::UpdateSQL("producto", "Stock=('$existencias')", "CodigoProd='".$_SESSION['producto'][$i]."'");
            // consultasSQL::UpdateSQL("producto", "Stock=('$existencias'-1)", "CodigoProd='".$_SESSION['producto'][$i]."'");
        }
    }
    
    /*Vaciando el carrito*/
    unset($_SESSION['producto']);
    unset($_SESSION['contador']);
    
    echo '<img src="assets/img/ok.png" class="center-all-contens"><br>El pedido se ha realizado con éxito';
  }else{
    echo '<img src="assets/img/error.png" class="center-all-contens"><br>No has seleccionado ningún producto, revisa el carrito de compras';
  }

}else{
    echo '<img src="assets/img/error.png" class="center-all-contens"><br>El nombre o contraseña invalidos';
}
 


