<?php
$conn = mysqli_connect('localhost', 'root', '', 'db_resto1');
$query = mysqli_query($conn, "SELECT * FROM menus ORDER BY id DESC LIMIT 5");
$data = [];
while($row = mysqli_fetch_assoc($query)) {
    $data[] = $row;
}
file_put_contents('db_out2.txt', print_r($data, true));
?>
