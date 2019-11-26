$(document).ready(function(){
      $('.ui.form').form({
          fields: {
            email: {
              identifier  : 'email',
              rules: [
                {
                  type   : 'empty',
                  prompt : 'Ingrese un correo electronico'
                },
                {
                  type   : 'email',
                  prompt : 'Ingrese un correo electronico valido'
                }
              ]
            },
            password: {
              identifier  : 'password',
              rules: [
                {
                  type   : 'empty',
                  prompt : 'Ingrese la contraseña'
                }
              ]
            }
          }
        });

        async function iniciar_sesion(route,body) {
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
            const permiso = row.valor;
            const valor = row.id_empleado;
            switch(permiso){
              case 1:
                  window.open(`/inicio?permiso=1&valor=${valor}`, '_self'); 
              break;
              case 2:
                  window.open(`/inicio?permiso=2&valor=${valor}`, '_self'); 
              break;
              case 3:
                  window.open(`/inicio?permiso=3&valor=${valor}`, '_self'); 
              break;
            }
          }) 
          return result.error
        }

        $('button').click(function(){
          switch($(this).attr('id')){
            case "btn_sesion":
              iniciar_sesion('/login/validar',{
                usuario:$("#email").val(),
                contraseña:$("#password").val()}			
                );
            break;
          }
        });

    });