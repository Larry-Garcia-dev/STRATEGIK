<?php

session_start();
// Si no existe la variable de sesión, mandar al login
if (!isset($_SESSION['admin_logged_in']) || $_SESSION['admin_logged_in'] !== true) {
    header("Location: login.php");
    exit;
}

require_once 'php/config/db.php';
$pdo = conectarDB();
// ... resto de tu código ...
$inmuebles = $pdo->query("SELECT * FROM inmuebles ORDER BY id DESC")->fetchAll();
?>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h1>Gestión de Arriendos</h1>
    <div class="d-flex align-items-center gap-3">
        <span>Hola, <b><?= htmlspecialchars($_SESSION['admin_user']) ?></b></span>
        <a href="logout.php" class="btn btn-outline-danger btn-sm">Cerrar Sesión</a>
    </div>
</div>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Administrador de Arriendos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-4 bg-light">
    <div class="container">

        <div class="card mb-5">
            <div class="card-header bg-primary text-white">Nuevo Inmueble</div>
            <div class="card-body">
                <form action="acciones.php" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="accion" value="crear">
                    <div class="row">
                        <div class="col-md-2 mb-3">
                            <label>Código</label>
                            <input type="text" name="codigo" class="form-control" placeholder="Ej: 32" required>
                        </div>
                        <div class="col-md-7 mb-3">
                            <label>Título</label>
                            <input type="text" name="titulo" class="form-control" placeholder="Ej: LOCAL 111..." required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Precio (Numérico)</label>
                            <input type="number" name="precio" class="form-control" placeholder="2500000" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Ubicación</label>
                            <input type="text" name="ubicacion" class="form-control" placeholder="Ej: Centro Comercial La Once">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Área</label>
                            <input type="text" name="area" class="form-control" placeholder="Ej: 50 M2">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Texto Canon</label>
                            <input type="text" name="canon" class="form-control" placeholder="Ej: $2.500.000+IVA">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label>Detalles Cortos (Para la tarjeta)</label>
                        <textarea name="desc_corta" class="form-control" rows="3" required>Excelente ubicación con alto flujo peatonal. Espacios iluminados...</textarea>
                    </div>
                    <div class="mb-3">
                        <label>Descripción Larga (Para ver más info)</label>
                        <textarea name="desc_larga" class="form-control" rows="5">Se arrienda local amplio ideal para negocio...</textarea>
                    </div>
                    <div class="mb-3">
                        <label>Imágenes (Máx 10)</label>
                        <input type="file" name="imagenes[]" class="form-control" multiple accept="image/*">
                        <small class="text-muted">Seleccione hasta 10 imágenes presionando Ctrl.</small>
                    </div>
                    <button type="submit" class="btn btn-success">Guardar Inmueble</button>
                </form>
            </div>
        </div>

        <h3>Inmuebles Registrados</h3>
        <table class="table table-striped bg-white">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Título</th>
                    <th>Precio</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($inmuebles as $inm): ?>
                    <tr>
                        <td><?= $inm['id'] ?></td>
                        <td><?= $inm['codigo'] ?></td>
                        <td><?= $inm['titulo'] ?></td>
                        <td>$<?= number_format($inm['precio'], 0) ?></td>

                        <td>
                            <a href="editar.php?id=<?= $inm['id'] ?>" class="btn btn-warning btn-sm me-2">
                                Editar
                            </a>
                            <a href="acciones.php?accion=eliminar&id=<?= $inm['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro?')">Eliminar</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</body>

</html>