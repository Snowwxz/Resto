<?php
$conn = mysqli_connect('localhost', 'root', '', 'db_resto1');
mysqli_query($conn, "DELETE FROM menus WHERE nama_menu=''");
echo "Deleted empty menus";
?>
