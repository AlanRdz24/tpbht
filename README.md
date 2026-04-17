# TankStore - Sistema de Gestión de Proyectos

## 1. Resumen Ejecutivo

### Descripción
TankStore es una aplicación web diseñada para el seguimiento y administración de proyectos internos. Permite centralizar la información de hitos, tareas y recursos en un entorno ligero y eficiente.

### Problema Identificado
Muchas empresas pequeñas carecen de un sistema formal para rastrear el progreso de sus proyectos, dependiendo de hojas de cálculo aisladas que dificultan la colaboración y la integridad de los datos.

### Solución
Una plataforma basada en Jakarta EE que ofrece autenticación de usuarios y persistencia de datos simplificada, facilitando la portabilidad y el despliegue rápido sin necesidad de motores de bases de datos complejos.

### Arquitectura
El sistema sigue un patrón de diseño de N-capas:
* **Capa de Presentación:** HTML5, CSS3 y JavaScript.
* **Capa de Negocio:** Servlets de Java (Jakarta EE 10).
* **Capa de Datos:** Persistencia en archivos planos (.txt) con acceso mediante I/O de Java.

---

## 2. Tabla de Contenidos
* [Requerimientos](#3-requerimientos)
* [Instalación](#4-instalación)
* [Configuración](#5-configuración)
* [Manual de Uso](#6-uso)
* [Guía de Contribución](#7-contribución)
* [Roadmap](#8-roadmap)

---

## 3. Requerimientos
* **Java:** Versión 21 (JDK).
* **Servidor de Aplicaciones:** GlassFish 7.0.x.
* **Entorno de Desarrollo:** NetBeans IDE 21.
* **Navegador:** Chrome, Firefox o Edge (versiones recientes).
* **Paquetes:** Jakarta EE 10 Web API.

---

## 4. Instalación

### Ambiente de Desarrollo
1. Clonar el repositorio: `git clone https://github.com/AlanRdz24/tpbht.git`
2. Abrir el proyecto en NetBeans.
3. Configurar el servidor GlassFish en la pestaña "Services".
4. Realizar "Clean and Build".

### Pruebas Manuales
1. Ejecutar el proyecto (F6).
2. Acceder a `http://localhost:8080/TankStore`.
3. Probar credenciales con los datos almacenados en `/TankStore_Data/usuarios.txt`.

---

## 5. Configuración
* **Persistencia:** La carpeta `TankStore_Data` debe estar presente en el directorio raíz de despliegue definido por el ServletContext.
* **Usuarios:** El archivo `usuarios.txt` debe mantener el formato `usuario,contraseña`.

---

## 6. Uso

### Para Usuario Final
1. Ingresar al login.
2. Introducir credenciales autorizadas.
3. Visualizar el tablero principal de proyectos (En desarrollo).

### Para Administrador
* Gestión de usuarios directamente en el archivo `usuarios.txt`.
* Monitoreo de logs en la consola de GlassFish.

---

## 7. Contribución
1. Realizar un **Fork** del proyecto.
2. Crear un nuevo branch: `git checkout -b feature/nueva-funcionalidad`.
3. Realizar los cambios y hacer commit: `git commit -m "Añadida nueva funcionalidad"`.
4. Enviar un **Pull Request** a la rama `develop`.
5. Esperar la revisión y el **Merge**.

---

## 8. Roadmap
* **Fase 1 (Próximamente):** Implementación de búsqueda de proyectos.
* **Fase 2:** Generación de reportes en PDF.
* **Fase 3:** Interfaz responsiva para dispositivos móviles.
