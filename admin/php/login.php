<?php
session_start();
require_once 'php/config/db.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = trim($_POST['usuario']);
    $password = $_POST['password'];

    try {
        $pdo = conectarDB();
        $stmt = $pdo->prepare("SELECT * FROM usuarios_admin WHERE usuario = ?");
        $stmt->execute([$usuario]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
            // Login correcto
            $_SESSION['admin_logged_in'] = true;
            $_SESSION['admin_user'] = $user['usuario'];
            
            // Actualizar último acceso
            $pdo->prepare("UPDATE usuarios_admin SET ultimo_acceso = NOW() WHERE id = ?")->execute([$user['id']]);
            
            header("Location: index.php");
            exit;
        } else {
            $error = "Usuario o contraseña incorrectos.";
        }
    } catch (Exception $e) {
        $error = "Error del sistema.";
    }
}
?>