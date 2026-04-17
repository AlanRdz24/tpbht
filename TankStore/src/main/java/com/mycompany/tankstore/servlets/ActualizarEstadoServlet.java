/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tankstore.servlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author alanj
 */
@WebServlet(name = "ActualizarEstadoServlet", urlPatterns = {"/ActualizarEstadoServlet"})
public class ActualizarEstadoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String indiceStr = request.getParameter("indice");
        String nuevoEstado = request.getParameter("nuevoEstado");

        if (indiceStr == null || nuevoEstado == null) {
            response.sendRedirect("ListarProyectosServlet");
            return;
        }

        int indice = Integer.parseInt(indiceStr);

        String rutaRelativa = "/TankStore_Data/proyectos.txt";
        String rutaAbsoluta = getServletContext().getRealPath(rutaRelativa);

        List<String> lineas = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(rutaAbsoluta))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                lineas.add(linea);
            }
        }

        if (indice >= 0 && indice < lineas.size()) {
            String[] datos = lineas.get(indice).split(",");
            if (datos.length >= 3) {
                String lineaActualizada = datos[0].trim() + "," + datos[1].trim() + "," + nuevoEstado;
                lineas.set(indice, lineaActualizada);
            }
        }

        try (FileWriter fw = new FileWriter(rutaAbsoluta, false);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            for (String linea : lineas) {
                out.println(linea);
            }
        }

        response.sendRedirect("ListarProyectosServlet");
    }
}
