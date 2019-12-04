$(document).ready(function(){
      $('.ui.form').form({
          fields: {
            email: {
              identifier  : 'email',
              rules: [
                {
                  type   : 'empty',
                  prompt : 'Ingrese un nombre de usuario'
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
          if (result["error"].localeCompare("vacio") == 0) {
            if ($("#email").val().localeCompare("") != 0 && $("#password").val().localeCompare("") != 0) {
              $('.mini.modal').modal('show');
              $("#email").val('');
              $("#password").val('');
            }
          } else {
            $.each(result.data, (i,row) => {
            const permiso = row.valor;
            const valor = row.id_empleado;
            console.log(permiso)
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
                default:
                  alert("Los datos ingresados no coinciden con ningún registro del sistema");
                  break;
              }
            })
          } 
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