<?php
require_once 'php/config/db.php';

try {
    $pdo = conectarDB();
    
    // DATOS DE TU USUARIO (CÁMBIALOS SI QUIERES)
    $usuario = 'admin';
    $password = 'strategikaS12XC'; // Contraseña que usarás para entrar
    
    // Encriptamos la contraseña
    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    
    $sql = "INSERT INTO usuarios_admin (usuario, password) VALUES (?, ?)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$usuario, $password_hash]);
    
    echo "<h1>¡Usuario creado con éxito!</h1>";
    echo "<p>Usuario: <strong>$usuario</strong></p>";
    echo "<p>Contraseña: <strong>$password</strong></p>";
    echo "<p>Ahora borra este archivo 'setup_user.php' y ve al login.</p>";

} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>  