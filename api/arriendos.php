<?php
// api/arriendos.php
header('Content-Type: application/json');
// Ajusta la ruta para llegar a db.php desde la carpeta api
require_once '../admin/php/config/db.php'; 

try {
    $pdo = conectarDB();

    // Si piden un ID especifico (para el detalle)
    if (isset($_GET['id'])) {
        $stmt = $pdo->prepare("SELECT * FROM inmuebles WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        $inmueble = $stmt->fetch();

        // Traer imágenes
        $stmtImg = $pdo->prepare("SELECT ruta_imagen FROM imagenes_inmueble WHERE inmueble_id = ?");
        $stmtImg->execute([$_GET['id']]);
        $inmueble['imagenes'] = $stmtImg->fetchAll(PDO::FETCH_COLUMN);

        echo json_encode($inmueble);
    } 
    // Si piden todos (para la lista)
    else {
        $inmuebles = $pdo->query("SELECT * FROM inmuebles ORDER BY id DESC")->fetchAll();
        
        // Añadir la imagen principal a cada uno
        foreach ($inmuebles as &$inm) {
            $stmtImg = $pdo->prepare("SELECT ruta_imagen FROM imagenes_inmueble WHERE inmueble_id = ? LIMIT 1");
            $stmtImg->execute([$inm['id']]);
            $img = $stmtImg->fetchColumn();
            // Si no hay imagen, usa el placeholder
            $inm['imagen_principal'] = $img ? $img : '/placeholder.svg?height=300&width=400';
        }
        echo json_encode($inmuebles);
    }

} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>