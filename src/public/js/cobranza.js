var clave_inmueble = ""
var monitoreo = 0;
$(document).ready(function(){

	function filas_tabla_cobranza(ciente,nombre,direccion,fecha_cobro) {
		return `<tr id="${ciente}">
				<td>${ciente}</td>
				<td>${nombre}</td>
				<td>${direccion}</td>
				<td>${fecha_cobro}</td>
		</tr>`
	}

	async function llenar_tabla_cobranza(route,body) {
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
		let tbody = $('#tbody_cobranza')  
		$.each(result.data, (i,row) => {
			$(filas_tabla_cobranza(row.cliente, row.nombre, row.direccion, row.fecha_cobro)).appendTo(tbody)
		}) 
		return result.error
	}

	function elementos_clientes(nombre) {
		return `<div class="item" data-value="${nombre}">${nombre}</div>`
	}
		
	async function llenar_tabla_nombre(route,body) {
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
		let tbody = $('#dropdown_cobranza_nombre') 
		$.each(result.data, (i,row) => {
			$(elementos_clientes(row.nombre)).appendTo(tbody)
		}) 
		return result.error
	}

	async function agregar(route,body) {
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

	//Métodos para el llenado de las tablas
	function filas_tabla_solicitud_mantenimiento() {
		return `<tr>
			<td>Número de cliente</td>
			<td>${clave_inmueble}</td>
		</tr>`
	}
		
	async function mostrar_solicitud() {
		let tbody = $('#tbody_solicitud_mantenimiento') 
		$(filas_tabla_solicitud_mantenimiento()).appendTo(tbody)
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
			case "cobranza_proceder":		 
				llenar_tabla_nombre('/cobranza/cliente',{
					inmueble:clave_inmueble}			
					);
				$('#confirmar_mantenimiento_cobranza').modal('show');
			break;
			case "close_cancelar_registro":
				$('#confirmar_mantenimiento_cobranza').modal('hide');
				$('#mostrar_pagos').hide();
				$('#form_pagos').show();
			break;
			case "close_aceptar_registro":
				$('#confirmar_mantenimiento_cobranza').modal('hide');
				$('#mostrar_pagos').hide();
				mostrar_solicitud();
				$('#atender_mante').show();
			break;
			case "Btn_aceptarMante":
				monitoreo = 1;
				$('#atender_mante').hide();
				$('#form_pagos').show();
			break;
			case "detalle_cobranza":
				$('#mostrar_pagos_clientes').hide();
				$('#detalle').show();
				sigueinte = "#mostrar_pagos_clientes"
			break;
			case "btn_confirmar_pago":
				if ($('#cobranza_nombre').val() != '' && $('#cobranza_monto').val() != '' && $('#cobranza_firma').val() != ''){
					agregar('/cobranza/pago',{
						nombre:$('#cobranza_nombre').val(),
						monto:$('#cobranza_monto').val(),
						firma_elecronica:$('#cobranza_firma').val()}			
						);
						$('#confirmar').modal('show');
				}
				if (monitoreo == 1){
					if ($('#cobranza_nombre').val() != '' && $('#cobranza_monto').val() != '' && $('#cobranza_firma').val() != ''){
						agregar('/cobranza/mantenimiento',{
							nombre:$('#cobranza_nombre').val(),
						monto:$('#cobranza_monto').val(),
						firma_elecronica:$('#cobranza_firma').val(),
						observaciones_mantenimiento:$('#observaciones_mantenimiento').val()}			
						);
						$('#confirmar').modal('show');
					}
				}
				monitoreo = 0;
			break;
			case "close_aceptar_pago":
				$('#confirmar').modal('hide');
				window.open(`/cobranza?permiso=${permiso}&valor=${valor}`, '_self'); 
			break;
			case "close_cancelar_pago":
				$('#confirmar').modal('hide');
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
			case "btn_buscar_cobro":
				llenar_tabla_cobranza('/cobranza/inmuebles',{
					fecha:$(fecha_cobro).val()}			
					);
			break;
			default:
				if ($(this).text() === "Cancelar" || $(this).text() === "Regresar" ) {
					location.reload();
				}else{
					$('#tipo').val('por defecto')
					$('.secciones article').hide();
					var activeBut = $(this).attr('href');
					$(activeBut).show();
				}
				return false;
			}
	});

	//Funcionalidad de los campos de fecha
	$('.ui.calendar').calendar({
		type: 'month',
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

	//Funcionalidad del dropdown
	$('.ui.dropdown').dropdown();

	$('#tbl_pagos_pendientes tbody').on('click', 'tr', function() {
		//get row contents into an array
		$('tr.active').removeClass('active');
		$(this).addClass('active');
		clave_inmueble = $(this).attr('id');
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