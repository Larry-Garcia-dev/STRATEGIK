<?php
// admin/acciones.php
session_start();
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit;
}
require_once 'php/config/db.php';
$pdo = conectarDB();

$accion = $_POST['accion'] ?? $_GET['accion'] ?? '';

if ($accion == 'crear' || $accion == 'editar') {
    $titulo = $_POST['titulo'];
    $codigo = $_POST['codigo'];
    $precio = $_POST['precio'];
    $ubicacion = $_POST['ubicacion'];
    $area = $_POST['area'];
    $canon = $_POST['canon'];
    $desc_corta = $_POST['desc_corta'];
    $desc_larga = $_POST['desc_larga'];
    $estado = 'Disponible';
    
    if ($accion == 'crear') {
        $sql = "INSERT INTO inmuebles (codigo, titulo, precio, descripcion_corta, descripcion_larga, ubicacion, area, canon_texto, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$codigo, $titulo, $precio, $desc_corta, $desc_larga, $ubicacion, $area, $canon, $estado]);
        $inmueble_id = $pdo->lastInsertId();
    } else {
        $id = $_POST['id'];
        $sql = "UPDATE inmuebles SET codigo=?, titulo=?, precio=?, descripcion_corta=?, descripcion_larga=?, ubicacion=?, area=?, canon_texto=? WHERE id=?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$codigo, $titulo, $precio, $desc_corta, $desc_larga, $ubicacion, $area, $canon, $id]);
        $inmueble_id = $id;
    }

    // Manejo de Imágenes (Máximo 10)
    if (!empty($_FILES['imagenes']['name'][0])) {
        $total = count($_FILES['imagenes']['name']);
        // Verificar límite de 10 se hace en el front o contando en DB, aquí procesamos las que llegan
        for ($i = 0; $i < $total; $i++) {
            if ($i >= 10) break; // Seguridad extra
            
            $tmpFilePath = $_FILES['imagenes']['tmp_name'][$i];
            if ($tmpFilePath != "") {
                $newFilePath = "../uploads/" . uniqid() . "_" . $_FILES['imagenes']['name'][$i];
                if (move_uploaded_file($tmpFilePath, $newFilePath)) {
                    // Guardar ruta relativa en BD para que sea accesible desde web
                    $webPath = "/uploads/" . basename($newFilePath);
                    $stmtImg = $pdo->prepare("INSERT INTO imagenes_inmueble (inmueble_id, ruta_imagen) VALUES (?, ?)");
                    $stmtImg->execute([$inmueble_id, $webPath]);
                }
            }
        }
    }
    
    header("Location: index.php?msg=guardado");
}

if ($accion == 'eliminar') {
    $id = $_GET['id'];

    try {
        // 1. Obtener las rutas de las imágenes antes de borrar el registro
        $stmtImgs = $pdo->prepare("SELECT ruta_imagen FROM imagenes_inmueble WHERE inmueble_id = ?");
        $stmtImgs->execute([$id]);
        $imagenes = $stmtImgs->fetchAll(PDO::FETCH_COLUMN);

        // 2. Eliminar los archivos físicos del servidor
        foreach ($imagenes as $rutaWeb) {
            // Convertir ruta web (/uploads/imagen.jpg) a ruta de sistema de archivos (../uploads/imagen.jpg)
            // Asumiendo que 'acciones.php' está en 'admin/' y las fotos en 'uploads/' (un nivel arriba)
            
            // Quitamos la barra inicial si existe para evitar doble slash
            $rutaRelativa = ".." . $rutaWeb; 
            
            if (file_exists($rutaRelativa)) {
                unlink($rutaRelativa); // Esta función borra el archivo
            }
        }

        // 3. Eliminar el registro de la base de datos
        // (Por la restricción ON DELETE CASCADE, esto borrará también las filas en la tabla 'imagenes_inmueble')
        $stmt = $pdo->prepare("DELETE FROM inmuebles WHERE id = ?");
        $stmt->execute([$id]);

        header("Location: index.php?msg=eliminado_ok");
    } catch (Exception $e) {
        // Si algo falla, redirigir con error (opcional: guardar log)
        header("Location: index.php?msg=error_eliminar");
    }
}
?>