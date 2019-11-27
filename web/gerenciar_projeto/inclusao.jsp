<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
   
    <jsp:attribute name="title">
        ${param.projname} - inclusão de tarefa
    </jsp:attribute>

    <jsp:attribute name="navbar">
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
        <li><a href="/ScruManager/gerenciar_projeto/listar.jsp?idproj=${param.idproj}&projname=${param.projname}">${param.projname}</a></li>
        <li><a href="/ScruManager/gerenciar_projeto/inclusao.jsp?idproj=${param.idproj}&projname=${param.projname}"><b>Incluir tarefa</b></a></li>

    </jsp:attribute>

</t:wrapper-top>

    <form method="post" action="/ScruManager/gerenciar_projeto/incluir_tarefa.jsp">

    <div align="center" class="form-horizontal">
        <div class="text-center form-title-row">
            <h2>
                Inclusão de Tarefa - Projeto ${param.projname}
            </h2>
        </div>
        <div class="form-group">
            <input type="hidden" name="idproj" value=${param.idproj}>
            <input type="hidden" name="projname" value=${projname}>
            <input type="hidden" name="taskStatus" value="0">
            <label class="control-label col-sm-2 col-sm-offset-2" for="taskName">Nome:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="taskName" name="taskName" placeholder="Insira o nome da tarefa">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2 col-sm-offset-2" for="taskDescription">Descrição da tarefa</label>
            <div class="col-sm-4"> 
                <input type="text" class="form-control" id="taskDescription" name="taskDescription" placeholder="Insira a descrição para a tarefa">
            </div>
        </div>

        <div class="form-group-row">
            <input type="submit" value="Registrar"/>

            <input type="reset" value="Limpar"/>
        </div>
    </div>
</form>
        
<t:wrapper-bottom/>
