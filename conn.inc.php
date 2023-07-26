<?php
$conn = new MySQLi(DB["host"],DB["user"],DB["pwd"],DB["db"]);
if($conn->connect_errno>0) {
	die("Fehler im Verbindungsaufbau: " . $conn->error);
}
$conn->set_charset("utf8mb4");
?>