
<%@ page import ="java.sql.*" %>
<%
    String iddev = request.getParameter("iddev");
    
    // Registrar o driver JDBC para PostgreSQL
    Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
    // Conectar o banco
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
    // Statement para executar a query
    Statement st = conn.createStatement();
    
    //ResultSet rs;
    String query = "DELETE FROM devs WHERE iddev='" + iddev + "';";
            int i = st.executeUpdate(query);
    
    // Verificar se o insert foi bem sucedido
    if (i > 0) {
        response.sendRedirect("sucesso_registro.jsp?success=2");
    } else {
        response.sendRedirect("sucesso_registro.jsp?success=0");
    }
%>
