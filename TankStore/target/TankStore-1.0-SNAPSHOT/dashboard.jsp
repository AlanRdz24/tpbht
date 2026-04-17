<%-- 
    Document   : dashboard
    Created on : 16 abr 2026, 8:23:04 p.m.
    Author     : alanj
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - TankStore</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        /*NAVBAR*/
        .navbar {
            background-color: #003366;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .navbar h1 { margin: 0; font-size: 20px; }
        .navbar .nav-links {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .navbar a:hover { background-color: #004d99; }
        .navbar a.active { background-color: #0056b3; }
        .navbar .user-info { font-size: 14px; opacity: 0.9; }

        /*CONTENIDO*/
        .container {
            max-width: 1050px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .page-header h2 { margin: 0; color: #333; }

        /*TARJETAS RESUMEN*/
        .resumen {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }
        .resumen-card {
            background: white;
            border-radius: 8px;
            padding: 15px 20px;
            flex: 1;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            text-align: center;
        }
        .resumen-card .numero {
            font-size: 32px;
            font-weight: bold;
            color: #003366;
        }
        .resumen-card .etiqueta {
            font-size: 13px;
            color: #777;
            margin-top: 5px;
        }

        /*TABLA*/
        .tabla-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        table { width: 100%; border-collapse: collapse; }
        thead { background-color: #003366; color: white; }
        th {
            padding: 14px 15px;
            text-align: left;
            font-size: 14px;
            font-weight: 600;
        }
        td {
            padding: 10px 15px;
            font-size: 14px;
            color: #444;
            border-bottom: 1px solid #eee;
        }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #f0f4ff; }
        .numero-fila { color: #999; font-weight: bold; }

        .badge {
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }
        .badge-progreso { background-color: #fff3cd; color: #856404; }
        .badge-terminado { background-color: #d4edda; color: #155724; }
        .badge-cancelado { background-color: #f8d7da; color: #721c24; }
        .badge-pendiente { background-color: #e2e3e5; color: #383d41; }

        /*FORMULARIO ESTADO*/
        .form-estado {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .select-estado {
            padding: 5px 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 13px;
            background-color: white;
            cursor: pointer;
        }
        .select-estado:focus {
            outline: none;
            border-color: #0056b3;
        }
        .btn-actualizar {
            background-color: #0056b3;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-actualizar:hover { background-color: #004494; }

        /*BOTÓN ELIMINAR*/
        .btn-eliminar {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-eliminar:hover { background-color: #a71d2a; }

        /*COLUMNA*/
        .acciones {
            display: flex;
            gap: 6px;
            align-items: center;
        }

        .mensaje-vacio {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        .mensaje-vacio p { font-size: 16px; }

        /*BOTÓN GENERAL*/
        .btn {
            background-color: #0056b3;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            display: inline-block;
        }
        .btn:hover { background-color: #004494; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>📊 TankStore Proyectos</h1>
        <div class="nav-links">
            <a href="ListarProyectosServlet" class="active">Dashboard</a>
            <a href="nuevo-proyecto.html">+ Nuevo Proyecto</a>
            <span class="user-info">👤 <%= request.getAttribute("usuario") %></span>
            <a href="index.html" style="background-color: rgba(255,255,255,0.15);">Cerrar Sesión</a>
        </div>
    </div>

    <div class="container">

        <%
            List<String[]> proyectos = (List<String[]>) request.getAttribute("proyectos");
            int total = (proyectos != null) ? proyectos.size() : 0;
            int enProgreso = 0, terminados = 0, cancelados = 0, pendientes = 0;

            if (proyectos != null) {
                for (String[] p : proyectos) {
                    String est = p[2].trim().toLowerCase();
                    if (est.equals("en progreso")) enProgreso++;
                    else if (est.equals("terminado")) terminados++;
                    else if (est.equals("cancelado")) cancelados++;
                    else if (est.equals("pendiente")) pendientes++;
                }
            }
        %>

        <!-- RESUMEN -->
        <div class="resumen">
            <div class="resumen-card">
                <div class="numero"><%= total %></div>
                <div class="etiqueta">Total</div>
            </div>
            <div class="resumen-card">
                <div class="numero" style="color:#856404;"><%= enProgreso %></div>
                <div class="etiqueta">En Progreso</div>
            </div>
            <div class="resumen-card">
                <div class="numero" style="color:#155724;"><%= terminados %></div>
                <div class="etiqueta">Terminados</div>
            </div>
            <div class="resumen-card">
                <div class="numero" style="color:#721c24;"><%= cancelados %></div>
                <div class="etiqueta">Cancelados</div>
            </div>
        </div>

        <div class="page-header">
            <h2>Listado de Proyectos</h2>
            <a href="nuevo-proyecto.html" class="btn">+ Registrar Proyecto</a>
        </div>

        <div class="tabla-container">
            <% if (proyectos != null && !proyectos.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre del Proyecto</th>
                        <th>Responsable</th>
                        <th>Estatus Actual</th>
                        <th>Cambiar Estado</th>
                        <th>Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < proyectos.size(); i++) {
                            String nombre = proyectos.get(i)[0].trim();
                            String responsable = proyectos.get(i)[1].trim();
                            String estado = proyectos.get(i)[2].trim();

                            String badgeClass = "badge-pendiente";
                            if (estado.equalsIgnoreCase("En Progreso")) badgeClass = "badge-progreso";
                            else if (estado.equalsIgnoreCase("Terminado")) badgeClass = "badge-terminado";
                            else if (estado.equalsIgnoreCase("Cancelado")) badgeClass = "badge-cancelado";
                    %>
                    <tr>
                        <td class="numero-fila"><%= (i + 1) %></td>
                        <td><strong><%= nombre %></strong></td>
                        <td><%= responsable %></td>
                        <td><span class="badge <%= badgeClass %>"><%= estado %></span></td>
                        <td>
                            <form action="ActualizarEstadoServlet" method="POST" class="form-estado">
                                <input type="hidden" name="indice" value="<%= i %>">
                                <select name="nuevoEstado" class="select-estado">
                                    <option value="En Progreso" <%= estado.equalsIgnoreCase("En Progreso") ? "selected" : "" %>>🟡 En Progreso</option>
                                    <option value="Pendiente" <%= estado.equalsIgnoreCase("Pendiente") ? "selected" : "" %>>⚪ Pendiente</option>
                                    <option value="Terminado" <%= estado.equalsIgnoreCase("Terminado") ? "selected" : "" %>>🟢 Terminado</option>
                                    <option value="Cancelado" <%= estado.equalsIgnoreCase("Cancelado") ? "selected" : "" %>>🔴 Cancelado</option>
                                </select>
                                <button type="submit" class="btn-actualizar">Actualizar</button>
                            </form>
                        </td>
                        <td>
                            <form action="EliminarProyectoServlet" method="POST"
                                  onsubmit="return confirm('¿Estás seguro de eliminar el proyecto: <%= nombre %>?');">
                                <input type="hidden" name="indice" value="<%= i %>">
                                <button type="submit" class="btn-eliminar">🗑️ Eliminar</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <% } else { %>
            <div class="mensaje-vacio">
                <p>📁 No hay proyectos registrados aún.</p>
                <a href="nuevo-proyecto.html" class="btn">Crear el primero</a>
            </div>
            <% } %>
        </div>

    </div>

</body>
</html>