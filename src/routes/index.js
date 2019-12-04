const express = require('express');
const router = express.Router();

const pool = require('../database');

//Rutas del menú de navegación
router.get('/', (req, res) => {
  res.render('login.html', { title: 'pendiente' });
});

router.get('/materiales', (req, res) => {
  res.render('material.html', { title: 'pendiente' });
});

router.get('/login', (req, res) => {
  res.render('login.html', { title: 'pendiente' });
});

router.get('/inicio', (req, res) => {
  res.render('index.html', { title: 'pendiente' });
});

router.get('/solicitudes', (req, res) => {
  res.render('solicitudes.html', { title: 'pendiente' });
});

router.get('/orden_trabajo', (req, res) => {
  res.render('orden_trabajo.html', { title: 'pendiente' });
});

router.get('/monitoreo', (req, res) => {
  res.render('monitoreo.html', { title: 'pendiente' });
});

router.get('/cobranza', (req, res) => {
  res.render('cobranza.html', { title: 'pendiente' });
});

router.get('/reportes', (req, res) => {
  res.render('reportes.html', { title: 'pendiente' });
});

router.get('/pendientes', (req, res) => {
  res.render('pendientes.html', { title: "" });
});
//**********************************************************************************************************************
//***************************************************Login********************************************************
//**********************************************************************************************************************

router.post('/login/validar', async (req, res) => {
  try {
    let { usuario,contraseña } = req.body;
    let query = `SELECT p.valor, e.id_empleado
    FROM login l INNER JOIN permiso p 
    on l.clave_permiso =  p.id_permiso INNER JOIN empleado e
    on l.clave_empleado = e.id_empleado
    WHERE l.usuario = '${usuario}' and l.contraseña = '${contraseña}'`
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        if (Array.isArray(rows) && rows.length === 0){
          res.json({
            error: "vacio",
            message: 'OK',
            data: rows
          })
        }else{
          res.json({
            error: "novacio",
            message: 'OK',
            data: rows
          })
        } 
      }
    })
  } catch (error) {
    throw error;
  }
});
//**********************************************************************************************************************
//***************************************************index********************************************************
//**********************************************************************************************************************
router.post('/index/titulo', (req, res) => {
  try {
    let { id } = req.body;
    let query = `SELECT * FROM view_empleados
    WHERE id_empleado = '${id}'`;
    console.log(query)
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

//**********************************************************************************************************************
//***************************************************SOLICITUDES********************************************************
//**********************************************************************************************************************

//Rutas de los métodos de la base de datos
router.post('/solicitudes/agregar_solicitud/nuevo_cliente', async (req, res) => {
  try {
    let { nombre_fc, ape_p_fc, ape_m_fc, calle_fc, num_fc, colonia_fc, telefono_fc, servicio_fc, fecha_fc, hora_fc } = req.body;
    let tipo_solicitud = "Nuevo cliente";
    fecha_fc = fecha_fc.replace("/", "-");
    fecha_fc = fecha_fc.replace("/", "-");
    fecha_fc = fecha_fc.split("-").reverse().join("-");
    hora_fc = hora_fc.concat(':00');

    let query =`CALL sp_agregar_solicitud_cliente_nuevo(
      '${fecha_fc}',
      '${hora_fc}',
      '${tipo_solicitud}',
      '${servicio_fc}',
      '${nombre_fc}',
      '${ape_p_fc}',
      '${ape_m_fc}',
      '${calle_fc}',
      '${num_fc}',
      '${colonia_fc}',
      '${telefono_fc}'
    )`

    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

//Rutas de los métodos de la base de datos
router.post('/solicitudes/agregar_solicitud/nuevo_inmueble', async (req, res) => {
  try {
    let { nombre_fi, domicilio_fi, servicio_fi, fecha_fi, hora_fi } = req.body;
    let tipo_solicitud = "Nuevo inmueble";
    fecha_fi = fecha_fi.replace("/", "-");
    fecha_fi = fecha_fi.replace("/", "-");
    fecha_fi = fecha_fi.split("-").reverse().join("-");
    hora_fi = hora_fi.concat(':00');

    let query =`CALL sp_agregar_solicitud_inmueble(
      '${fecha_fi}',
      '${hora_fi}',
      '${tipo_solicitud}',
      '${servicio_fi}',
      '${nombre_fi}',
      '${domicilio_fi}'
    )`

    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

//Rutas de los métodos de la base de datos
router.post('/solicitudes/agregar_solicitud/nuevo_servicio', async (req, res) => {
  try {
    let { nombre_fs, domicilio_fs, servicio_fs, fecha_fs, hora_fs } = req.body;
    let tipo_solicitud = "Nuevo servicio";
    fecha_fs = fecha_fs.replace("/", "-");
    fecha_fs = fecha_fs.replace("/", "-");
    fecha_fs = fecha_fs.split("-").reverse().join("-");
    hora_fs = hora_fs.concat(':00');
    let query =`CALL sp_agregar_solicitud_cliente(
      '${fecha_fs}',
      '${hora_fs}',
      '${tipo_solicitud}',
      '${servicio_fs}',
      '${nombre_fs}',
      '${domicilio_fs}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.get('/solicitudes/nombre_clientes', (req, res) => {
  try {
    let query = 'SELECT CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, id_cliente FROM cliente c';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/solicitudes/cliente_domicilio', (req, res) => {
  try {
    let { cliente } = req.body;
    let query = `SELECT CONCAT(calle," ",numero_exterior," ",colonia) as domicilio 
    FROM inmueble i inner join cliente c 
    on i.clave_cliente = c.id_cliente
    where CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) = '${cliente}'`;
    console.log(query)
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});
//*********************************************************************************************************************
//***************************************************PENDIENTES********************************************************
//*********************************************************************************************************************
//Rutas de los métodos de la pestaña de pendientes
router.post('/pendientes/nuevo_cliente', (req, res) => {
  try {
    let { empleado } = req.body;
    let query = `SELECT * FROM view_solicitud_nuevo WHERE clave_empleado =${empleado}`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/nuevo_inmueble', (req, res) => {
  try {
    let { empleado } = req.body;
    let query = `SELECT * FROM view_solicitud_inmueble WHERE clave_empleado =${empleado}`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/nuevo_servicio', (req, res) => {
  try {
    let { empleado } = req.body;
    let query = `SELECT * FROM view_solicitud_cliente WHERE clave_empleado =${empleado}`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/elemento_seleccionado', async(req, res) => {
  try {
    let query = "";
    let { id_elemento, tipo_solicitud } = req.body;
    console.log(id_elemento)
    console.log(tipo_solicitud)
    if (tipo_solicitud.localeCompare("Nuevo cliente") == 0) {
      query = `SELECT estatus FROM view_solicitud_nuevo where id_solicitud = ${id_elemento}`;
    } else if (tipo_solicitud.localeCompare("Nuevo inmueble") == 0){
      query = `SELECT estatus FROM view_solicitud_inmueble where id_solicitud = ${id_elemento}`;
    } else {
      query = `SELECT estatus FROM view_solicitud_cliente where id_solicitud = ${id_elemento}`;
    }
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/detalles/solicitudes', async(req, res) => {
  try {
    let query = "";
    let { tipo_solicitud, solicitud } = req.body;
    console.log(solicitud)
    if (tipo_solicitud.localeCompare("Nuevo cliente") == 0) {
      query = `SELECT * FROM view_detalle_solicitud_cliente_nuevo WHERE id_solicitud = '${solicitud}'`;
    } else if (tipo_solicitud.localeCompare("Nuevo inmueble") == 0){
      query = `SELECT * FROM view_detalle_solicitud_inmueble_nuevo WHERE id_solicitud = '${solicitud}'`;
    } else {
      query = `SELECT * FROM view_detalle_solicitud_cliente WHERE id_solicitud = '${solicitud}'`;
    }
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.get('/pendientes/cobranza_material', async(req, res) => {
  try {
    query = `SELECT nombre from material`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/cobranza_material/seleccion', async(req, res) => {
  try {
    let { solicitud, nombre } = req.body;
    query = `SELECT m.codigo_dis,m.nombre,COUNT(m.nombre) as cantidad,(COUNT(m.nombre) * precio_venta ) as total
    from material m INNER JOIN cotizacion_material cm
    on m.codigo_dis = cm.clave_material INNER JOIN cotizacion c
    on c.id_cotizacion = cm.clave_cotizacion INNER JOIN orden_trabajo ot
    on c.clave_orden = ot.id_orden
    where ot.clave_solicitud = '${solicitud}'
    GROUP BY m.nombre`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/cobranza_material/llenar/total', async(req, res) => {
  try {
    let { solicitud, nombre } = req.body;
    query = `SELECT SUM(precio_venta) as total
    from material m INNER JOIN cotizacion_material cm
    on m.codigo_dis = cm.clave_material INNER JOIN cotizacion c
    on c.id_cotizacion = cm.clave_cotizacion INNER JOIN orden_trabajo ot
    on c.clave_orden = ot.id_orden
    where ot.clave_solicitud ='${solicitud}'`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/cobranza/cliente/autocomplentar', async(req, res) => {
  try {
    let { id_elemento } = req.body;
    query = `SELECT nombre_completo,apellido_p,apellido_m,telefono,calle,numero,colonia
    FROM solicitud s INNER JOIN solicitud_pendiente sp
    on s.id_solicitud = sp.id_solicitud_pendiente
    WHERE s.id_solicitud ='${id_elemento}'`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/cobranza_material/detalle', async (req, res) => {
  try {
    let { solicitud, nombre, cantidad } = req.body;
    let query =`CALL sp_agregar_cotizacion_material(
      '${nombre}',
      '${solicitud}',
      '${cantidad}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }

});

router.post('/pendientes/cobranza_material/borrar', async (req, res) => {
  try {
    let { solicitud, material } = req.body;
    let query =`CALL sp_borrar_cotizacion_material(
      '${solicitud}',
      '${material}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }

});


router.post('/pendientes/cobranza/generar', async (req, res) => {
  try {
    let { id_elemento } = req.body;
    let query =`CALL sp_generar_cotizacion(
      '${id_elemento}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/pendientes/cobranza_material/confirmar', async (req, res) => {
  try {
    let { costo, mano_obra, solicitud } = req.body;
    let query =`CALL sp_agregar_cotizacion(
      '${costo}',
      '${mano_obra}',
      '${solicitud}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/pendientes/ciz/cliente_inmueble', async (req, res) => {
  try {
    let { nombre_fc_ciz, apellido_p_fc_ciz, apellido_m_fc_ciz, correo_fc_ciz, telefono_fc_ciz, firma_fc_ciz,calle_fi_ciz,
    num_ext_fi_ciz, colonia_fi_ciz, codigo_fi_ciz, tipo_inmueble_ciz, estado_fi_ciz, municipio_fi_ciz,
    id_solicitud,clave_fc_ciz} = req.body;
    let query =`CALL sp_agregar_ciz(
      '${nombre_fc_ciz}',
      '${apellido_p_fc_ciz}',
      '${apellido_m_fc_ciz}',
      '${correo_fc_ciz}',
      '${telefono_fc_ciz}',
      '${firma_fc_ciz}',
      '${calle_fi_ciz}',
      '${num_ext_fi_ciz}',
      '${colonia_fi_ciz}',
      '${codigo_fi_ciz}',
      '${tipo_inmueble_ciz}',
      '${estado_fi_ciz}',
      '${municipio_fi_ciz}',
      '${id_solicitud}',
      '${clave_fc_ciz}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/pendientes/ciz/confirmar', async (req, res) => {
  try {
    let { material_zona_ciz, zona_zona_ciz, solicitud } = req.body;
    let query =`CALL sp_finalizar_ciz(
      '${material_zona_ciz}',
      '${zona_zona_ciz}',
      '${solicitud}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post ('/pendientes/tipo_inmueble', (req, res) => {
  try {
    let query = 'SELECT clave_tipo, nombre FROM tipo_inmueble';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post ('/pendientes/llenado/material_zona', (req, res) => {
  try {
    let { solicitud } = req.body;
    let query = `SELECT m.nombre
    FROM orden_trabajo ot INNER JOIN cotizacion c
    on ot.id_orden = c.clave_orden INNER JOIN cotizacion_material cm
    on c.id_cotizacion = cm.clave_cotizacion INNER JOIN material m
    on cm.clave_material = m.codigo_dis
    WHERE ot.clave_solicitud = '${solicitud}'`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post ('/pendientes/materiales/registrados', (req, res) => {
  try {
    let { solicitud } = req.body;
    let query = `SELECT m.nombre, z.nombre as zona
    FROM orden_trabajo ot INNER JOIN cotizacion c 
    on ot.id_orden = c.clave_orden INNER JOIN instalacion i 
    on c.id_cotizacion = i.clave_cotizacion INNER JOIN inmueble_zona iz
    on iz.clave_instalacion = i.id_instalacion INNER JOIN zona z
    on z.id_zona = iz.clave_zona INNER JOIN material m 
    on iz.clave_material = m.codigo_dis
    WHERE ot.clave_solicitud = '${solicitud}'`;
    console.log(query)
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/pendientes/agregar/usuarios', async (req, res) => {
  try {
    let { solicitud,
      no_usu,
      nom_usu,
      apellido_p_usu,
      apellido_m_usu,
      relacion_usu,
      telefono_usu } = req.body;
    let query =`CALL sp_agregar_usuario(
      '${solicitud}',
      '${no_usu}',
      '${nom_usu}',
      '${apellido_p_usu}',
      '${apellido_m_usu}',
      '${relacion_usu}',
      '${telefono_usu}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/pendientes/agregar/contactos', async (req, res) => {
  try {
    let { solicitud,
      num_cont,
      nom_contacto,
      ralacion_cont,
      telefono_contacto} = req.body;
    let query =`CALL sp_agregar_contacto(
      '${solicitud}',
      '${num_cont}',
      '${nom_contacto}',
      '${ralacion_cont}',
      '${telefono_contacto}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/pendientes/monitoreo/modificar/solicitud', async (req, res) => {
  try {
    let { solicitud } = req.body;
    let query =`CALL sp_modificar_estado_solicitud(
      '${solicitud}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    res.end()
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/pendientes/monitoreo/acivar', async (req, res) => {
  try {
    let { solicitud } = req.body;
    let query =`CALL sp_activar_monitoreo(
      '${solicitud}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    res.end()
    return resultado;
  } catch (error) {
    throw error;
  }
  
});
//*********************************************************************************************************************
//***************************************************Mantenimiento********************************************************
//*********************************************************************************************************************
router.post('/pendientes/agregar/mantenimiento', async (req, res) => {
  try {
    let { solicitud,observaciones_mantenimiento } = req.body;
    let tipo_evento = "robo";
    let query =`CALL sp_agregar_mantenimiento(
      '${observaciones_mantenimiento}',
      '${solicitud}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
});
//*********************************************************************************************************************
//***************************************************Monitoreo********************************************************
//*********************************************************************************************************************
router.post('/monitoreo/registrar/senal_robo', async (req, res) => {
  try {
    let { num_cliente_robo,evento_robo_s,zona_evento_robo } = req.body;
    let tipo_evento = "robo";
    let query =`CALL sp_agregar_señal_robo(
      '${num_cliente_robo}',
      '${tipo_evento}',
      '${zona_evento_robo}',
      '${evento_robo_s}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
});

router.post('/monitoreo/registrar/rutina', async (req, res) => {
  try {
    let { num_cliente_rutina,usuario_evento_rutina,evento_rutina } = req.body;

    let tipo_evento = "rutina";
    let query =`CALL sp_agregar_señal_rutina(
      '${num_cliente_rutina}',
      '${tipo_evento}',
      '${usuario_evento_rutina}',
      '${evento_rutina}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
});

router.post('/monitoreo/registrar/sistema', async (req, res) => {
  try {
    let { num_cliente_sistema,evento_sistema } = req.body;

    let tipo_evento = "sistema";
    let query =`CALL sp_agregar_señal_sistema(
      '${num_cliente_sistema}',
      '${tipo_evento}',
      '${evento_sistema}'
    )`
    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
});

router.get('/monitoreo/senales', (req, res) => {
  try {
    let query = 'SELECT * FROM view_señales';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/monitoreo/buscar_senal', async (req, res) => {
  try {
    let { fecha_senal } = req.body;
    console.log(fecha_senal);
    fecha_senal = fecha_senal.replace("/", "-");
    fecha_senal = fecha_senal.replace("/", "-");
    fecha_senal = fecha_senal.split("-").reverse().join("-");
    console.log(fecha_senal);
    let query = `SELECT s.id_señal,i.clave_inm, te.nombre,date_format(s.fecha,'%d/%m/%Y') AS fecha,time_format(s.hora,'%H:%i') AS hora 
    FROM ((señal s join tipo_evento te 
    on(s.clave_tipo_evento = te.clave_tipp)) join inmueble i 
    on(s.clave_inmueble = i.clave_inm))
    WHERE s.fecha = 
    '${fecha_senal}'`
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

//Robo

router.get('/monitoreo/inmueble', (req, res) => {
  try {
    let query = 'SELECT clave_inm FROM inmueble WHERE monitoreo = "si"';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.get('/monitoreo/robo/eventos', (req, res) => {
  try {
    let query = 'SELECT nombre FROM tipo_señal_robo';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/monitoreo/robo/zona', (req, res) => {
  try {
    let { num_cliente_robo } = req.body;
    console.log(num_cliente_robo)
    let query = `	SELECT z.nombre FROM inmueble inm INNER JOIN instalacion i 
    on i.clave_inmueble = inm.clave_inm INNER JOIN inmueble_zona iz
    on i.id_instalacion = iz.clave_instalacion INNER JOIN zona z
    on iz.clave_zona=z.id_zona WHERE inm.clave_inm =
      '${num_cliente_robo}'`
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

//rutina

router.post('/monitoreo/rutina/usuario', (req, res) => {
  try {
    let { num_cliente_rutina } = req.body;
    let query = `SELECT u.num_usuario FROM inmueble inm INNER JOIN usuario u on inm.clave_inm = u.id_mueble WHERE inm.clave_inm = '${num_cliente_rutina}'`
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.get('/monitoreo/rutina/eventos', (req, res) => {
  try {
    let query = 'SELECT nombre FROM tipo_señal_rutina';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

//sistema

router.get('/monitoreo/sistema/eventos', (req, res) => {
  try {
    let query = 'SELECT nombre FROM sistema';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/monitoreo/contactar/cliente', (req, res) => {
  try {
    let { id_cliente } = req.body;
    console.log(id_cliente);
    let query = `SELECT CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, CONCAT(i.calle," ",i.numero_exterior," ",i.colonia) as domicilio, c.telefono, i.clave_inm FROM inmueble i inner join cliente c on i.clave_cliente = c.id_cliente WHERE i.clave_inm = '${id_cliente}'`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/monitoreo/contactar/contactos', (req, res) => {
  try {
    let { id_cliente } = req.body;
    console.log(id_cliente);
    let query = `SELECT c.num_contacto, c.nombre_completo, c.telefono
    FROM contacto c INNER JOIN inmueble i
    on c.id_inmueble = i.clave_inm
    WHERE i.clave_inm = '${id_cliente}'`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

//*********************************************************************************************************************
//***************************************************Orden de trabajo********************************************************
//*********************************************************************************************************************
router.get('/orden_trabajo/pendientes', (req, res) => {
  try {
    let query = 'SELECT * FROM view_orden_trabajo';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.get('/orden_trabajo/empleados', (req, res) => {
  try {
    let query = 'SELECT * FROM view_orden_empleados';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/orden_trabajo/asignar', async (req, res) => {
  try {
    let { orden_empleado, id_orden, observaciones_empleado} = req.body;

    let query =`CALL sp_agregar_orden_trabajo(
      '${observaciones_empleado}',
      '${id_orden}',
      '${orden_empleado}'
    )`

    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/orden_trabajo/detalle', async (req, res) => {
  try {
    let { id_solicitud } = req.body;

    let query =`(SELECT s.id_solicitud,"Pendiente" as clave_inm ,CONCAT(sp.nombre_completo," ",sp.apellido_p, " ", sp.apellido_m) as nombre,CONCAT(sp.calle," ",sp.numero, " ",sp.colonia) as domicilio,
    date_format(s.fecha_visita,'%d/%m/%Y') AS fecha_visita,s.hora,ot.observaciones
    FROM orden_trabajo ot INNER JOIN solicitud s
    on ot.clave_solicitud = s.id_solicitud INNER JOIN solicitud_pendiente sp
    on sp.id_solicitud_pendiente = s.id_solicitud 
    WHERE ot.id_orden= '${id_solicitud}')
UNION
(SELECT s.id_solicitud,"Pendiente" as clave_inm ,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre,CONCAT(i.calle," ",i.numero_exterior," ",i.colonia),
date_format(s.fecha_visita,'%d/%m/%Y') AS fecha_visita,s.hora,ot.observaciones
    FROM orden_trabajo ot INNER JOIN solicitud s
    on ot.clave_solicitud = s.id_solicitud INNER JOIN solicitud_cliente sc
    on sc.id_solicitud_cliente = s.id_solicitud INNER JOIN cliente c 
		on sc.clave_cliente = c.id_cliente INNER JOIN inmueble i 
		on c.id_cliente = i.clave_cliente
    WHERE ot.id_orden = '${id_solicitud}')
UNION
(SELECT s.id_solicitud,"Pendiente" as clave_inm ,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre,CONCAT(i.calle," ",i.numero_exterior," ",i.colonia),
date_format(s.fecha_visita,'%d/%m/%Y') AS fecha_visita,s.hora,ot.observaciones
    FROM orden_trabajo ot INNER JOIN solicitud s
    on ot.clave_solicitud = s.id_solicitud INNER JOIN solicitud_inmueble si
    on si.id_solicitud_inmueble = s.id_solicitud INNER JOIN cliente c 
		on si.clave_cliente = c.id_cliente INNER JOIN inmueble i 
		on c.id_cliente = i.clave_cliente
    WHERE ot.id_orden = '${id_solicitud}')`

    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
  
});

//*********************************************************************************************************************
//***************************************************Cobranza********************************************************
//*********************************************************************************************************************
router.post('/cobranza/inmuebles', (req, res) => {
  try {
    let { fecha } = req.body;
    let f = new Date(fecha)
    let day = f.getDate()
    let month = f.getMonth() + 1
    let year = f.getFullYear()
    if (month < 9){
      month = '0' + month
    }
    if (day < 12){
      day = '0' + day
    }
    let query = `SELECT * FROM view_cobranza WHERE fecha_cobro = '${day}/${month}/${year}'`;
    console.log(query)
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/cobranza/cliente', (req, res) => {
  try {
    let { inmueble} = req.body;
    console.log(inmueble)
    let query = `SELECT CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre 
    FROM cliente c INNER JOIN inmueble i 
    on c.id_cliente = i.clave_cliente
    WHERE i.clave_inm = '${inmueble}'`;
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/cobranza/pago', async (req, res) => {
  try {
    let { nombre, monto, firma_elecronica} = req.body;

    let query =`CALL sp_agregar_cobranza(
      '${nombre}',
      '${monto}',
      '${firma_elecronica}'
    )`

    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.post('/cobranza/mantenimiento', async (req, res) => {
  try {
    let { nombre, monto, firma_elecronica, observaciones_mantenimiento } = req.body;

    let query =`CALL sp_agregar_cobranza_mantenimiento(
      '${nombre}',
      '${monto}',
      '${firma_elecronica}',
      '${observaciones_mantenimiento}'
    )`

    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});
//**********************************************************************************************************************
//***************************************************Materiales***************************************************
//**********************************************************************************************************************

router.post('/materiales/registrar', async (req, res) => {
  try {
    let { nombre, precio_c, precio_v } = req.body;

    let query =`CALL sp_agregar_material(
      '${nombre}',
      '${precio_c}',
      '${precio_v}'
    )`

    console.log(query);
    let resultado = await pool.query(query);
    return resultado;
  } catch (error) {
    throw error;
  }
  
});

router.get('/materiales/mostrar', (req, res) => {
  try {
    let query = 'SELECT * FROM view_materiales';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

//*********************************************************************************************************************
//***************************************************Reportes********************************************************
//*********************************************************************************************************************
router.get('/reportes/clientes', (req, res) => {
  try {
    let query = 'SELECT * FROM view_clientes';
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

router.post('/reportes/cobros', (req, res) => {
  try {
    let { fecha } = req.body;
    let f = new Date(fecha)
    let day = f.getDate()
    let month = f.getMonth() + 1
    let year = f.getFullYear()
    if (month < 9){
      month = '0' + month
    }
    if (day < 12){
      day = '0' + day
    }
    let query = `SELECT * FROM view_cobros WHERE fecha_cobro = '${year}-${day}-${month}'`;
    console.log(query)
    pool.query(query, function (err,rows) {
      if(err){
        res.json({
          error: true,
          message: err.message
        })
      } else {
        console.log(rows);
        res.json({
          error: false,
          message: 'OK',
          data: rows
        })
      }
    })
  } catch (error) {
    throw error;
  }
});

module.exports = router;
