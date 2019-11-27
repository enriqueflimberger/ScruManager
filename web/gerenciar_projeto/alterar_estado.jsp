<%@ page import ="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idproj = request.getParameter("idproj");
    String projname = request.getParameter("projname");
    String idtask = request.getParameter("idtask");
    String taskstatus = request.getParameter("taskstatus");    
   
    try {
        // Registrar o driver JDBC para PostgreSQL
        Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
        // Conectar o banco
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
        // Statement para executar a query
        Statement st = conn.createStatement();

        //ResultSet rs;
        String query = "UPDATE tasks SET taskstatus = '" + taskstatus + "' WHERE idtask =  '" + idtask + "'";
        int i = st.executeUpdate(query);
        // Verificar se o update foi bem sucedido
        if (i > 0) {
            response.sendRedirect("sucesso_registro.jsp?success=3&idproj="+idproj+"&projname="+projname);
        } else {
            response.sendRedirect("sucesso_registro.jsp?success=0");
        }

        out.print("<br> <a href='listar.jsp'>Voltar.</a>");

    } catch (Exception e) {
        out.write("Ocorreu um erro ao buscar o registro: <span style='color: red'>" + e.getMessage() + "</span>");
        out.print(" <br> <a href='listar.jsp'>Voltar.</a>");
    }
%>
