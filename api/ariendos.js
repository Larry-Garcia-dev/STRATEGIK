document.addEventListener('DOMContentLoaded', () => {
    cargarInmuebles();
});

async function cargarInmuebles() {
    const container = document.getElementById('arriendos-container');
    
    // Validación por si el script se carga en una página sin el contenedor
    if (!container) return;

    try {
        // IMPORTANTE: Como el HTML está en la carpeta 'Inmobiliaria', debemos salir (..) 
        // y entrar a 'api' para encontrar el archivo PHP.
        const urlAPI = '../api/arriendos.php'; 
        
        const response = await fetch(urlAPI);

        if (!response.ok) {
            throw new Error(`Error de conexión: ${response.status} ${response.statusText}`);
        }

        // Intentamos obtener el texto primero para depurar si no es JSON
        const texto = await response.text();
        let data;
        
        try {
            data = JSON.parse(texto);
        } catch (error) {
            console.error("Respuesta del servidor no es JSON:", texto);
            throw new Error("El servidor devolvió datos incorrectos. Revisa la consola.");
        }

        // Verificar si el backend envió un error lógico
        if (data.error) {
            throw new Error(data.error);
        }

        container.innerHTML = ''; // Limpiar el "Cargando..."

        if (data.length === 0) {
            container.innerHTML = '<div class="col-12 text-center py-5"><h3>No hay inmuebles disponibles por el momento.</h3></div>';
            return;
        }

        // Generar las tarjetas
        data.forEach(inm => {
            // Formatear precio a pesos colombianos sin decimales
            const precioNumero = parseFloat(inm.precio);
            const precioF = new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 }).format(precioNumero);
            
            // Definir imagen (usando ruta relativa correcta si viene de uploads)
            // Si la ruta en BD es "/uploads/...", al estar en "Inmobiliaria" necesitamos subir un nivel ".."
            // Pero si tu servidor maneja rutas absolutas desde la raíz, "/" funciona.
            // Usaremos un truco para asegurar que cargue:
            let imagen = inm.imagen_principal ? inm.imagen_principal : '/placeholder.svg';
            // Si la imagen no empieza con http y no empieza con /, le agregamos ../ por si acaso
            if (!imagen.startsWith('http') && !imagen.startsWith('/')) {
                imagen = '../' + imagen;
            }

            const card = `
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="property-card animate-on-scroll h-100 shadow-sm">
                    <div class="property-image position-relative">
                        <img src="${imagen}" alt="${inm.titulo}" class="img-fluid w-100" style="height: 250px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/400x300?text=Sin+Imagen'">
                        <div class="property-badge rent position-absolute top-0 end-0 m-3 badge bg-success">En Arriendo</div>
                    </div>
                    <div class="property-content p-4">
                        <h3 class="property-title h5 fw-bold mb-2 text-dark">${inm.titulo}</h3>
                        <p class="property-location text-muted mb-1"><i class="fas fa-map-marker-alt me-2 text-primary"></i> ${inm.ubicacion}</p>
                        <p class="property-area text-muted mb-3"><i class="fas fa-ruler-combined me-2 text-primary"></i> ${inm.area}</p>
                        <p class="text-primary fw-bold fs-5 mb-3">${precioF}</p>
                        <p class="small text-muted mb-4">${inm.descripcion_corta ? inm.descripcion_corta.substring(0, 90) + '...' : ''}</p>
                        
                        <button onclick="verDetalle(${inm.id})" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#detalleModal">
                            Más Información
                        </button>
                    </div>
                </div>
            </div>
            `;
            container.innerHTML += card;
        });

    } catch (error) {
        console.error('Error cargando inmuebles:', error);
        container.innerHTML = `
            <div class="col-12 text-center text-danger py-5">
                <i class="fas fa-exclamation-circle fa-3x mb-3"></i>
                <h4>Ocurrió un error cargando los datos</h4>
                <p>${error.message}</p>
                <small>Intenta recargar la página.</small>
            </div>`;
    }
}

async function verDetalle(id) {
    try {
        // Misma ruta relativa para el detalle
        const response = await fetch(`../api/arriendos.php?id=${id}`);
        if(!response.ok) throw new Error("Error al cargar detalle");

        const data = await response.json();

        // Llenar modal
        document.getElementById('modalTitulo').innerText = data.titulo;
        // Usar el texto del canon si existe, si no el precio formateado
        const precioF = new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 }).format(data.precio);
        document.getElementById('modalPrecio').innerText = data.canon_texto ? data.canon_texto : precioF;
        
        document.getElementById('modalDescripcion').innerText = data.descripcion_larga || "Sin descripción detallada.";
        document.getElementById('modalUbicacion').innerText = data.ubicacion;
        document.getElementById('modalCodigo').innerText = 'Cód: ' + (data.codigo || 'N/A');

        // Galería
        const carouselInner = document.getElementById('carouselImgs');
        carouselInner.innerHTML = '';
        
        if(data.imagenes && data.imagenes.length > 0){
            data.imagenes.forEach((img, index) => {
                const activeClass = index === 0 ? 'active' : '';
                // Asegurar ruta de imagen
                let rutaImg = img;
                if (!rutaImg.startsWith('http') && !rutaImg.startsWith('/')) rutaImg = '../' + rutaImg;

                const item = `
                <div class="carousel-item ${activeClass}">
                    <img src="${rutaImg}" class="d-block w-100" alt="Imagen ${index}" style="height: 400px; object-fit: contain; background-color: #f0f0f0;" onerror="this.src='https://via.placeholder.com/800x400?text=Error+Cargando+Imagen'">
                </div>`;
                carouselInner.innerHTML += item;
            });
        } else {
            // Si no hay imágenes en galería, usar la principal
            let imgP = data.imagen_principal || 'https://via.placeholder.com/800x400?text=Sin+Galeria';
            if (!imgP.startsWith('http') && !imgP.startsWith('/')) imgP = '../' + imgP;

            carouselInner.innerHTML = `
             <div class="carousel-item active">
                <img src="${imgP}" class="d-block w-100" style="height: 400px; object-fit: contain; background-color: #f0f0f0;">
             </div>`;
        }

    } catch (error) {
        console.error(error);
        alert("No se pudo cargar el detalle del inmueble.");
    }
}