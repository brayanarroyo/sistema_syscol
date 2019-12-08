var seleccion = "";
var costo_material = 0.0;
var material = "";
var contacto = 1;
var usuario = 1;
$(document).ready(function(){

	function filas_detalle_pendientes(id_cliente,nombre,domicilio,telefono,fecha,hora_visita,estatus,tipo_servicio) {
		return `<tr>
		<td>Cliente</td>
		<td>${id_cliente}</td>
		</tr>
		<tr>
		<td>Nombre</td>
		<td>${nombre}</td>
		</tr>
		<tr>
		<td>Domicilio</td>
		<td>${domicilio}</td>
		</tr>
		<tr>
		<td>Teléfono</td>
		<td>${telefono}</td>
		</tr>
		<tr>
		<td>Fecha de visita prevista</td>
		<td>${fecha}</td>
		</tr>
		<tr>
		<td>Hora de visita prevista</td>
		<td>${hora_visita}</td>
		</tr>
		<tr>
		<td>Estatus</td>
		<td>${estatus}</td>
		</tr>
		<tr>
		<td>Servicio</td>
		<td>${tipo_servicio}</td>
		</tr>`
	}

async function modal_detalle_pendientes(route, body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	const result = await response.json()
	console.log(result);
	let tbody = $('#modal_detalle') 
		$.each(result.data, (i,row) => {
			$(filas_detalle_pendientes(row.id_cliente,row.nombre,row.domicilio,row.telefono,row.fecha,row.hora_visita,row.estatus,row.tipo_servicio)).appendTo(tbody)
		}) 
		return result.error
	return result.data

}

async function proceder_elemento_seleccionado(route, body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	const result = await response.json()
	console.log(result);
	$.each(result.data, (i,row) => {
		const estatus = row.estatus;
		const tipo = $('#solicitud option:selected').text();
		switch(tipo){
			case "Nuevo cliente":
			switch(estatus){
				case "sin cotizar":
					$('.secciones article').hide();
					$('#form_cotizar').show();
					cotizacion('/pendientes/cobranza/generar',{
						id_elemento: seleccion
					})
				break;
				case "cotizado":
					$('.secciones article').hide();
					$('#ciz').show();
					$('#form_cliente').show();
					autocompletar_cliente('/pendientes/cobranza/cliente/autocomplentar',{
						id_elemento: seleccion
					})
				break;
				} 
			break;
			case "Nuevo inmueble":
			switch(estatus){
				case "sin cotizar":
					$('.secciones article').hide();
					$('#form_cotizar').show();
					cotizacion('/pendientes/cobranza/generar',{
						id_elemento: seleccion
					})
				break;
				case "cotizado":
					$('.secciones article').hide();
					$('#ciz').show();
					autocompletar_cliente('/pendientes/cobranza/cliente/autocomplentar',{
						id_elemento: seleccion
					})
				break;
				} 
			break;
			case "Nuevo servicio":
			switch(estatus){
				case "sin cotizar":
					$('.secciones article').hide();
					$('#form_cotizar').show();
					cotizacion('/pendientes/cobranza/generar',{
						id_elemento: seleccion
					})
				break;
				case "cotizado":
					$('.secciones article').hide();
					$('#ciz').show();
					autocompletar_cliente('/pendientes/cobranza/cliente/autocomplentar',{
						id_elemento: seleccion
					})
				break;
				case "pendiente de mantenimiento":
					$('.secciones article').hide();
					$('#atender_mante').show();
					mostrar_solicitud();
				break;
				case "pendiente de monitoreo":
					$('.secciones article').hide();
					$('#usu_cont').show();
					$('#form_Usuarios').show();
				break;
				} 
		}
	}) 
	return result.data
}

//Métodos para el llenado de las tablas
async function autocompletar_cliente(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	$.each(result.data, (i,row) => {
		$('#nombre_fc_ciz').val(row.nombre_completo),
		$('#apellido_p_fc_ciz').val(row.apellido_p),
		$('#apellido_m_fc_ciz').val(row.apellido_m),
		$('#telefono_fc_ciz').val(row.telefono),
		$('#calle_fi_ciz').val(row.calle),
		$('#num_ext_fi_ciz').val(row.numero),
		$('#colonia_fi_ciz').val(row.colonia)
	}) 
	return result.error
}

function filas_tabla_solicitud_mantenimiento() {
	return `<tr>
		<td>Clave de solicitud</td>
		<td>${seleccion}</td>
	</tr>`
}
	
async function mostrar_solicitud() {
	let tbody = $('#tbody_solicitud_mantenimiento') 
	$(filas_tabla_solicitud_mantenimiento()).appendTo(tbody)
}

//Métodos para el llenado de las tablas
function filas_tabla_nuevo_cliente(id_solicitud, nombre_completo, fecha, hora, estatus) {
	return `<tr id="${id_solicitud}">
			<td>${nombre_completo}</td>
			<td>${fecha}</td>
			<td>${hora}</td>
			<td>${estatus}</td>
	</tr>`
}
	
async function llenar_tabla_nuevo_cliente(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tbody = $('#tbody_pendientes') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_nuevo_cliente(row.id_solicitud, row.nombre_completo, row.fecha, row.hora_visita, row.estatus)).appendTo(tbody)
	}) 
	return result.error
}

function filas_tabla_nuevo_inmueble(id_solicitud, nombre_completo, fecha, hora, estatus) {
	return `<tr id="${id_solicitud}">
			<td>${nombre_completo}</td>
			<td>${fecha}</td>
			<td>${hora}</td>
			<td>${estatus}</td>
	</tr>`
}

	
async function llenar_tabla_nuevo_inmueble(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tbody = $('#tbody_pendientes') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_nuevo_inmueble(row.id_solicitud, row.nombre, row.fecha, row.hora_visita, row.estatus)).appendTo(tbody)
	}) 
	return result.error
}

function filas_tabla_nuevo_servicio(id_solicitud, nombre_completo, fecha, hora, estatus) {
	return `<tr id="${id_solicitud}">
			<td>${nombre_completo}</td>
			<td>${fecha}</td>
			<td>${hora}</td>
			<td>${estatus}</td>
	</tr>`
}

async function llenar_tabla_nuevo_servicio(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tbody = $('#tbody_pendientes') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_nuevo_servicio(row.id_solicitud, row.nombre, row.fecha, row.hora_visita, row.estatus)).appendTo(tbody)
	}) 
	return result.error
}

//-------------------------------------------------------Cobranza
function elementos_material(material) {
	return `<div class="item" data-value="${material}">${material}</div>`
}
	
async function llenar_material(route) {
	const response = await fetch(route)
	console.log(response);
	const result = await response.json()
	console.log(result);
	let dropdown1 = $('#dropdown_material')
	$.each(result.data, (i,row) => {
		$(elementos_material(row.nombre)).appendTo(dropdown1)
	}) 
	return result.error
}

function filas_tabla_material_seleccionados(id_material,nombre, cantidad,precio_vento, precio) {
	costo_material = parseFloat(costo_material + precio);
	return `<tr id="${id_material}">
			<td>${nombre}</td>
			<td>${cantidad}</td>
			<td>${precio_vento}</td>
			<td>${precio}</td>
	</tr>`
}
	
async function llenar_tabla_material_seleccionados(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tbody = $('#tbody_material') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_material_seleccionados(row.codigo_dis,row.nombre,row.cantidad,row.precio_venta,row.total)).appendTo(tbody)
	}) 
	return result.error
}

function filas_tabla_total_cotizacion(total) {
	return `<tr>
	<td>Total</td>
	<td>${total}</td>
	</tr>`
}

async function llenar_total_cotización(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tbody = $('#tbody_material_total') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_total_cotizacion(row.total)).appendTo(tbody)
	}) 
	return result.error
}

async function cotizacion_material(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	return result.error
}

async function cotizacion(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	return result.error
}

async function generar_cotizacion(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	return result.error
}

async function agregar_ciz(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	return result.error
}

function filas_tabla_material_zona(material, zona) {
	return `<tr>
			<td>${material}</td>
			<td>${zona}</td>
	</tr>`
}

async function finalizar_ciz(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	return result.error
}

async function materiales_registrados(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tbody = $('#tbody_material_zona') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_material_zona(row.nombre,row.zona)).appendTo(tbody)
	}) 
	return result.error
}

function elementos_tipo_inmueble(id_tipo,tipo_inmueble) {
	return `<div id="${id_tipo}" class="item" data-value="${tipo_inmueble}">${tipo_inmueble}</div>`
}

async function llenar_tipo_inmueble(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let dropdown = $('#dropdown_tipo_inmueble_ciz') 
	$.each(result.data, (i,row) => {
		$(elementos_tipo_inmueble(row.clave_tipo,row.nombre)).appendTo(dropdown)
	}) 
	return result.error
}

function elementos_material_zona(material) {
	return `<div class="item" data-value="${material}">${material}</div>`
}

async function llenar_material_zona(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let dropdown = $('#dropdown_material_zona_ciz') 
	$.each(result.data, (i,row) => {
		$(elementos_material_zona(row.nombre)).appendTo(dropdown)
	}) 
	return result.error
}

function filas_tabla_usuarios_registrados(num, nombre, ape_p, ape_m,tel,rel) {
	return `<tr>
			<td>${num}</td>
			<td>${nombre}</td>
			<td>${ape_p}</td>
			<td>${ape_m}</td>
			<td>${tel}</td>
			<td>${rel}</td>
	</tr>`
}

async function mostrar_usuarios_registrados(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tabla = $('#tbody_usuarios') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_usuarios_registrados(row.num_usuario,row.nombre,row.apellido_p,row.apellido_m,row.telefono,row.relacion)).appendTo(tabla)
	}) 
	return result.error
}

function filas_tabla_contacto_registrados(num, nombre,tel,rel) {
	return `<tr>
			<td>${num}</td>
			<td>${nombre}</td>
			<td>${tel}</td>
			<td>${rel}</td>
	</tr>`
}

async function mostrar_contactos_registrados(route,body) {
	const response = await fetch(route, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	})
	console.log(response);
	const result = await response.json()
	console.log(result);
	let tabla = $('#tbody_contacto') 
	$.each(result.data, (i,row) => {
		$(filas_tabla_contacto_registrados(row.num_contacto,row.nombre_completo,row.telefono,row.relacion)).appendTo(tabla)
	}) 
	return result.error
}

	//Mostrar únicamente la primera sección de la navegación de pestañas
	$('ul.tabs li a:first').addClass('active');
    $('.secciones article').hide();
	$('#ciz').hide();
	$('#usu_cont').hide();
	$('.secciones article:first').show();

	//Funcionalidades de la navegación de pestañas
	$('ul.tabs li a').click(function(){
		$('ul.tabs li a').removeClass('active');
		$(this).addClass('active');
		$('.secciones article').hide();

		var activeTab = $(this).attr('href');
		$(activeTab).show();
		return false;
		
	});

	function hacer_click_close_aceptar_material(){
		$('#close_aceptar_material').click();
	}

	function hacer_click_close_aceptar_confirmar_material_zona(){
		$('#close_aceptar_confirmar_material_zona').click();
	}

	function hacer_click_close_aceptar_registro_monitoreo_usuarios(){
		$('#close_aceptar_registro_monitoreo_usuarios').click();
	}

	function hacer_click_close_aceptar_registro_monitoreo_contactos(){
		$('#close_aceptar_registro_monitoreo_contactos').click();
	}
	

	//Funcionalidad de los botones en general
	$('button').click(function(){
        switch($(this).attr('id')){
			case "btn_proceder":
				proceder_elemento_seleccionado('/pendientes/elemento_seleccionado',{
					id_elemento: seleccion,
					tipo_solicitud: $('#solicitud option:selected').text()
				});
				llenar_material('/pendientes/cobranza_material');
				llenar_tipo_inmueble('/pendientes/tipo_inmueble');
			break;
			case "btn_añadir_material":
				if ($('#cantidad').val() != ''){
					cotizacion_material('/pendientes/cobranza_material/detalle',{
						solicitud:seleccion,
						nombre:$('#material').val(),
						cantidad:$('#cantidad').val()}			
						);
					$('#confirmar_material').modal('show');
					setTimeout(hacer_click_close_aceptar_material,700);
				}

			break;
			case "close_aceptar_material":
				$('#confirmar_material').modal('hide');
				$('#tbody_material') .empty(); 
				llenar_tabla_material_seleccionados('/pendientes/cobranza_material/seleccion',{
					solicitud:seleccion}			
					);
				$('#tbody_material_total') .empty(); 
				llenar_total_cotización('/pendientes/cobranza_material/llenar/total',{
					solicitud:seleccion}			
					);
			break;
			case "btn_eliminar_material":
					finalizar_ciz('/pendientes/cobranza_material/borrar',{
					solicitud:seleccion,
					material:material}			
					);
					$('#confirmar_borrar_material').modal('show');
			break;
			case "close_borrar_material":
					$('#confirmar_borrar_material').modal('hide');
					$('#tbody_material') .empty(); 
					llenar_tabla_material_seleccionados('/pendientes/cobranza_material/seleccion',{
						solicitud:seleccion}			
						);
					$('#tbody_material_total') .empty(); 
					llenar_total_cotización('/pendientes/cobranza_material/llenar/total',{
						solicitud:seleccion}			
						);
			break
			case "confirmar":
				$('#confirmar_cotizacion').modal('show');
			break;
			case "close_cancelar_cotizacion":
				$('#confirmar_cotizacion').modal('hide');
			break;
			case "close_aceptar_cotizacion":
				$('#confirmar_cotizacion').modal('hide');
				generar_cotizacion('/pendientes/cobranza_material/confirmar',{
					costo:costo_material,
					mano_obra:$('#mano_obra_fc').val(),
					solicitud:seleccion}			
					);
				window.open(`/pendientes?permiso=${permiso}&valor=${valor}`, '_self'); 
				location.reload();
			break;
			case "btn_cliente_inmueble_ciz":
				if ($('#nombre_fc_ciz').val() != '' && $('#apellido_p_fc_ciz').val() != '' && $('#apellido_m_fc_ciz').val() != '' && $('#correo_fc_ciz').val() != '' && $('#telefono_fc_ciz').val() != '' && $('#firma_fc_ciz').val() != '' && $('#calle_fi_ciz').val() != '' && $('#num_ext_fi_ciz').val() != '' && $('#colonia_fi_ciz').val() != '' && $('#codigo_fi_ciz').val() != '' && $('#tipo_inmueble_ciz').val() != '' && $('#estado_fi_ciz').val() != '' && $('#municipio_fi_ciz').val() != '' && $('#clave_fc_ciz').val() != ''){
					agregar_ciz('/pendientes/ciz/cliente_inmueble',{
						nombre_fc_ciz:$('#nombre_fc_ciz').val(),
						apellido_p_fc_ciz:$('#apellido_p_fc_ciz').val(),
						apellido_m_fc_ciz:$('#apellido_m_fc_ciz').val(),
						correo_fc_ciz:$('#correo_fc_ciz').val(),
						telefono_fc_ciz:$('#telefono_fc_ciz').val(),
						calle_fi_ciz:$('#calle_fi_ciz').val(),
						num_ext_fi_ciz:$('#num_ext_fi_ciz').val(),
						colonia_fi_ciz:$('#colonia_fi_ciz').val(),
						codigo_fi_ciz:$('#codigo_fi_ciz').val(),
						tipo_inmueble_ciz:$('#tipo_inmueble_ciz').val(),
						estado_fi_ciz:$('#estado_fi_ciz').val(),
						municipio_fi_ciz:$('#municipio_fi_ciz').val(),
						id_solicitud:seleccion,
						clave_fc_ciz:$('#clave_fc_ciz').val()}			
						);
					llenar_material_zona('/pendientes/llenado/material_zona',{
						solicitud:seleccion}			
						);
					$('.secciones article').hide();
					$('#form_zonas').show();
				}
			break;
			case "btn_añadir_material_zona":
				if ($('#material_zona_ciz').val() != '' && $('#zona_zona_ciz').val() != ''){
					finalizar_ciz('/pendientes/ciz/confirmar',{
						material_zona_ciz:$('#material_zona_ciz').val(),
						zona_zona_ciz:$('#zona_zona_ciz').val(),
						solicitud:seleccion}			
						);
					$('#confirmar_material_zona').modal('show');
					setTimeout(hacer_click_close_aceptar_confirmar_material_zona,700);
				}
			break;
			case "close_aceptar_confirmar_material_zona":
				$('#tbody_material_zona').empty(); 
				materiales_registrados('/pendientes/materiales/registrados',{
					solicitud:seleccion}			
					);
				$('#dropdown_material_zona_ciz').empty();
				llenar_material_zona('/pendientes/llenado/material_zona',{
					solicitud:seleccion}			
					);
				$('#confirmar_material_zona').modal('hide');
			break;
			case "btn_finalizar_ciz":
				$('#confirmar_registro').modal('show');
				
			break;
			case "close_aceptar_registro":
				$('#confirmar_registro').modal('hide');
				agregar_ciz('/pendientes/monitoreo/modificar/solicitud',{
					solicitud:seleccion}			
					);
				window.open(`/pendientes?permiso=${permiso}&valor=${valor}`, '_self'); 
			break;
			case "btn_registrar_usuario":
				if ($('#nom_usu').val() != '' && $('#apellido_p_usu').val() != '' && $('#apellido_m_usu').val() != '' && $('#relacion_usu').val() != '' && $('#telefono_usu').val() != ''){
					agregar_ciz('/pendientes/agregar/usuarios',{
						solicitud:seleccion,
						no_usu:usuario,
						nom_usu:$('#nom_usu').val(),
						apellido_p_usu:$('#apellido_p_usu').val(),
						apellido_m_usu:$('#apellido_m_usu').val(),
						relacion_usu:$('#relacion_usu').val(),
						telefono_usu:$('#telefono_usu').val()
					});
					$('#confirmar_registro_monitoreo_usuarios').modal('show');
					setTimeout(hacer_click_close_aceptar_registro_monitoreo_usuarios,700);
				}
				usuario = usuario +1;
			break;
			case "close_aceptar_registro_monitoreo_usuarios":
				$('#tbody_usuarios').empty();
				mostrar_usuarios_registrados('/pendientes/mostrar/usuarios',{
					solicitud:seleccion
				});
				$('#no_usu').val('');
				$('#nom_usu').val('');
				$('#apellido_p_usu').val('');
				$('#apellido_m_usu').val('');
				$('#relacion_usu').val('');
				$('#telefono_usu').val('');
				$('#confirmar_registro_monitoreo_usuarios').modal('hide');
			break;
			case "btn_registrar_contacto":
				if ($('#nom_contacto').val() != '' && $('#ralacion_cont').val() != '' && $('#telefono_contacto').val() != '' ){
					agregar_ciz('/pendientes/agregar/contactos',{
						solicitud:seleccion,
						num_cont:contacto,
						nom_contacto:$('#nom_contacto').val(),
						ralacion_cont:$('#ralacion_cont').val(),
						telefono_contacto:$('#telefono_contacto').val()
					});
					$('#confirmar_registro_monitoreo_contactos').modal('show');	
					setTimeout(hacer_click_close_aceptar_registro_monitoreo_contactos,700);
				}
				contacto = contacto + 1;
			break;
			case "close_aceptar_registro_monitoreo_contactos":
				$('#tbody_contacto') .empty();
				mostrar_contactos_registrados('/pendientes/mostrar/contactos',{
					solicitud:seleccion
				});
				$('#num_cont').val('');
				$('#nom_contacto').val('');
				$('#ralacion_cont').val('');
				$('#telefono_contacto').val('');
				$('#confirmar_registro_monitoreo_contactos').modal('hide');	
			break;
			case "btn_finalizar_monitoreo":
				$('#confirmar_registro_monitoreo').modal('show');
			break;
			case "close_aceptar_registro_monitoreo":
				$('#confirmar_registro_monitoreo').modal('hide');
				agregar_ciz('/pendientes/monitoreo/modificar/solicitud',{
					solicitud:seleccion}			
					);
				agregar_ciz('/pendientes/monitoreo/acivar',{
					solicitud:seleccion}			
					);
				window.open(`/pendientes?permiso=${permiso}&valor=${valor}`, '_self'); 
				location.reload();
			break;
			case "btn_detalles":
				$('#modal_detalle').empty();
				modal_detalle_pendientes('/pendientes/detalles/solicitudes',{
					tipo_solicitud: $('#solicitud option:selected').text(),
					solicitud:seleccion
				});
				$('#modal_mostrar_detalle_pendientes').modal('show');
			break;
			case "close_modal_detalle":
				$('#modal_mostrar_detalle_pendientes').modal('hide');
			break;
			case "Btn_aceptarMante":
				agregar_ciz('/pendientes/agregar/mantenimiento',{
					solicitud:seleccion,
					observaciones_mantenimiento:$('#observaciones_mantenimiento').val()
				});
				$('#confirmar_registro').modal('show');
			break;
			case "cerrar_sesion":
				$('#confirmar_cerrar_sesion').modal('show');
			break;
			case "close_cancelar_sesión":
				$('#confirmar_cerrar_sesion').modal('hide');
			break;
			case "close_aceptar_sesión":
				$('#confirmar_cerrar_sesion').modal('hide');
				window.open(`/`, '_self'); 
			break;
			default:
				if ($(this).text() === "Cancelar" || $(this).text() === "Regresar" ) {
					$('.secciones article').hide();
					$('.secciones article:first').show();
					location.reload();
				}else{
					$('.secciones article').hide();
					var activeBut = $(this).attr('href');
					$(activeBut).show();
				}
				return false;
		}
	});

	//Funcionalidad del listbox
	var select = document.getElementById('solicitud');
	select.addEventListener('change',
	function(){
		switch($(this).val()) {
			case "1":
				$('#tbody_pendientes').empty();
				llenar_tabla_nuevo_cliente('/pendientes/nuevo_cliente',{
					empleado:valor
				});
				break;
			case "2":
				$('#tbody_pendientes').empty(); 
				llenar_tabla_nuevo_inmueble('/pendientes/nuevo_inmueble',{
					empleado:valor
				});
				break;
			case "3":
				$('#tbody_pendientes').empty(); 
				llenar_tabla_nuevo_servicio('/pendientes/nuevo_servicio',{
					empleado:valor
				});
				break;
			}
			
		return false;
	});

	//Funcionalidad de los campos de fecha
	$('.ui.calendar').calendar({
		type: 'date',
		monthFirst: false,
		formatter: {
			date: function (date, settings) {
				if (!date) return '';
				var day = date.getDate();
				var month = date.getMonth() + 1;
				var year = date.getFullYear();
				return day + '/' + month + '/' + year;
			}
		}
	});

	//Funcionalidad de los campos de fecha
	$('.ui.calendar.time').calendar({
		ampm: false,
		type: 'time'
	});

	$('#tabla_pendientes tbody').on('click', 'tr', function() {
		//get row contents into an array
		$('tr.active').removeClass('active');
		$(this).addClass('active');
		seleccion = $(this).attr('id');
		console.log(seleccion);
		//
		// var tableData = $(this).children("td").map(function() {
		// 	return tableData;
		// }).get();
	});

	$('#tbl_cotizar_instalacion tbody').on('click', 'tr', function() {
		//get row contents into an array
		$('tr.active').removeClass('active');
		$(this).addClass('active');
		material = $(this).attr('id');
		console.log(seleccion);
		//
		// var tableData = $(this).children("td").map(function() {
		// 	return tableData;
		// }).get();
	});

	//Funcionalidad del dropdown
	$('.ui.dropdown').dropdown();

    function obtenerValorParametro(sParametroNombre) {
        var sPaginaURL = window.location.search.substring(1);
         var sURLVariables = sPaginaURL.split('&');
          for (var i = 0; i < sURLVariables.length; i++) {
            var sParametro = sURLVariables[i].split('=');
            if (sParametro[0] == sParametroNombre) {
              return sParametro[1];
            }
        }
        return null;
    }

    function colocar_menu_gerente(){
        return `<!-- Menú colocado en la parte izquierda -->
        <div class="ui large left fixed blue inverted vertical menu">
          <div class="item">
            <!-- Logo de Syscol -->
            <a href="/inicio?permiso=${permiso}&valor=${valor}"> <img class="ui image" src="/img/logo.jpg"></a>
          </div>
          <a href="/solicitudes?permiso=${permiso}&valor=${valor}" class="item">Solicitudes</a>
          <a href="/orden_trabajo?permiso=${permiso}&valor=${valor}" class="item">Orden de trabajo</a>
          <a href="/pendientes?permiso=${permiso}&valor=${valor}" class="item">Pendientes</a>
          <a href="/monitoreo?permiso=${permiso}&valor=${valor}" class="item">Monitoreo</a>
		  <a href="/cobranza?permiso=${permiso}&valor=${valor}" class="item">Cobranza</a>
		  <a href="/materiales?permiso=${permiso}&valor=${valor}" class="item">Materiales</a>
          <br><br>
          <a href="/reportes?permiso=${permiso}&valor=${valor}" class="item">Reportes</a>
        </div>`
    }
    function menu_gerente(){
        let tbody = $('#menu_navegacion')
        $(colocar_menu_gerente()).appendTo(tbody)
    }
    function colocar_menu_tecnico(){
        return `<!-- Menú colocado en la parte izquierda -->
        <div class="ui large left fixed blue inverted vertical menu">
          <div class="item">
            <!-- Logo de Syscol -->
            <a href="/inicio?permiso=${permiso}&valor=${valor}"> <img class="ui image" src="/img/logo.jpg"></a>
          </div>
          <a href="/solicitudes?permiso=${permiso}&valor=${valor}" class="item">Solicitudes</a>
          <a href="/pendientes?permiso=${permiso}&valor=${valor}" class="item">Pendientes</a>
          <a href="/cobranza?permiso=${permiso}&valor=${valor}" class="item">Cobranza</a>
          <br><br>
          <a href="/reportes?permiso=${permiso}&valor=${valor}" class="item">Reportes</a>
        </div>`
    }
    function menu_tecnico(){
        let tbody = $('#menu_navegacion')
        $(colocar_menu_tecnico()).appendTo(tbody)
    }
    function colocar_menu_monitoreo(){
        return `<!-- Menú colocado en la parte izquierda -->
        <div class="ui large left fixed blue inverted vertical menu">
          <div class="item">
            <!-- Logo de Syscol -->
            <a href="/inicio?permiso=${permiso}&valor=${valor}"> <img class="ui image" src="/img/logo.jpg"></a>
          </div>
          <a href="/solicitudes?permiso=${permiso}&valor=${valor}" class="item">Solicitudes</a>
          <a href="/monitoreo?permiso=${permiso}&valor=${valor}" class="item">Monitoreo</a>
          <br><br>
          <a href="/reportes?permiso=${permiso}&valor=${valor}" class="item">Reportes</a>
        </div>`
    }
    function menu_monitoreo(){
        let tbody = $('#menu_navegacion')
        $(colocar_menu_monitoreo()).appendTo(tbody)
    }

    var permiso = obtenerValorParametro('permiso');
    var valor = obtenerValorParametro('valor');
    switch(permiso){
        case "1":
            menu_gerente();
        break;
        case "2":
            menu_tecnico();
        break;
        case "3":
            menu_monitoreo();
        break;
      }

});