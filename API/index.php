<?php
require __DIR__ . '/config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $data = json_decode(file_get_contents('php://input'), true);
    $username = trim($data['username'] ?? '');
    $password = trim($data['password'] ?? '');

    if ($username === '' || $password === '') {
        json_out(400, ['success' => false, 'message' => 'Username & password wajib diisi']);
    }

    $stmt = $mysqli->prepare("SELECT id, username, password_hash, full_name, role FROM users WHERE username = ?");
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $user = $stmt->get_result()->fetch_assoc();

    if (!$user || !password_verify($password, $user['password_hash'])) {
        json_out(401, ['success' => false, 'message' => 'Username atau password salah']);
    }

    $token = base64_encode($user['id'] . $user['username']);

    $stmtUpdateToken = $mysqli->prepare("UPDATE users SET token = ? WHERE id = ?");
    $stmtUpdateToken->bind_param("si", $token, $user['id']);
    $stmtUpdateToken->execute();

    json_out(200, [
        'success' => true,
        'message' => 'Login berhasil',
        'data' => [
            'id' => (int) $user['id'],
            'username' => $user['username'],
            'full_name' => $user['full_name'],
            'role' => $user['role'],
            'token' => $token
        ]
    ]);
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $token = $_GET['token'] ?? null; // null kalau tidak ada
    // exit;
   

    if ($token == null || $token == "") {
        json_out(403, ['success' => false, 'message' => 'Unauthorized']);
    }



    $stmt = $mysqli->prepare("SELECT id, username, full_name, role FROM users WHERE token = ?");
    $stmt->bind_param('s', $token);
    $stmt->execute();
    $user = $stmt->get_result()->fetch_assoc();



    if (!$user) {
        json_out(401, [
            'success' => false,
            'message' => 'Unauthorized',
        ]);
    }

    json_out(200, [
        'success' => true,
        'message' => 'Authorized',
        'data' => [
            'id' => $user['id'],
            'username' => $user['username'],
            'full_name' => $user['full_name'],
            'role' => $user['role'],
        ]
    ]);
}
