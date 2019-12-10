$(document).ready(function(){

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
  
  function filas_tabla_clientes(cliente,nombre, direccion, correo, telefono) {
    return `<tr id="${cliente}">
        <td>${cliente}</td>
				<td>${nombre}</td>
				<td>${direccion}</td>
				<td>${correo}</td>
				<td>${telefono}</td>
		</tr>`
  }
  
  async function llenar_clientes(route) {
		const response = await fetch(route)
		console.log(response);
		const result = await response.json()
		console.log(result);
		let tabla = $('#tabla_clientes')
		$.each(result.data, (i,row) => {
			$(filas_tabla_clientes(row.cliente,row.nombre,row.direccion,row.correo,row.telefono)).appendTo(tabla)
		}) 
		return result.error
  }
  
  function filas_tabla_cobros(cliente,nombre, direccion, fecha, monto) {
    return `<tr id="${cliente}">
        <td>${cliente}</td>
				<td>${nombre}</td>
				<td>${direccion}</td>
				<td>${fecha}</td>
				<td>$${monto}</td>
		</tr>`
  }
  
  async function llenar_cobros(route,body) {
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
		let tabla = $('#tabla_cobros') 
		$.each(result.data, (i,row) => {
			$(filas_tabla_cobros(row.cliente,row.nombre,row.direccion,row.fecha_cobro,row.monto)).appendTo(tabla)
		}) 
		return result.error
	}
	//Funcionalidad de los botones en general
	$('button').click(function(){
    switch($(this).attr('id')){
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
          $('#tabla_cobros').empty()
          llenar_cobros('/reportes/cobros',{
            fecha:$(fecha_cobro).val()}			
            );
      break;
      default:
          if ($(this).text() === "Regresar" ) {
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
    }
    });
    
    //Cambiar de sección dependiendo de la opción seleccionada de un listbox
	var select = document.getElementById('reporte');
	select.addEventListener('change',
	function(){
		switch($(this).val()) {
			case "cliente":
        $('.secciones article').hide();
        $('.secciones article:first').show();
        $('#tabla_clientes').empty()
        llenar_clientes('/reportes/clientes');
        $('#reporte_cliente').show();
      break;
      case "Cobros":
        $('.secciones article').hide();
        $('.secciones article:first').show();
        $('#reporte_cobros').show();
			break;
		  }
		return false;
	});

	//Funcionalidad de los campos de fecha
	$('.ui.calendar').calendar({
		type: 'month',
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
