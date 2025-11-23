<?php 
include_once "php/login.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Strategik Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f57e12; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-card { width: 100%; max-width: 400px; padding: 30px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); background: white; }
        .btn-primary { background-color: #000; border: none; }
        .btn-primary:hover { background-color: #333; }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="text-center mb-4">
            <img src="../img/Imagotipo_Negro.png" alt="Logo" style="max-width: 150px;">
            <h4 class="mt-3">Acceso Administrativo</h4>
        </div>
        
        <?php if($error): ?>
            <div class="alert alert-danger"><?= $error ?></div>
        <?php endif; ?>

        <form method="POST">
            <div class="mb-3">
                <label>Usuario</label>
                <input type="text" name="usuario" class="form-control" required autofocus>
            </div>
            <div class="mb-3">
                <label>Contraseña</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2">Ingresar</button>
        </form>
        <div class="text-center mt-3">
            <a href="../index.html" class="text-muted text-decoration-none"><small>← Volver al sitio web</small></a>
        </div>
    </div>
</body>
</html>