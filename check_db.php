<?php
$conn = mysqli_connect('localhost', 'root', '', 'db_resto1');
$result = mysqli_query($conn, "SHOW TABLES");
$tables = [];
while ($row = mysqli_fetch_row($result)) {
    $tables[] = $row[0];
}
$out = "Tables:\n";
$out .= print_r($tables, true);

foreach ($tables as $table) {
    if (strpos($table, 'menu') !== false || strpos($table, 'produk') !== false) {
        $res2 = mysqli_query($conn, "DESCRIBE $table");
        $out .= "\nColumns for $table:\n";
        while ($row = mysqli_fetch_assoc($res2)) {
            $out .= print_r($row, true);
        }
    }
}
file_put_contents('db_out.txt', $out);
?>
