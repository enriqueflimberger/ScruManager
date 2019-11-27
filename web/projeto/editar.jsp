
<!-- Import das classes necess�rias -->
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
    <jsp:attribute name="title">
        Projeto - editar
    </jsp:attribute>
    <jsp:attribute name="navbar">
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedor</a></li>
    <li class="divider-vertical"></li>    
    <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
    <li class="divider-vertical"></li>   
    <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
    <li><a href="#" onclick="window.location.reload(true);"><b>Editar</b></a></li>
</ul>
</div>
</jsp:attribute>

</t:wrapper-top>


<div class="main-content">

    <%
                    try {

                        // Registrar o driver JDBC para PostgreSQL
                        Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
                        // Conectar o banco
                        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
                        // Statement para executar os comandos sql
                        Statement st = conn.createStatement();

                        String query = "SELECT * FROM projInfo WHERE idproj = "+request.getParameter("idproj");
                        ResultSet rs = st.executeQuery(query);
                        
                        rs.next();
            %>           

    <form method="post" action="/ScruManager/projeto/alterar_registro.jsp">

        <div align="center" class="form-horizontal">

            <div class="form-title-row">

                <h2>Projeto - Editar</h2>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2 col-sm-offset-2" for="idproj">ID</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="idproj" name="idproj" readonly="true" value='<%= rs.getInt("idproj")%>'>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2 col-sm-offset-2" for="projName">Nome</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="projName" name="projName" value='<%= rs.getString("projName")%>'>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2 col-sm-offset-2" for="projdescription">Descrição</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="projdescription" name="projdescription" value='<%= rs.getString("projdescription")%>'>
                </div>
            </div>
               <div class="form-group-row">
                <input type="submit" value="Salvar alterações"/>

            </div>
        </div>

</form>

<%                
                    } catch (Exception e) {
                        out.write("Ocorreu um erro ao buscar o registro: <span style='color: red'>" + e.getMessage() + "</span>");
                    }                        
            %>

</div>

<t:wrapper-bottom/>




