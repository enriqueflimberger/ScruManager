
<%@ page import ="java.sql.*" %>


<%
    request.setCharacterEncoding("UTF-8");
    String projName = request.getParameter("projName");
    String projDescription = request.getParameter("projDescription");

        
    // Registrar o driver JDBC para PostgreSQL
    Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
    // Conectar o banco
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
    // Statement para executar a query
    Statement st = conn.createStatement();
    
    //ResultSet rs;
    String query = "INSERT INTO projInfo(projName, projDescription) VALUES ('" + projName + "', '" + projDescription + "')";
    int i = st.executeUpdate(query);
    
    // Verificar se o insert foi bem sucedido
    if (i > 0) {
        response.sendRedirect("sucesso_registro.jsp?success=1");
    } else {
        response.sendRedirect("sucesso_registro.jsp?success=0");
    }
%>
