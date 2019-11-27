<%@ page import ="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idteam = request.getParameter("idteam");
    String nickname = request.getParameter("nickname");    

    try {
        // Registrar o driver JDBC para PostgreSQL
        Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
        // Conectar o banco
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
        // Statement para executar a query
        Statement st = conn.createStatement();

        //ResultSet rs;
        String query = "UPDATE teamInfo SET nickname = '" + nickname + "' WHERE idteam =  '" + idteam + "'";
        int i = st.executeUpdate(query);
        // Verificar se o update foi bem sucedido
        if (i > 0) {
            response.sendRedirect("sucesso_registro.jsp?success=3");
        } else {
            response.sendRedirect("sucesso_registro.jsp?success=0");
        }

        out.print("<br> <a href='listar.jsp'>Voltar.</a>");

    } catch (Exception e) {
        out.write("Ocorreu um erro ao buscar o registro: <span style='color: red'>" + e.getMessage() + "</span>");
        out.print(" <br> <a href='listar.jsp'>Voltar.</a>");
    }
%>
