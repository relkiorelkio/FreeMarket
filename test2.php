<!-- Actualizar Datos del PRODUCTO -->
<div class="col-xs-12">
    <br><br>
    <div class="panel panel-info">
        <div class="panel-heading text-center"><i class="fa fa-refresh fa-2x"></i><h3>Actualizar datos de producto</h3></div>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="">
                    <tr>
                        <th class="text-center">Código</th>
                        <th class="text-center">Nombre</th>
                        <th class="text-center">Categoría</th>
                        <th class="text-center">Precio</th>
                        <th class="text-center">Modelo</th>
                        <th class="text-center">Marca</th>
                        <th class="text-center">Unidades</th>
                        <th class="text-center">Proveedor</th>
                        <th class="text-center">Opciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $productos=  ejecutarSQL::consultar("select * from producto");
                    $upr=1;
                    while($prod=mysqli_fetch_array($productos)){
                        echo '
                        <tr>
                            <form method="post" action="process/updateProduct.php" id="res-update-product-'.$upr.'">
                                <td>
                                    <input class="form-control" type="hidden" name="code-old-prod" required="" value="'.$prod['CodigoProd'].'">
                                    <input class="form-control" type="text" name="code-prod" maxlength="30" required="" value="'.$prod['CodigoProd'].'">
                                </td>
                                <td><input class="form-control" type="text" name="prod-name" maxlength="30" required="" value="'.$prod['NombreProd'].'"></td>
                                <td>';
                                    $categoriac3=  ejecutarSQL::consultar("select * from categoria where CodigoCat='".$prod['CodigoCat']."'");
                                    while($catec3=mysqli_fetch_array($categoriac3)){
                                        $codeCat=$catec3['CodigoCat'];
                                        $nameCat=$catec3['Nombre'];
                                    }
                                    echo '<select class="form-control" name="prod-category">';
                                    echo '<option value="'.$codeCat.'">'.$nameCat.'</option>';
                                    $categoriac2=  ejecutarSQL::consultar("select * from categoria");
                                    while($catec2=mysqli_fetch_array($categoriac2)){
                                        if($catec2['CodigoCat']==$codeCat){
                                            
                                        }else{
                                            echo '<option value="'.$catec2['CodigoCat'].'">'.$catec2['Nombre'].'</option>';  
                                        }

                                    }
                                    echo '</select>
                                </td>
                                <td><input class="form-control" type="text" name="price-prod" required="" value="'.$prod['Precio'].'"></td>
                                <td><input class="form-control" type="tel" name="model-prod" required="" maxlength="20" value="'.$prod['Modelo'].'"></td>
                                <td><input class="form-control" type="text" name="marc-prod" maxlength="30" required="" value="'.$prod['Marca'].'"></td>
                                <td><input class="form-control" type="text" name="stock-prod" maxlength="30" required="" value="'.$prod['Stock'].'"></td>
                                <td>';
                                    
