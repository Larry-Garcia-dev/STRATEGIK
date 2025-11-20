<?php
session_start();
require_once 'php/config/db.php';

// Verificar sesión
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit;
}

if (!isset($_GET['id'])) {
    header("Location: index.php?error=noid");
    exit;
}

$id = $_GET['id'];
$pdo = conectarDB();

// Obtener datos del inmueble
$stmt = $pdo->prepare("SELECT * FROM inmuebles WHERE id = ?");
$stmt->execute([$id]);
$inmueble = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$inmueble) {
    die("El inmueble no existe.");
}

// Obtener imágenes actuales
$stmtImg = $pdo->prepare("SELECT * FROM imagenes_inmueble WHERE inmueble_id = ?");
$stmtImg->execute([$id]);
$imagenes = $stmtImg->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Inmueble</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Editar Inmueble: <?= htmlspecialchars($inmueble['titulo']) ?></h1>
            <a href="index.php" class="btn btn-secondary">Volver al Listado</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="acciones.php" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="id" value="<?= $inmueble['id'] ?>">

                    <div class="row">
                        <div class="col-md-2 mb-3">
                            <label class="form-label">Código</label>
                            <input type="text" name="codigo" class="form-control" value="<?= htmlspecialchars($inmueble['codigo']) ?>" required>
                        </div>
                        <div class="col-md-7 mb-3">
                            <label class="form-label">Título</label>
                            <input type="text" name="titulo" class="form-control" value="<?= htmlspecialchars($inmueble['titulo']) ?>" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Precio (Numérico)</label>
                            <input type="number" name="precio" class="form-control" value="<?= htmlspecialchars($inmueble['precio']) ?>" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ubicación</label>
                            <input type="text" name="ubicacion" class="form-control" value="<?= htmlspecialchars($inmueble['ubicacion']) ?>">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Área</label>
                            <input type="text" name="area" class="form-control" value="<?= htmlspecialchars($inmueble['area']) ?>">
                        </div>
                         <div class="col-md-3 mb-3">
                            <label class="form-label">Texto Canon</label>
                            <input type="text" name="canon" class="form-control" value="<?= htmlspecialchars($inmueble['canon_texto']) ?>">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Descripción Corta (Tarjeta)</label>
                        <textarea name="desc_corta" class="form-control" rows="3" required><?= htmlspecialchars($inmueble['descripcion_corta']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Descripción Larga (Detalle)</label>
                        <textarea name="desc_larga" class="form-control" rows="6"><?= htmlspecialchars($inmueble['descripcion_larga']) ?></textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Imágenes Actuales</label>
                        <div class="d-flex gap-2 flex-wrap p-2 bg-white border rounded">
                            <?php if (count($imagenes) > 0): ?>
                                <?php foreach($imagenes as $img): ?>
                                    <div class="position-relative" style="width: 100px;">
                                        <img src="<?= htmlspecialchars($img['ruta_imagen']) ?>" class="img-thumbnail" style="width: 100px; height: 100px; object-fit: cover;">
                                        </div>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <span class="text-muted">Sin imágenes.</span>
                            <?php endif; ?>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-primary">Agregar Más Imágenes (Opcional)</label>
                        <input type="file" name="imagenes[]" class="form-control" multiple accept="image/*">
                        <small class="text-muted">Las imágenes que subas se sumarán a las existentes.</small>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Actualizar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>