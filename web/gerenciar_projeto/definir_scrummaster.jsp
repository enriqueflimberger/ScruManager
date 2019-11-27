<%@page import="java.net.URLEncoder"%>
<%@ page import ="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idteam = request.getParameter("idteam");
    String iddev = request.getParameter("iddev");
    String nickname = request.getParameter("nickname");

    try {
        // Registrar o driver JDBC para PostgreSQL
        Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
        // Conectar o banco
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
        // Statement para executar a query
        Statement st = conn.createStatement();

        //ResultSet rs;
        String query = "UPDATE team SET isscrummaster = false; UPDATE team SET isscrummaster = true WHERE devs_iddev =  '" + iddev + "' AND teaminfo_idteam = '" + idteam + "'";
        int i = st.executeUpdate(query);
        // Verificar se o update foi bem sucedido
        if (i > 0) {
            nickname= URLEncoder.encode(nickname, "UTF-8");
            response.sendRedirect("sucesso_registro.jsp?success=3&idteam="+idteam+"&nickname="+nickname);
        } else {
            response.sendRedirect("sucesso_registro.jsp?success=0");
        }

        out.print("<br> <a href='listar.jsp'>Voltar.</a>");

    } catch (Exception e) {
        out.write("Ocorreu um erro ao buscar o registro: <span style='color: red'>" + e.getMessage() + "</span>");
        out.print(" <br> <a href='listar.jsp'>Voltar.</a>");
    }
%>
