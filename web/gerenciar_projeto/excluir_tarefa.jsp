
<%@page import="java.net.URLEncoder"%>
<%@ page import ="java.sql.*" %>
<%
    String idtask = request.getParameter("idtask");
    String projname = request.getParameter("projname");
    String idproj = request.getParameter("idproj");
    
    // Registrar o driver JDBC para PostgreSQL
    Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
    // Conectar o banco
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
    // Statement para executar a query
    Statement st = conn.createStatement();
    
    //ResultSet rs;
    String query = "DELETE FROM tasks WHERE idtask='" + idtask +"';";
            int i = st.executeUpdate(query);
    
    // Verificar se o insert foi bem sucedido
    if (i > 0) {
        projname= URLEncoder.encode(projname, "UTF-8");
        response.sendRedirect("sucesso_registro.jsp?success=2&idproj="+idproj+"&projname="+projname);
    } else {
        response.sendRedirect("sucesso_registro.jsp?success=0");
    }
%>
