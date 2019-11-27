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
            function editarRegistro(idproj) {
                window.location.href = "/ScruManager/projeto/editar.jsp?idproj=" + idproj;

            }

<!-- Função javascript para chamar Srvlet de exclusão de registro -->
            function excluirRegistro(idproj, nickname) {
                if (confirm('Confirma exclusão do projeto ' + idproj + ' - ' + nickname + '?')) {
                    window.location.href = "/ScruManager/projeto/excluir_registro.jsp?idproj=" + idproj;
            } else {
                    alert('Exclusão cancelada.');
                }
            }
    </script>       
        </jsp:attribute>

        <jsp:attribute name="title">
            Projetos - lista
        </jsp:attribute>

            
        <jsp:attribute name="navbar">
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/projeto/listar.jsp"><b>Projetos</b></a></li>
            </jsp:attribute>

        <jsp:attribute name="localiza">
            <div  class="form-group row">
                <form class="col-sm-10" name="frmLocalizar" action="listar.jsp" method="POST">
                    <p><label for="desenvolvedor">Localizar:</label> <input type="text" name="localizaDesenvolvedor" value="" size="50"> 
                        <input type="submit" value="Pesquisar" name="btnLocaliza" /></p>
                </form>
                <form class="col-sm-2" action="registrar.jsp">
                    <input type="submit" value="Registrar projeto"/>
                </form>
            </div>
        </jsp:attribute>

    </t:wrapper-top>

    <!--Início conteúdo central-->

    <!-- Formulário com campo para pesquisar projeto -->

    <table class="table table-hover table-bordered">
        <thead>
            <tr>
                <th class="col-sm-1">ID</th>
                <th class="col-sm-3">Nome</th>
                <th class="col-sm-3">Equipe responsável</th>
                <th class="col-sm-1"></th>
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
                        String query = "SELECT * FROM projInfo LEFT JOIN teamInfo on projInfo.teamInfo_idteam=teamInfo.idteam";

                        request.setCharacterEncoding("UTF-8");

                        // Se foi informado um valor no campo de pesquisa, adicionar ao SQL
                        if (request.getParameter("localizaProjeto") != null && request.getParameter("localizaProjeto") != "") {
                            String localizarValor = request.getParameter("localizaProjeto").toLowerCase();
                            out.write("<p>Pesquisando por: ");
                            out.write(localizarValor + "</p>");

                            // Adicionar condição WHERE ao SQL
                            // Observe que o SQL busca o valor parcial (%) e em minúsculo (LOWER)
                            // Vamos pesquisar em todos os campos...
                            query += " WHERE LOWER(nickname) LIKE '%" + localizarValor + "%'";

                            //out.write(query); // debug SQL
                        }

                        ResultSet rs = st.executeQuery(query);
                        // Processar cada item do banco e adicionar uma linha na tabela
                        while (rs.next()) {
                            int idproj = rs.getInt("idproj");
                            String projName = rs.getString("projName");
                            String nickname = rs.getString("nickname");
                            if (nickname==null){
                                nickname="";
                            }
            %>
            <!-- Cria nova linha na tabela -->
            <tr>                              
                <!-- Colunas da linha -->
                <td class="col-sm-1"> <%= idproj%> </td>
                <td class="col-sm-3"> <a href="/ScruManager/gerenciar_projeto/listar.jsp?idproj=<%= rs.getInt("idproj")%>&projname=<%= rs.getString("projName")%>"><%= rs.getString("projName")%></a> </td>
                <td class="col-sm-3"> <%= nickname%> </td>
                <td class="col-sm-1"> <button onclick="editarRegistro(<%= rs.getInt("idproj")%>);"><img width= "20px" src="<%=request.getContextPath()%>/images/edit.png" /></button>
                <td class="col-sm-1"> <button onclick="excluirRegistro(<%= rs.getInt("idproj")%>, '<%= rs.getString("projName")%>');"><img width= "20px" src="<%=request.getContextPath()%>/images/delete.png" /></button>


            </tr>
            <%
                        } // Fim do while

                        rs.close();

                    } catch (Exception e) {
                        out.write("Ocorreu um erro ao buscar os projetos <span style='color: red'>" + e.getMessage() + "</span>");
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


