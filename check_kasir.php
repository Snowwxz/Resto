<?php
$conn = mysqli_connect('localhost', 'root', '', 'db_resto1');
$tables = ['orderans', 'detail_orderans', 'mejas'];
$out = "";
foreach ($tables as $table) {
    $out .= "Columns for $table:\n";
    $res = mysqli_query($conn, "DESCRIBE $table");
    if($res) {
        while ($row = mysqli_fetch_assoc($res)) {
            $out .= print_r($row, true);
        }
    }
    $out .= "\n";
}
file_put_contents('kasir_schema.txt', $out);
?>
