<?php
// api/arriendos.php
header('Content-Type: application/json');
// Desactiva mostrar errores en pantalla para no romper el JSON
ini_set('display_errors', 0);
error_reporting(E_ALL);

require_once '../admin/php/config/db.php'; 

try {
    $pdo = conectarDB();

    // CASO 1: Detalle de un inmueble (cuando das clic en "Más información")
    if (isset($_GET['id'])) {
        $id = filter_var($_GET['id'], FILTER_VALIDATE_INT);
        
        if (!$id) {
            throw new Exception("ID inválido");
        }

        $stmt = $pdo->prepare("SELECT * FROM inmuebles WHERE id = ?");
        $stmt->execute([$id]);
        $inmueble = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$inmueble) {
            http_response_code(404);
            echo json_encode(['error' => 'Inmueble no encontrado']);
            exit;
        }

        // Traer imágenes
        $stmtImg = $pdo->prepare("SELECT ruta_imagen FROM imagenes_inmueble WHERE inmueble_id = ?");
        $stmtImg->execute([$id]);
        $inmueble['imagenes'] = $stmtImg->fetchAll(PDO::FETCH_COLUMN);

        echo json_encode($inmueble);
    } 
    // CASO 2: Listado de todos (para las tarjetas)
    else {
        $inmuebles = $pdo->query("SELECT * FROM inmuebles ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);
        
        foreach ($inmuebles as &$inm) {
            $stmtImg = $pdo->prepare("SELECT ruta_imagen FROM imagenes_inmueble WHERE inmueble_id = ? LIMIT 1");
            $stmtImg->execute([$inm['id']]);
            $img = $stmtImg->fetchColumn();
            $inm['imagen_principal'] = $img ? $img : null;
        }
        echo json_encode($inmuebles);
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>