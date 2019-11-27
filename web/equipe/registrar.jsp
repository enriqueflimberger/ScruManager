<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
    <jsp:attribute name="title">
        Equipe - regstrar
    </jsp:attribute>
    <jsp:attribute name="navbar">
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
    <li class="divider-vertical"></li>    
    <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a><li><a href="equipe/registrar.jsp"><b>Registrar</b></a></li></li>
    <li class="divider-vertical"></li>   
    <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
</ul>
</div>
</jsp:attribute>

</t:wrapper-top>


<form method="post" action="/ScruManager/equipe/incluir_registro.jsp">

    <div align="center" class="form-horizontal">
        <div class="text-center form-title-row">
            <h2>
                Registro de Equipe
            </h2>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2 col-sm-offset-2" for="nickname">Nome:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="nickname" name="nickname" placeholder="Insira o nome">
            </div>
        </div>

        <div class="form-group-row">
            <input type="submit" value="Registrar"/>

            <input type="reset" value="Limpar"/>
        </div>
    </div>
</form>
<t:wrapper-bottom/>
