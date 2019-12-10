var cliente = "";
$(document).ready(function(){
	//Métodos para el llenado de las tablas
	function filas_datos_cliente(clave, nombre, domicilio, telefono) {
		return `<tr id="${clave}">
				<td>${nombre}</td>
				<td>${domicilio}</td>
				<td>${telefono}</td>
		</tr>`
	}
		
	async function llenar_datos_cliente(route,body) {
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
		let tbody = $('#tbody_datos_cliente')
		$.each(result.data, (i,row) => {
			$(filas_datos_cliente(row.clave_inm, row.nombre, row.domicilio, row.telefono)).appendTo(tbody)
		}) 
		return result.error
	}
	
	function filas_datos_usuarios( contacto, nombre, telefono) {
		return `<tr id="${contacto}">
				<td>${contacto}</td>
				<td>${nombre}</td>
				<td>${telefono}</td>
		</tr>`
	}

	async function llenar_datos_usuarios(route,body) {
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
		let tbody = $('#tbody_datos_usuarios')
		$.each(result.data, (i,row) => {
			$(filas_datos_usuarios(row.num_usuario, row.nombre_completo, row.telefono)).appendTo(tbody)
		}) 
		return result.error
	}

	function filas_datos_contacto( contacto, nombre, telefono) {
		return `<tr id="${contacto}">
				<td>${contacto}</td>
				<td>${nombre}</td>
				<td>${telefono}</td>
		</tr>`
	}

	async function llenar_datos_contacto(route,body) {
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
		let tbody = $('#tbody_datos_contacto')
		$.each(result.data, (i,row) => {
			$(filas_datos_contacto(row.num_contacto, row.nombre_completo, row.telefono)).appendTo(tbody)
		}) 
		return result.error
	}

	//Tabla monitoreo
	function filas_tabla_monitoreo(id_señal,cliente, señal_registrada, fecha, hora) {
		return `<tr id="${cliente}">
				<td>${cliente}</td>
				<td>${señal_registrada}</td>
				<td>${fecha}</td>
				<td>${hora}</td>
		</tr>`
	}
		
	async function llenar_tabla_monitoreo(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let tbody = $('#tbody_monitoreo') 
		$.each(result.data, (i,row) => {
			$(filas_tabla_monitoreo(row.id_señal, row.clave_inm, row.nombre, row.fecha, row.hora)).appendTo(tbody)
		}) 
		return result.error
	}

	//Elementos de los dropdown
	function elementos_numero_cliente(clave_inm) {
		return `<div class="item" data-value="${clave_inm}">${clave_inm}</div>`
	}

	function elementos_zona(zona) {
		return `<div class="item" data-value="${zona}">${zona}</div>`
	}

	function elementos_evento_robo(zona) {
		return `<div class="item" data-value="${zona}">${zona}</div>`
	}
		
	async function llenar_numero_cliente(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let dropdown1 = $('#dropdown_num_cliente_robo')
		let dropdown2 = $('#dropdown_num_cliente_rutina')
		let dropdown3 = $('#dropdown_num_cliente_sistema')
		$.each(result.data, (i,row) => {
			$(elementos_numero_cliente(row.clave_inm)).appendTo(dropdown1)
			$(elementos_numero_cliente(row.clave_inm)).appendTo(dropdown2)
			$(elementos_numero_cliente(row.clave_inm)).appendTo(dropdown3)
		}) 
		return result.error
	}

	async function llenar_evento_robo(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let dropdown1 = $('#dropdown_evento_robo')
		$.each(result.data, (i,row) => {
			$(elementos_evento_robo(row.nombre)).appendTo(dropdown1)
		}) 
		return result.error
	}

	async function llenar_zona(route,body) {
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
		let dropdown1 = $('#dropdown_zona')
		$.each(result.data, (i,row) => {
			$(elementos_zona(row.nombre)).appendTo(dropdown1)
		}) 
		return result.error
	}

	//rutina
	function elementos_usuario(usuario) {
		return `<div class="item" data-value="${usuario}">${usuario}</div>`
	}

	async function llenar_usuario(route,body) {
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
		let dropdown1 = $('#dropdown_usuario')
		$.each(result.data, (i,row) => {
			$(elementos_usuario(row.num_usuario)).appendTo(dropdown1)
		}) 
		return result.error
	}

	async function llenar_evento_rutina(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let dropdown1 = $('#dropdown_evento_rutina')
		$.each(result.data, (i,row) => {
			$(elementos_zona(row.nombre)).appendTo(dropdown1)
		}) 
		return result.error
	}

	//sistema
	function elementos_evento_sistema(zona) {
		return `<div class="item" data-value="${zona}">${zona}</div>`
	}

	async function llenar_evento_sistema(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let dropdown1 = $('#dropdown_evento_sistema')
		$.each(result.data, (i,row) => {
			$(elementos_evento_sistema(row.nombre)).appendTo(dropdown1)
		}) 
		return result.error
	}

	async function buscar_fecha(route,body) {
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
		let tbody = $('#tbody_monitoreo') 
		$.each(result.data, (i,row) => {
			$(filas_tabla_monitoreo(row.id_señal, row.clave_inm, row.nombre, row.fecha, row.hora)).appendTo(tbody)
		}) 
		return result.error
	}

	async function señal(route,body) {
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

	//Mostrar únicamente la primera sección de la navegación de pestañas
	$('ul.tabs li a:first').addClass('active');
	$('.secciones article').hide();
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

	//Funcionalidad de los botones en general
	$('button').click(function(){
		switch($(this).attr('id')){
			case "btn_señal_rutina":
				señal('/monitoreo/registrar/rutina',{
					num_cliente_rutina:$('#num_cliente_rutina').val(),
					evento_rutina:$('#evento_rutina_evento').val(),
					usuario_rutina:$('#usuario_rutina_usuario').val()}			
					);
				$('#confirmar_señal').modal('show');
			break;
			case "btn_señal_robo":
				console.log($('#num_cliente_robo').val())
				console.log($('#evento_robo').val())
				console.log($('#zona_evento_robo').val())
				señal('/monitoreo/registrar/senal_robo',{
					num_cliente_robo:$('#num_cliente_robo').val(),
					evento_robo_s:$('#evento_robo_s').val(),
					zona_evento_robo:$('#zona_evento_robo').val()}			
					);
				$('#confirmar_señal').modal('show');
			break;
			case "btn_señal_sistema":
				señal('/monitoreo/registrar/sistema',{
					num_cliente_sistema:$('#num_cliente_sistema').val(),
					evento_sistema:$('#evento_sistema_input').val()}			
					);
				$('#confirmar_señal').modal('show');
			break;
			case "aceptar_señal":
				$('#confirmar_señal').modal('hide');
				window.open(`/monitoreo?permiso=${permiso}&valor=${valor}`, '_self'); 
			break;
			case "btn_buscar_senal":
				$('#tbody_monitoreo').empty();
				buscar_fecha('/monitoreo/buscar_senal',{
					fecha_senal:$('#fecha_senal').val()}			
					);
			break;
			case "btn_contactar":
			if (cliente !=""){
				$('#tbody_datos_cliente').empty();
				$('#tbody_datos_contacto').empty();
				$('#tbody_datos_usuarios').empty();
				llenar_datos_cliente('/monitoreo/contactar/cliente',{
					id_cliente:cliente}			
					);
				llenar_datos_usuarios('/monitoreo/contactar/usuarios',{
					id_cliente:cliente}			
					);
				llenar_datos_contacto('/monitoreo/contactar/contactos',{
					id_cliente:cliente}			
					);
				$('#modal_detalle_contactos').modal('show');
			}else{
				$('#no_procedio').modal('show');
				setTimeout(() => { $('#no_procedio').modal('hide'); }, 700);
			}
			break;
			case "close_modal_detalle":
				$('#modal_detalle_contactos').modal('hide');
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
				}else{
					$('.secciones article').hide();
					var activeBut = $(this).attr('href');
					$(activeBut).show();
				}
				return false;
			break;
		}
	});

	//Cambiar de sección dependiendo de la opción seleccionada de un listbox de tipos de señal
	var select = document.getElementById('tipo');
	select.addEventListener('change',
	function(){
		switch($(this).val()) {
			case "robo":
                $('#evento_rutina').hide();
                $('#evento_sistema').hide();
				$('#evento_robo').show();
			  break;
			case "rutina":
                $('#evento_robo').hide();
                $('#evento_sistema').hide();
				$('#evento_rutina').show();
              break;
            case "sistema":
                $('#evento_robo').hide();
                $('#evento_rutina').hide();
                $('#evento_sistema').show();
                break;
		  }
		return false;
	});

	llenar_numero_cliente('/monitoreo/inmueble')

	llenar_evento_robo('/monitoreo/robo/eventos')
	
	llenar_evento_rutina('/monitoreo/rutina/eventos')

	llenar_evento_sistema('/monitoreo/sistema/eventos')

	llenar_tabla_monitoreo('/monitoreo/senales')

	$('#dropdown_cliente_robo_select').change(function(){
		$('#dropdown_zona').empty();
		llenar_zona('/monitoreo/robo/zona',{
			num_cliente_robo:$('#num_cliente_robo').val()}			
			);
	});

	$('#dropdown_cliente_rutina_select').change(function(){
		$('#dropdown_usuario').empty();
		llenar_usuario('/monitoreo/rutina/usuario',{
			num_cliente_rutina:$('#num_cliente_rutina').val()}			
			);
	});

	//Funcionalidad de los campos de fecha
	$('.ui.calendar').calendar({
		type: 'date',
		monthFirst: false,
		text :{
			months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			monthsShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],    
		  },
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

	//Funcionalidad del dropdown
	$('.ui.dropdown').dropdown();

	$('#tbl_alarmas tbody').on('click', 'tr', function() {
		//get row contents into an array
		$('tr.active').removeClass('active');
		$(this).addClass('active');
		cliente = $(this).attr('id');
	});
	
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