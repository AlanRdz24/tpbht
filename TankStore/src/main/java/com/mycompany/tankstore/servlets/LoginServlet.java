package com.mycompany.tankstore.servlets;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author alanj
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.html");
    }

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String user = request.getParameter("usuario");
    String pass = request.getParameter("password");
    boolean loginExitoso = false;

    String rutaRelativa = getServletContext().getRealPath("/TankStore_Data/usuarios.txt");

    try (BufferedReader br = new BufferedReader(new FileReader(rutaRelativa))) {
        String linea;
        while ((linea = br.readLine()) != null) {
            String[] credenciales = linea.split(",");
            if (credenciales.length == 2 && credenciales[0].equals(user) && credenciales[1].equals(pass)) {
                loginExitoso = true;
                break;
            }
        }
    } catch (Exception e) {
        System.err.println("Error: No se encontró el archivo en la ruta: " + rutaRelativa);
    }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (loginExitoso) {
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogueado", user);
                
                response.sendRedirect("ListarProyectosServlet");
            } else {
                out.println("<html><body>");
                out.println("<h3 style='color:red;'>Error: Usuario o contraseña incorrectos.</h3>");
                out.println("<a href='index.html'>Volver a intentar</a>");
                out.println("</body></html>");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de autenticación para TankStore";
    }
}