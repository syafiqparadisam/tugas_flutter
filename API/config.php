<?php

declare(strict_types=1);
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST, OPTIONS');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
	http_response_code(204);
	exit;
}

$host = '127.0.0.1';
$db = 'db_flutter1';
$user = 'root';
$pass = 'root';

$mysqli = new mysqli($host, $user, $pass, $db, 3306);
if ($mysqli->connect_errno) {
	http_response_code(500);
	echo json_encode(['success' => false, 'message' => 'Gagal koneksi database']);
	exit;
}
$mysqli->set_charset('utf8mb4');

function json_out(int $code, array $payload): void
{
	http_response_code($code);
	echo json_encode($payload, JSON_UNESCAPED_UNICODE);
	exit;
}