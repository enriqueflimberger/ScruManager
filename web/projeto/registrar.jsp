<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
    <jsp:attribute name="title">
        Projeto - registrar
    </jsp:attribute>
    <jsp:attribute name="navbar">
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
    <li class="divider-vertical"></li>    
    <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
    <li class="divider-vertical"></li>   
    <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li><li><a href="projeto/registrar.jsp"><b>Registrar</b></a></li>
</ul>
</div>
</jsp:attribute>

</t:wrapper-top>


<form method="post" action="/ScruManager/projeto/incluir_registro.jsp">

    <div align="center" class="form-horizontal">
        <div class="text-center form-title-row">
            <h2>
                Registro de Projeto
            </h2>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2 col-sm-offset-2" for="projName">Nome:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="projName" name="projName" placeholder="Insira o nome">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2 col-sm-offset-2" for="projDescription">Descrição</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="projDescription" name="projDescription" placeholder="Insira a descrição">
            </div>
        </div>

        <div class="form-group-row">
            <input type="submit" value="Registrar"/>

            <input type="reset" value="Limpar"/>
        </div>
    </div>
</form>
<t:wrapper-bottom/>
