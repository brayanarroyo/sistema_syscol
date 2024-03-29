$(document).ready(function(){

	function filas_tabla_cobranza(clave_material,nombre,precio_c,precio_v) {
		return `<tr id="${clave_material}">
				<td>${nombre}</td>
				<td>${precio_c}</td>
				<td>${precio_v}</td>
		</tr>`
	}
		
	async function llenar_tabla_material(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let tbody = $('#tbody_costo_material') 
		$.each(result.data, (i,row) => {
			$(filas_tabla_cobranza(row.codigo_dis,row.nombre,row.precio_compra,row.precio_venta)).appendTo(tbody)
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

	async function registro(route,body) {
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
			case "cobranza_proceder":
                $('.secciones article').hide();
                $('#form_materiales').show();
            break;
            case "btn_confirmar":
                if ($('#nom_m').val() != '' && $('#pcm').val() != '' && $('#pvm').val() != ''&& $('#pcm').val() > 0 && $('#pvm').val() > 0 ){
                    $('#confirmar_material').modal('show');
                }
            break;
            case "close_aceptar_registro":
                registro('/materiales/registrar',{
                    nombre: $('#nom_m').val(),
                    precio_c: $('#pcm').val(),
                    precio_v: $('#pvm').val()
                });
                $('#confirmar_material').modal('hide');
                $('.secciones article').hide();
                $('.secciones article:first').show();
            break;
            case "close_aceptar_registro":
                $('#confirmar_material').modal('hide');
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

    llenar_tabla_material('/materiales/mostrar');
    
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