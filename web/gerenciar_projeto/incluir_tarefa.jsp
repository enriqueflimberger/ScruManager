
<%@page import="java.net.URLEncoder"%>
<%@ page import ="java.sql.*" %>


<%
    request.setCharacterEncoding("UTF-8");
    String taskName = request.getParameter("taskName");    
    String taskDescription = request.getParameter("taskDescription");
    String taskStatus = request.getParameter("taskStatus");    
    String idproj = request.getParameter("idproj");    
    String projname = request.getParameter("projname");    
    
    // Registrar o driver JDBC para PostgreSQL
    Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
    // Conectar o banco
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
    // Statement para executar a query
    Statement st = conn.createStatement();
    
    //ResultSet rs;
    String query = "INSERT INTO tasks(taskName, taskDescription, taskStatus, idProj) VALUES ('" + taskName + "','" + taskDescription + "','" + taskStatus + "','" + idproj + "');";
    
    int i = st.executeUpdate(query);
    
    // Verificar se o insert foi bem sucedido
    if (i > 0) {
        projname= URLEncoder.encode(projname, "UTF-8");
        response.sendRedirect("sucesso_registro.jsp?success=1&idproj="+idproj+"&projname="+projname);
    } else {
        response.sendRedirect("sucesso_registro.jsp?success=0");
    }
%>
