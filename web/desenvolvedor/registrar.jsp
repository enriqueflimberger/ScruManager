<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
    <jsp:attribute name="title">
        Desenvolvedor - registrar
    </jsp:attribute>
    <jsp:attribute name="navbar">
        <li class="divider-vertical"></li>
        <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a><li><a href="desenvolvedor/registrar.jsp"><b>Registrar</b></a></li></li>
    <li class="divider-vertical"></li>    
    <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
    <li class="divider-vertical"></li>   
    <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
</ul>
</div>
</jsp:attribute>

</t:wrapper-top>


<form method="post" action="/ScruManager/desenvolvedor/incluir_registro.jsp">

    <div align="center" class="form-horizontal">
        <div class="text-center form-title-row">
            <h2>
                Registro de Desenvolvedor
            </h2>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2 col-sm-offset-2" for="name">Nome:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="name" name="name" placeholder="Insira o nome" required>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2 col-sm-offset-2" for="email">email</label>
            <div class="col-sm-4"> 
                <input type="text" class="form-control" id="email" name="email" placeholder="Insira o email" required>
            </div>
        </div>

        <div class="form-group-row">
            <input type="submit" value="Registrar"/>

            <input type="reset" value="Limpar"/>
        </div>
    </div>
</form>
<t:wrapper-bottom/>