<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>



<t:wrapper-top>
     
    <jsp:attribute name="head">
        <script>
<!-- Função javascript para chamar edição de registro -->
            function definirScrummaster(teaminfo_idteam, iddev, name, isscrummaster, nickname) {
                if (isscrummaster){
                    alert (iddev + ' - ' + name + ' é o atual Scrummaster');
                }else if (confirm('Deseja definir ' + iddev + ' - ' + name + ' como novo Scrummaster?')) {
                    window.location.href = "/ScruManager/gerenciar_equipe/definir_scrummaster.jsp?idteam=" + teaminfo_idteam + "&iddev=" + iddev + "&nickname=" + nickname;
                } else {
                    alert('Alteração cancelada.');
                }
            }
            
            <!-- Função javascript para chamar Srvlet de exclusão de registro -->
            function excluirRegistro(idteam, nickname, iddev, name, isscrummaster) {
                if (isscrummaster){
                    alert('Impossível excluir o Scrummaster');
                }
                else if (confirm('Confirma exclusão do membro ' + iddev + ' - ' + name + '?')) {
                    window.location.href = "/ScruManager/gerenciar_equipe/excluir_registro.jsp?idteam=" + idteam + "&nickname=" + nickname + "&iddev=" + iddev;
                } else {
                    alert('Exclusão cancelada.');
                }
            }
    </script>       
        </jsp:attribute>

        <jsp:attribute name="title">
            Gerenciar equipe
        </jsp:attribute>
       
            
        <jsp:attribute name="navbar">
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
            <li><a href="/ScruManager/gerenciar_equipe/listar.jsp?idteam=${param.idteam}&nickname=${param.nickname}"><b>${param.nickname}</b></a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
            </jsp:attribute>

        <jsp:attribute name="localiza">
            <div  class="form-group row">
                <form class="col-sm-10" name="frmLocalizar" action="listar.jsp?idteam=${param.idteam}&nickname=${param.nickname}" method="POST">
                    <p><label for="desenvolvedor">Localizar:</label> <input type="text" name="localizaEntrada" value="" size="50"> 
                        <input type="submit" value="Pesquisar" name="btnLocaliza" /></p>
                </form>
                <form class="col-sm-2" action="/ScruManager/gerenciar_equipe/inclusao.jsp" method="get">
                    <input type="hidden" name="idteam" id="idteam" value="${param.idteam}" />
                    <input type="hidden" name="nickname" id="nickname" value="${param.nickname}" />
                    <input type="submit" value="Incluir Novo integrante"/>
                </form>
            </div>
        </jsp:attribute>

    </t:wrapper-top>

    <!--Início conteúdo central-->

    <!-- Formulário com campo para pesquisar equipe -->

    <table class="table table-hover table-bordered">
        <thead>
            <tr>
                <th class="col-sm-1">ID</th>
                <th class="col-sm-3">Nome</th>
                <th class="col-sm-1">Scrummaster</th>
                <th class="col-sm-1"></th>
            </tr>
        </thead>
        <tbody>

            <!-- Buscar registros no banco de dados
                 Cada linha da tabela apresentará um registro da tabela "dev" -->
            <%
                    try {

                        // Registrar o driver JDBC para PostgreSQL
                        Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
                        // Conectar o banco
                        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
                        // Statement para executar os comandos sql
                        Statement st = conn.createStatement();

                        try {
                            String query = "SELECT * FROM devs JOIN team ON (devs.iddev=team.devs_iddev) JOIN teamInfo ON team.teaminfo_idteam=teaminfo.idteam WHERE team.teaminfo_idteam="+request.getParameter("idteam");

                            request.setCharacterEncoding("UTF-8");

                            // Se foi informado um valor no campo de pesquisa, adicionar ao SQL
                            if ( request.getParameter("localizaEntrada") != null && request.getParameter("localizaEntrada") != "" )
                            {
                                String localizarValor = request.getParameter("localizaEntrada").toLowerCase();
                                out.write("<p>Pesquisando por: ");
                                out.write(localizarValor + "</p>");

                                // Adicionar condição WHERE ao SQL
                                // Observe que o SQL busca o valor parcial (%) e em minúsculo (LOWER)
                                // Vamos pesquisar em todos os campos...
                                query += " AND LOWER(devs.name) LIKE '%"+localizarValor+"%'";

                                //out.write(query); // debug SQL
                            }

                            ResultSet rs = st.executeQuery(query);
                            // Processar cada item do banco e adicionar uma linha na tabela
                            while (rs.next()) {
                                int iddev=rs.getInt("iddev");
                                String name= rs.getString("name");
                                String checked= request.getContextPath() + "/images/box-unchecked.png";
                                if (rs.getBoolean("isscrummaster")){
                                    checked= request.getContextPath() + "/images/box-checked.png";
                                }
                                int idteam= rs.getInt("teaminfo_idteam");
                                String nickname= rs.getString("nickname");
                                boolean isScrummaster=rs.getBoolean("isscrummaster");
                                
                %>
            <!-- Cria nova linha na tabela -->
            <tr>                              
                <!-- Colunas da linha -->
                <td class="col-sm-1"> <%= iddev%> </td>
                <td class="col-sm-3"> <%= name%> </td>
                <td class="col-sm-1"> <button onclick= "definirScrummaster(<%=idteam%>, <%=iddev%>, '<%=name%>', <%=isScrummaster%>, '<%=nickname%>');"><img width= "20px" src=<%=checked%> /></button>
                <td class="col-sm-1"> <button onclick= "excluirRegistro(<%=idteam%>, '<%=nickname%>', <%=iddev%>,  '<%=name%>', <%=isScrummaster%>);"><img width= "20px" src="<%=request.getContextPath()%>/images/delete.png" /></button>


            </tr>
            <%
                        } // Fim do while

                        rs.close();

                    } catch (Exception e) {
                        out.write("Ocorreu um erro ao buscar as equipes <span style='color: red'>" + e.getMessage() + "</span>");
                    } finally {
                    }

                } catch (Exception e) {
                    out.write("Ocorreu um erro conectando a base: <span style='color: red'>" + e.getMessage() + "</span>");
                }

            %>                       

        </tbody>
    </table> 
</div>

<!--Fim conteúdo central-->

<t:wrapper-bottom/>




