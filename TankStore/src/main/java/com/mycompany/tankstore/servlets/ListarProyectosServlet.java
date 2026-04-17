/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tankstore.servlets;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author alanj
 */
@WebServlet(name = "ListarProyectosServlet", urlPatterns = {"/ListarProyectosServlet"})
public class ListarProyectosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("index.html");
            return;
        }

        // Leer el archivo proyectos.txt
        String rutaRelativa = "/TankStore_Data/proyectos.txt";
        String rutaAbsoluta = getServletContext().getRealPath(rutaRelativa);

        // Lista para guardar cada proyecto como un arreglo de Strings
        List<String[]> listaProyectos = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(rutaAbsoluta))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                // Cada línea tiene formato: nombre,responsable,estado
                String[] datos = linea.split(",");
                if (datos.length >= 3) {
                    listaProyectos.add(datos);
                }
            }
        } catch (IOException e) {
            System.err.println("Error al leer proyectos: " + e.getMessage());
        }

        String usuario = (String) session.getAttribute("usuarioLogueado");
        request.setAttribute("usuario", usuario);
        request.setAttribute("proyectos", listaProyectos);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para listar todos los proyectos desde proyectos.txt";
    }
}
