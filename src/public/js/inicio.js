$(document).ready(function(){

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

    function colocar_nombre_titulo(nombre){
      return `<h1 class="ui center aligned header">Bienvenido ${nombre}</h1>`
    }
    async function colocar_nombre(route,body) {
      console.log(valor)
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
      let tbody = $('#titulo')
      $.each(result.data, (i,row) => {
        $(colocar_nombre_titulo(row.nombre)).appendTo(tbody)
      }) 
      return result.error
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
    colocar_nombre('/index/titulo',{
      id:valor}			
      );
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
