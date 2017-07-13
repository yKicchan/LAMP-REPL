<?php
$master  = new mysqli('master', 'user', 'password', 'database');
$replica = new mysqli('replica', 'user', 'password', 'database');

$sql = "INSERT INTO user (name) VALUES ('".gethostname()."')";
$master->query($sql);

$sql = "SELECT id, host FROM test";
if ($result = $replica->query($sql)) {
    while ($row = $result->fetch_assoc()) {
        echo "{$row['id']}: {$row['host']}<br>";
    }
    $result->close();
}

$master->close();
$replica->close();
