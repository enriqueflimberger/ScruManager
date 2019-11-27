
<!-- Import das classes necess�rias -->
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
    <jsp:attribute name="title">
        Desenvolvedor - editar
    </jsp:attribute>
    <jsp:attribute name="navbar">
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
        <li><a href="/ScruManager/gerenciar_projeto/listar.jsp?idproj=${param.idproj}&projname=${param.projname}">${param.projname}</a></li>
        <li><a href="/ScruManager/gerenciar_projeto/inclusao.jsp?idproj=${param.idproj}&projname=${param.projname}"><b>Editar tarefa</b></a></li>

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

            String query = "SELECT * FROM tasks LEFT JOIN projInfo ON (tasks.idProj=projInfo.idproj) WHERE tasks.idtask = " + request.getParameter("idtask");
            ResultSet rs = st.executeQuery(query);

            rs.next();
    %>            

    <form method="post" action="/ScruManager/gerenciar_projeto/alterar_tarefa.jsp">

        <div align="center" class="form-horizontal">

            <div class="form-title-row">

                <h2>Tarefa - Editar</h2>
            </div>
            
            <input type='hidden' name="idproj" value=${param.idproj}>
            <input type='hidden' name="projname" value=${param.projname}>

            <div class="form-group">
                <label class="control-label col-sm-2 col-sm-offset-2" for="idtask">ID</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="idtask" name="idtask" readonly="true" value='<%= rs.getInt("idtask")%>'>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2 col-sm-offset-2" for="name">Nome</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="taskName" name="taskname" value='<%= rs.getString("taskName")%>'>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2 col-sm-offset-2" for="taskDescription">Descrição</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="taskDescription" name="taskdescription" value='<%= rs.getString("taskDescription")%>'>
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