<?php

$master  = new mysqli('master', 'user', 'password', 'database');
$replica = new mysqli('replica', 'user', 'password', 'database');

$sql = "INSERT INTO `test` (`time`) VALUES ('".date('Y/m/d H:i:s')."')";
$master->query($sql);

$sql = "SELECT * FROM `test`";
if ($result = $replica->query($sql)) {
    while ($row = $result->fetch_assoc()) {
        echo "{$row['id']}回目の接続: {$row['time']}<br>";
    }
    $result->close();
}

$master->close();
$replica->close();
