
<%@ page import ="java.sql.*" %>


<%
    request.setCharacterEncoding("UTF-8");
    String nickname = request.getParameter("nickname");
    
    // Registrar o driver JDBC para PostgreSQL
    Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
    // Conectar o banco
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
    // Statement para executar a query
    Statement st = conn.createStatement();
    
    //ResultSet rs;
    String query = "INSERT INTO teamInfo(nickname) VALUES ('" + nickname + "')";
    int i = st.executeUpdate(query);
    
    // Verificar se o insert foi bem sucedido
    if (i > 0) {
        response.sendRedirect("sucesso_registro.jsp?success=1");
    } else {
        response.sendRedirect("sucesso_registro.jsp?success=0");
    }
%>
