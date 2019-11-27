
<%@page import="java.net.URLEncoder"%>
<%@ page import ="java.sql.*" %>


<%
    request.setCharacterEncoding("UTF-8");
    String idproj = request.getParameter("idproj");    
    String idteam = request.getParameter("idteam");
    String projName = request.getParameter("projname");
    
    // Registrar o driver JDBC para PostgreSQL
    Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
    // Conectar o banco
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
    // Statement para executar a query
    Statement st = conn.createStatement();
    
    //ResultSet rs;
    String query = "UPDATE projInfo SET teamInfo_idTeam="+idteam+"WHERE idproj="+idproj;
    int i = st.executeUpdate(query);
    
    // Verificar se o insert foi bem sucedido
    if (i > 0) {
        projName= URLEncoder.encode(projName, "UTF-8");
        response.sendRedirect("sucesso_registro.jsp?success=3&idproj="+idproj+"&projname="+projName);
    } else {
        response.sendRedirect("sucesso_registro.jsp?success=0");
    }
%>
