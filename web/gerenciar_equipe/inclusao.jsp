
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
            function incluirIntegrante(iddev, name, idteam, nickname) {
            
            if(nickname!==""){
                alert (iddev + ' - ' + name + ' já pertence a equipe ' + nickname);
            }else if (confirm('Deseja incluir ' + iddev + ' - ' + name + ' na equipe ' + nickname + '?')) {
                window.location.href = "/ScruManager/gerenciar_equipe/incluir_integrante.jsp?idteam="+idteam+"&iddev="+iddev+"&nickname="+nickname;
            } else {
                alert('Inclusão cancelada.');
            }        
            }
        </script>  
        </jsp:attribute>
    <jsp:attribute name="title">
            ${param.nickname} - lista
        </jsp:attribute>

        <jsp:attribute name="navbar">
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
            <li><a href="/ScruManager/gerenciar_equipe/listar.jsp?idteam=${param.idteam}&nickname=${param.nickname}">${param.nickname}</a></li>
            <li><a href="/ScruManager/gerenciar_equipe/inclusao.jsp?idteam=${param.idteam}&nickname=${param.nickname}"><b>Incluir integrante</b></a></li>

            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
            </jsp:attribute>

        <jsp:attribute name="localiza">
            <div  class="form-group row">
                <form class="col-sm-10" name="frmLocalizar" action="listar.jsp" method="POST">
                    <p><label for="desenvolvedor">Localizar:</label> <input type="text" name="localizaDesenvolvedor" value="" size="50"> 
                        <input type="submit" value="Pesquisar" name="btnLocaliza" /></p>
                </form>
            </div>
        </jsp:attribute>
            
                </t:wrapper-top>

    <table class="table table-hover table-bordered">

            <thead>
                <tr>
                <th class="col-sm-1">ID</th>
                <th class="col-sm-3">Nome</th>
                <th class="col-sm-3">Equipe</th>
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
                            String query = "SELECT * FROM devs FULL OUTER JOIN team ON (devs.iddev=team.devs_iddev) LEFT JOIN teamInfo ON (team.teaminfo_idteam=teamInfo.idteam);";
                            
                            request.setCharacterEncoding("UTF-8");

                            // Se foi informado um valor no campo de pesquisa, adicionar ao SQL
                            if ( request.getParameter("localizaDesenvolvedor") != null && request.getParameter("localizaDesenvolvedor") != "" )
                            {
                                String localizarValor = request.getParameter("localizaDesenvolvedor").toLowerCase();
                                out.write("<p>Pesquisando por: ");
                                out.write(localizarValor + "</p>");
                                
                                // Adicionar condição WHERE ao SQL
                                // Observe que o SQL busca o valor parcial (%) e em minúsculo (LOWER)
                                // Vamos pesquisar em todos os campos...
                                query += " WHERE LOWER(name) LIKE '%"+localizarValor+"%' OR LOWER(email) LIKE '%"+localizarValor+"%'";
                                
                                //out.write(query); // debug SQL
                            }
                            
                            ResultSet rs = st.executeQuery(query);

                            // Processar cada item do banco e adicionar uma linha na tabela
                            while (rs.next()) {
                                int iddev= rs.getInt("iddev");
                                int idteam = Integer.parseInt(request.getParameter("idteam"));
                                String name = rs.getString("name");
                                String nickname = rs.getString("nickname");
                                if (nickname==null){
                                    nickname="";
                                }
                %>
                <!-- Cria nova linha na tabela -->
                <tr>
                   <!-- Colunas da linha -->
                    <td class="col-sm-1"> <%=iddev%> </td>
                    <td class="col-sm-3"> <%=name%> </td>
                    <td class="col-sm-3"> <%=nickname%> </td>
                    <td class="col-sm-1"> <button onclick="incluirIntegrante(<%=iddev%>, '<%=name%>', <%=idteam%>, '<%=nickname%>');">Incluir</button>

                </tr>
                <%
                            } // Fim do while

                            rs.close();

                        } catch (Exception e) {
                            out.write("Ocorreu um erro ao buscar os desenvolvedores <span style='color: red'>" + e.getMessage() + "</span>");
                        } finally {
                        }

                    } catch (Exception e) {
                        out.write("Ocorreu um erro conectando a base: <span style='color: red'>" + e.getMessage() + "</span>");
                    }

                %>                

            </tbody>
        </table>        
<t:wrapper-bottom/>
