var clave_solicitud = "";
$(document).ready(function(){
		
	async function llenar_tabla_orden_trabajo(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let tbody = $('#tbody_orden_trabajo') 
		$.each(result.data, (i,row) => {
			console.log(row.fecha_visita)
			$(filas_tabla_orden_trabajo(row.id_orden, row.nombre, row.fecha_visita, row.hora, row.empleado)).appendTo(tbody)
		}) 
		return result.error
	}

	function elementos_empleados(empleado) {
		return `<div class="item" data-value="${empleado}">${empleado}</div>`
	}
		
	async function llenar_empleados(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let dropdown1 = $('#dropdown_orden_empleado')
		$.each(result.data, (i,row) => {
			$(elementos_empleados(row.nombre)).appendTo(dropdown1)
		}) 
		return result.error
	}

	function filas_tabla_orden_trabajo(id_orden,cliente, fecha, hora, empleado) {
		return `<tr id="${id_orden}">
				<td>${id_orden}</td>
				<td>${cliente}</td>
				<td>${fecha}</td>
				<td>${hora}</td>
				<td>${empleado}</td>
		</tr>`
	}

	function filas_detalle_tabla_orden_trabajo(clave_solicitud,num_cliente, nombre, domicilio, fecha_visita, hora_visita, observaciones) {
		return `<tr>
		<td>Clave de solicitud</td>
		<td>${clave_solicitud}</td>
		</tr>
		<tr>
		<td>Número de cliente</td>
		<td>${num_cliente}</td>
		</tr>
		<tr>
		<td>Nombre Completo</td>
		<td>${nombre}</td>
		</tr>
		<tr>
		<td>Domicilio</td>
		<td>${domicilio}</td>
		</tr>
		<tr>
		<td>Fecha de visita prevista</td>
		<td>${fecha_visita}</td>
		</tr>
		<tr>
		<td>Hora de visita prevista</td>
		<td>${hora_visita}</td>
		</tr>
		<tr>
		<td>Observaciones</td>
		<td>${observaciones}</td>
		</tr>`
	}
		
	async function llenar_detalle_tabla_orden_trabajo(route,body) {
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
		let tbody = $('#modal_detalle_orden_trabajo') 
		$.each(result.data, (i,row) => {
			$(filas_detalle_tabla_orden_trabajo(row.id_solicitud,row.clave_inm,row.nombre,row.domicilio,row.fecha_visita,row.hora,row.observaciones)).appendTo(tbody)
		}) 
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
			case "btn_confirmar_asignar":
				añadir_solicitud('/orden_trabajo/asignar',{
					id_orden:clave_solicitud,
					orden_empleado:$('#orden_empleado').val(),
					observaciones_empleado:$('#observaciones_empleado').val()}			
					);
				$('#modal_confirmar_asignar').modal('show');
			break;
			case "btn_detalle":
				llenar_detalle_tabla_orden_trabajo('/orden_trabajo/detalle',{
					id_solicitud:clave_solicitud}			
					);
				$('#modal_detalle_orden').modal('show');
            break;
            case "close_modal_detalle":
				$('#modal_detalle_orden').modal('hide');
				$('#modal_detalle_orden_trabajo').empty(); ;
			break;
			case "close_modal_orden_trabajo":
				$('#modal_confirmar_asignar').modal('hide');
				location.reload();
			break;
			default:
				if ($(this).text() === "Cancelar" || $(this).text() === "Regresar" ) {
					$('.secciones article').hide();
					$('.secciones article:first').show();
					$('#solicitud').val('0');
					$('#solicitud_pendiente').val('0');
				}else{
					$('.secciones article').hide();
					var activeBut = $(this).attr('href');
					$(activeBut).show();
				}
				return false;
			break;
		}
	});

	llenar_tabla_orden_trabajo('/orden_trabajo/pendientes')

	llenar_empleados('/orden_trabajo/empleados')

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

	//Funcionalidad del dropdown
	$('.ui.dropdown').dropdown();

	$('#tbl_orden_trabajo tbody').on('click', 'tr', function() {
		//get row contents into an array
		$('tr.active').removeClass('active');
		$(this).addClass('active');
		clave_solicitud = $(this).attr('id');
	});

	async function añadir_solicitud(route, body) {
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
		return result.data
	}
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