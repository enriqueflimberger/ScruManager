<%-- 
    Document   : main
    Created on : 28/04/2018, 01:03:43
    Author     : enriquelimberger
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper-top>
    <jsp:attribute name="title">
        Página Principal
    </jsp:attribute>
    <jsp:attribute name="navbar">
        <li><a href="desenvolvedor/listar.jsp">Desenvolvedor</a></li>
        <li><a href="equipe/listar.jsp">Equipes</a></li>
        <li><a href="projeto/listar.jsp">Projetos</a></li>
    </ul>
</div>
</jsp:attribute>
</t:wrapper-top>

<!-- Conteúdo central da página-->
<div class="text-center">
    <h2>
        Bem vindo ao ScruManager
    </h2>
    <p>
        Navegue pelo menu acima
    </p>
</div>
<!-- Fim do conteúdo central da página-->
<t:wrapper-bottom/>