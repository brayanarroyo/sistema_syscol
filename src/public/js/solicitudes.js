$(document).ready(function(){

	//Elementos de los dropdown
	function elementos_nombre_cliente(nombre_cliente) {
		return `<div class="item" data-value="${nombre_cliente}">${nombre_cliente}</div>`
	}
		
	async function llenar_nombre_cliente(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let dropdown1 = $('#dropdown_inmueble')
		let dropdown2 = $('#dropdown_servicio')
		$.each(result.data, (i,row) => {
			$(elementos_nombre_cliente(row.nombre)).appendTo(dropdown1)
			$(elementos_nombre_cliente(row.nombre)).appendTo(dropdown2)
		}) 
		return result.error
	}

		//Elementos de los dropdown
		function elementos_domicilio_cliente(domicilio) {
			return `<div class="item" data-value="${domicilio}">${domicilio}</div>`
		}
			
		async function llenar_domicilio_cliente(route) {
			const response = await fetch(route)
			console.log(response);
			const result = await response.json()
			console.log(result);
			let dropdown = $('#dropdown_domicilio')
			$.each(result.data, (i,row) => {
				$(elementos_domicilio_cliente(row.domicilio)).appendTo(dropdown)
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

	async function solicitudes(route,body) {
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

	//Funcionalidad de los botones en general
	$('button').click(function(){
		switch($(this).attr('id')){
			case "registrar_nuevo":
				if ($('#solicitud option:selected').text() != '' && $('#nombre_fc').val() != '' && $('#domicilio_fc').val() != '' && $('#telefono_fc').val() !='' && $('#servicio_fc option:selected').text() != '' && $('#fecha_fc').val() != '' && $('#hora_fc').val() != ''){
					solicitudes('/solicitudes/agregar_solicitud/nuevo_cliente',{
						solicitud:  $('#solicitud option:selected').text(),
						nombre_fc: $('#nombre_fc').val(),
						domicilio_fc: $('#domicilio_fc').val(),
						telefono_fc: $('#telefono_fc').val(),
						servicio_fc: $('#servicio_fc option:selected').text(),
						fecha_fc: $('#fecha_fc').val(),
						hora_fc: $('#hora_fc').val()
					});
					$('#confirmar_solicitud').modal('show');
				}
			break;
			case "registrar_inmueble":
				if ($('#solicitud option:selected').text() != '' && $('#nombre_fi').val() != '' && $('#domicilio_fi').val() != '' && $('#servicio_fi option:selected').text() !='' && $('#fecha_fi').val() != '' && $('#hora_fi').val() != ''){
					solicitudes('/solicitudes/agregar_solicitud/nuevo_inmueble',{
						solicitud:  $('#solicitud option:selected').text(),
						nombre_fi: $('#nombre_fi').val(),
						domicilio_fi: $('#domicilio_fi').val(),
						servicio_fi: $('#servicio_fi option:selected').text(),
						fecha_fc: $('#fecha_fi').val(),
						hora_fc: $('#hora_fi').val()
					});
					$('#confirmar_solicitud').modal('show');
				}
			case "registrar_servicio":
				if ($('#solicitud option:selected').text() != '' && $('#nombre_fs').val() != '' && $('#domicilio_fs').val() != '' && $('#servicio_fs option:selected').text() !='' && $('#fecha_fs').val() != '' && $('#hora_fs').val() != ''){
				solicitudes('/solicitudes/agregar_solicitud/nuevo_servicio',{
					solicitud:  $('#solicitud option:selected').text(),
					nombre_fs: $('#nombre_fs').val(),
					domicilio_fs: $('#domicilio_fs').val(),
					servicio_fs: $('#servicio_fs option:selected').text(),
					fecha_fs: $('#fecha_fs').val(),
					hora_fs: $('#hora_fs').val()
				});
				$('#confirmar_solicitud').modal('show');
				}
			break;
			case "aceptar_solicitud":
				$('#confirmar_solicitud').modal('hide');
				location.reload();
			break;
			default:

				if ($(this).text() === "Cancelar" || $(this).text() === "Regresar" ) {
					$('.secciones article').hide();
					$('.secciones article:first').show();
					$('#solicitud').val('0');
				}else{
					$('.secciones article').hide();
					var activeBut = $(this).attr('href');
					$(activeBut).show();
				}
				return false;
			break;
		}
	});

	//Cambiar de sección dependiendo de la opción seleccionada de un listbox
	var select = document.getElementById('solicitud');
	select.addEventListener('change',
	function(){
		switch($(this).val()) {
			case "Nuevo_cliente":
                $('#Form_inmueble').hide();
                $('#Form_servicio').hide();
                $('#Form_cliente').show();
			break;
			case "Nuevo_inmueble":
				$('#dropdown_inmueble').empty();         
                $('#Form_servicio').hide();
                $('#Form_cliente').hide();
				$('#Form_inmueble').show();
				llenar_nombre_cliente('/solicitudes/nombre_clientes');
            break;
            case "Nuevo_servicio":
				$('#dropdown_cliente').empty();
				$('#dropdown_servicio').empty();
				$('#dropdown_domicilio').empty();
                $('#Form_cliente').hide();
                $('#Form_inmueble').hide();
				$('#Form_servicio').show();
				llenar_nombre_cliente('/solicitudes/nombre_clientes');
				llenar_domicilio_cliente('/solicitudes/domicilio_clientes');
            break;
		  }
		return false;
	});

	//Funcionalidad de los campos de fecha
	$('.ui.calendar').calendar({
		type: 'date',
		monthFirst: false,
		minDate: new Date(),
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
	var timestamp = new Date().setHours(10, 0, 0, 0);
	var fechaInicial = new Date(timestamp);

	var timestamp = new Date().setHours(19, 0, 0, 0);
	var fechaFinal = new Date(timestamp);

	//Funcionalidad de los campos de tiempo
	$('.ui.calendar.time').calendar({
		ampm: false,
		type: 'time',
		minDate: fechaInicial,
		maxDate: fechaFinal,
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
          <br><br>
          <a href="/pendientes?permiso=${permiso}&valor=${valor}" class="item">Pendientes</a>
          <a href="/monitoreo?permiso=${permiso}&valor=${valor}" class="item">Monitoreo</a>
          <a href="/cobranza?permiso=${permiso}&valor=${valor}" class="item">Cobranza</a>
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