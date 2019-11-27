
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
            function definirEquipe(idproj, projName, idteam, nickname) {
            
            if(projName!==""){
                alert ('Equipe ' + idteam + ' - ' + nickname + ' já possui um projeto ');
            }else if (confirm('Deseja definir ' + idteam + ' - ' + nickname + ' como responsável do projeto ' + projName + '?')) {
                window.location.href = "/ScruManager/gerenciar_projeto/definir_responsavel.jsp?idproj="+idproj+"&projname=${param.projname}&idteam="+idteam;
            } else {
                alert('Operação cancelada.');
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
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
            <li><a href="/ScruManager/gerenciar_projeto/listar.jsp?idproj=${param.idproj}&projname=${param.projname}">${param.projname}</a></li>
            <li><a href="#" onclick="window.location.reload(true);"><b>Definir equipe responsável</b></a></li>

            </jsp:attribute>

        <jsp:attribute name="localiza">
            <div  class="form-group row">
                <form class="col-sm-10" name="frmLocalizar" action="definicaoResponsavel.jsp" method="POST">
                    <p><label for="desenvolvedor">Localizar:</label> <input type="text" name="localizaEquipe" value="" size="50"> 
                        <input type="submit" value="Pesquisar" name="btnLocaliza" /></p>
                </form>
            </div>
        </jsp:attribute>
            
                </t:wrapper-top>

    <table class="table table-hover table-bordered">

            <thead>
                <tr>
                <th class="col-sm-1">ID-equipe</th>
                <th class="col-sm-3">Nome</th>
                <th class="col-sm-3">Projeto</th>
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
                            String query = "SELECT * FROM projInfo RIGHT JOIN teamInfo ON (projInfo.teamInfo_idTeam=teamInfo.idteam)";
                            
                            request.setCharacterEncoding("UTF-8");

                            // Se foi informado um valor no campo de pesquisa, adicionar ao SQL
                            if ( request.getParameter("localizaEquipe") != null && request.getParameter("localizaEquipe") != "" )
                            {
                                String localizarValor = request.getParameter("localizaEquipe").toLowerCase();
                                out.write("<p>Pesquisando por: ");
                                out.write(localizarValor + "</p>");
                                
                                // Adicionar condição WHERE ao SQL
                                // Observe que o SQL busca o valor parcial (%) e em minúsculo (LOWER)
                                // Vamos pesquisar em todos os campos...
                                query += " WHERE LOWER(projname) LIKE '%"+localizarValor+"%' OR LOWER(nickname) LIKE '%"+localizarValor+"%'";
                                
                                //out.write(query); // debug SQL
                            }
                            
                            ResultSet rs = st.executeQuery(query);

                            // Processar cada item do banco e adicionar uma linha na tabela
                            while (rs.next()) {
                                int idproj = Integer.parseInt(request.getParameter("idproj"));
                                int idteam = rs.getInt("idteam");
                                String projName = rs.getString("projname");
                                String nickname = rs.getString("nickname");
                                if (projName==null){
                                    projName="";
                                }
                %>
                <!-- Cria nova linha na tabela -->
                <tr>
                   <!-- Colunas da linha -->
                    <td class="col-sm-1"> <%=idteam%> </td>
                    <td class="col-sm-3"> <%=nickname%> </td>
                    <td class="col-sm-3"> <%=projName%> </td>
                    <td class="col-sm-1"> <button onclick="definirEquipe(<%=idproj%>, '<%=projName%>', <%=idteam%>, '<%=nickname%>');">Escolher</button>

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
