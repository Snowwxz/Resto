<?php
$conn = mysqli_connect('localhost', 'root', '', 'db_resto1');
$out = "Columns for users:\n";
$res = mysqli_query($conn, "DESCRIBE users");
while ($row = mysqli_fetch_assoc($res)) {
    $out .= print_r($row, true);
}
$out .= "\nColumns for karyawans:\n";
$res2 = mysqli_query($conn, "DESCRIBE karyawans");
while ($row = mysqli_fetch_assoc($res2)) {
    $out .= print_r($row, true);
}
file_put_contents('users_schema.txt', $out);
?>
