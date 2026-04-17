/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tankstore.servlets;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author alanj
 */
@WebServlet(name = "RegistroProyectoServlet", urlPatterns = {"/RegistroProyectoServlet"})
public class RegistroProyectoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recibir los datos del formulario HTML
        String nombreProyecto = request.getParameter("nombre");
        String responsable = request.getParameter("responsable");
        String estado = request.getParameter("estado");

        // Si no viene estado del formulario, poner uno por defecto
        if (estado == null || estado.isEmpty()) {
            estado = "En Progreso";
        }

        // Definir la ruta dinámica
        String rutaRelativa = "/TankStore_Data/proyectos.txt";
        String rutaAbsoluta = getServletContext().getRealPath(rutaRelativa);

        // Escribir en el archivo de texto
        try (FileWriter fw = new FileWriter(rutaAbsoluta, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            // Guardamos la linea separada por comas
            out.println(nombreProyecto + "," + responsable + "," + estado);

            // Dirige al dashboard para ver el proyecto
            response.sendRedirect("ListarProyectosServlet");

        } catch (IOException e) {
            // Manejo de error si la carpeta TankStore_Data no existe
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter htmlOut = response.getWriter()) {
                htmlOut.println("<html><body>");
                htmlOut.println("<h2 style='color:red;'>Error al guardar: " + e.getMessage() + "</h2>");
                htmlOut.println("<a href='nuevo-proyecto.html'>Volver al formulario</a>");
                htmlOut.println(" | <a href='ListarProyectosServlet'>Ir al Dashboard</a>");
                htmlOut.println("</body></html>");
            }
        }
    }
}
