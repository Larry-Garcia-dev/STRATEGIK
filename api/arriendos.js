document.addEventListener('DOMContentLoaded', () => {
    cargarInmuebles();
});

async function cargarInmuebles() {
    const container = document.getElementById('arriendos-container');
    if (!container) return;

    try {
        const urlAPI = '../api/arriendos.php'; 
        const response = await fetch(urlAPI);

        if (!response.ok) throw new Error(`Error de conexión: ${response.status}`);

        const texto = await response.text();
        let data;
        try {
            data = JSON.parse(texto);
        } catch (error) {
            console.error("Error JSON:", texto);
            throw new Error("Datos inválidos del servidor.");
        }

        if (data.error) throw new Error(data.error);

        container.innerHTML = ''; 

        if (data.length === 0) {
            container.innerHTML = '<div class="col-12 text-center py-5"><h3>No hay inmuebles registrados.</h3></div>';
            return;
        }

        data.forEach(inm => {
            const precioNum = parseFloat(inm.precio);
            const precioF = new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 }).format(precioNum);
            
            // Manejo de imagen
            let imagen = inm.imagen_principal ? inm.imagen_principal : '../img/home.webp';
            if (!imagen.startsWith('http') && !imagen.startsWith('/')) imagen = '../' + imagen;

            // --- LÓGICA NUEVA PARA ETIQUETAS ---
            
            // 1. Color según Arriendo o Venta
            let colorBadge = '#0d6efd'; // Azul por defecto (Arriendo)
            if (inm.tipo_oferta === 'Venta') {
                colorBadge = '#f38d07'; // Naranja (Venta)
            }

            // 2. Etiqueta de Disponibilidad
            let htmlEstado = '';
            if (inm.estado === 'No Disponible') {
                htmlEstado = `<div class="position-absolute top-0 start-0 m-3 badge bg-danger shadow-sm">NO DISPONIBLE</div>`;
            } else {
                htmlEstado = `<div class="position-absolute top-0 start-0 m-3 badge bg-success shadow-sm">DISPONIBLE</div>`;
            }

            const card = `
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="property-card h-100 shadow-sm border-0">
                    <div class="property-image position-relative overflow-hidden">
                        <img src="${imagen}" alt="${inm.titulo}" class="img-fluid w-100" style="height: 250px; object-fit: cover; transition: transform 0.3s;" onerror="this.src='https://via.placeholder.com/400x300?text=Sin+Imagen'">
                        
                        <div class="property-badge position-absolute top-0 end-0 m-3 badge shadow-sm" style="background-color:${colorBadge}; font-size: 0.9rem;">
                            ${inm.tipo_oferta}
                        </div>

                        ${htmlEstado}
                    </div>

                    <div class="property-content p-4 bg-white">
                        <h3 class="property-title h5 fw-bold mb-2 text-dark text-truncate">${inm.titulo}</h3>
                        <p class="property-location text-muted mb-1 small"><i class="fas fa-map-marker-alt me-2 text-primary"></i> ${inm.ubicacion}</p>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <small class="text-muted"><i class="fas fa-ruler-combined me-1 text-primary"></i> ${inm.area}</small>
                            <small class="text-muted">Ref: ${inm.codigo}</small>
                        </div>
                        
                        <p class="text-primary fw-bold fs-5 mb-3">${precioF}</p>
                        
                        <p class="small text-muted mb-4" style="min-height: 40px;">
                            ${inm.descripcion_corta ? inm.descripcion_corta.substring(0, 90) + '...' : ''}
                        </p>
                        
                        <button onclick="verDetalle(${inm.id})" class="btn btn-outline-primary w-100 rounded-pill" data-bs-toggle="modal" data-bs-target="#detalleModal">
                            Ver Detalles
                        </button>
                    </div>
                </div>
            </div>`;
            container.innerHTML += card;
        });

    } catch (error) {
        console.error(error);
        container.innerHTML = `<div class="col-12 text-center text-danger py-5">Error cargando inmuebles: ${error.message}</div>`;
    }
}

async function verDetalle(id) {
    try {
        const response = await fetch(`../api/arriendos.php?id=${id}`);
        if(!response.ok) throw new Error("Error al cargar detalle");

        const data = await response.json();

        // Datos Básicos
        document.getElementById('modalTitulo').innerText = data.titulo;
        
        const precioF = new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 }).format(data.precio);
        const precioMostrar = data.canon_texto ? data.canon_texto : precioF;
        
        // Puedes agregar lógica aquí si tienes elementos en el modal para mostrar "Estado"
        // Ej: document.getElementById('modalEstado').innerText = data.estado;
        
        document.getElementById('modalPrecio').innerText = precioMostrar;
        document.getElementById('modalDescripcion').innerText = data.descripcion_larga || "Sin descripción detallada.";
        document.getElementById('modalUbicacion').innerText = data.ubicacion;
        document.getElementById('modalCodigo').innerText = 'Cód: ' + (data.codigo || 'N/A');

        // ---------------------------------------------------------
        // WHATSAPP DINÁMICO
        // ---------------------------------------------------------
        const btnWhatsapp = document.getElementById('btnWhatsapp');
        if (btnWhatsapp) {
            const telefono = "573144262626"; // TU NUMERO AQUÍ
            
            // Personalizamos el mensaje dependiendo si es Venta o Arriendo
            const accion = data.tipo_oferta === 'Venta' ? 'comprar' : 'arrendar';
            
            const mensaje = `Hola, estoy interesado en ${accion} el siguiente inmueble:
*Inmueble:* ${data.titulo}
*Operación:* ${data.tipo_oferta}
*Código:* ${data.codigo || 'N/A'}
*Ubicación:* ${data.ubicacion}
*Precio:* ${document.getElementById('modalPrecio').innerText}

¿Está disponible actualmente? Quedo atento.`;

            const url = `https://api.whatsapp.com/send?phone=${telefono}&text=${encodeURIComponent(mensaje)}`;
            btnWhatsapp.href = url;
        }

        // Galería de Imágenes
        const carouselInner = document.getElementById('carouselImgs');
        carouselInner.innerHTML = '';
        
        if(data.imagenes && data.imagenes.length > 0){
            data.imagenes.forEach((img, index) => {
                const activeClass = index === 0 ? 'active' : '';
                let rutaImg = img;
                if (!rutaImg.startsWith('http') && !rutaImg.startsWith('/')) rutaImg = '../' + rutaImg;

                carouselInner.innerHTML += `
                <div class="carousel-item ${activeClass}">
                    <img src="${rutaImg}" class="d-block w-100" style="height: 400px; object-fit: contain; background-color: #f8f9fa;" onerror="this.src='https://via.placeholder.com/800x400?text=Error+Imagen'">
                </div>`;
            });
        } else {
            let imgP = data.imagen_principal || 'https://via.placeholder.com/800x400?text=Sin+Galeria';
            if (!imgP.startsWith('http') && !imgP.startsWith('/')) imgP = '../' + imgP;

            carouselInner.innerHTML = `
             <div class="carousel-item active">
                <img src="${imgP}" class="d-block w-100" style="height: 400px; object-fit: contain; background-color: #f8f9fa;">
             </div>`;
        }

    } catch (error) {
        console.error(error);
        alert("No se pudo cargar el detalle del inmueble.");
    }
}