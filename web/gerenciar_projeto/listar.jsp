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
            
            function alterarEquipeResponsavel(idproj, projname) {
                window.location.href = "/ScruManager/gerenciar_projeto/definicaoResponsavel.jsp?idproj=" + idproj + "&projname=" + projname;

            }
            
             <!-- Função javascript para chamar edição de registro -->
            function editarRegistro(idproj, projname, idtask) {
                window.location.href = "/ScruManager/gerenciar_projeto/editar.jsp?idproj=" + idproj + "&projname=" + projname + "&idtask=" + idtask;

            }
            
            <!-- Função javascript para chamar Srvlet de exclusão de registro -->
            function excluirRegistro(idProj, projName, idTask, taskName, taskstatus) {
                if (taskstatus!==4){
                    alert('Impossível excluir tarefa em estado diferente de \"Abandonado\"');
                }
                else if (confirm('Confirma exclusão da tarefa ' + idTask + ' - ' + taskName + '?')) {
                    window.location.href = "/ScruManager/gerenciar_projeto/excluir_tarefa.jsp?idproj=" + idProj + "&projname=" + projName + "&idtask=" + idTask;
                } else {
                    alert('Exclusão cancelada.');
                }
            }
    </script>     
                
        </jsp:attribute>

        <jsp:attribute name="title">
            Gerenciar projeto
        </jsp:attribute>
       
            
        <jsp:attribute name="navbar">
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/desenvolvedor/listar.jsp">Desenvolvedores</a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/equipe/listar.jsp">Equipes</a></li>
            <li class="divider-vertical"></li>
            <li><a href="/ScruManager/projeto/listar.jsp">Projetos</a></li>
            <li><a href="#" onclick="window.location.reload(true);"><b>${param.projname}</b></a></li>
         </jsp:attribute>

        <jsp:attribute name="localiza">
            <div  class="form-group row">
                <form class="col-sm-10">
                </form>
                <form class="col-sm-2" action="/ScruManager/gerenciar_projeto/inclusao.jsp" method="get">
                    <input type="hidden" name="idproj" id="idproj" value="${param.idproj}" />
                    <input type="hidden" name="projname" id="projname" value="${param.projname}" />
                    <input type="submit" value="Incluir nova tarefa"/>
                </form>
            </div>
        </jsp:attribute>

    </t:wrapper-top>

    <!--Início conteúdo central-->


    <table class="table table-bordered">
        <thead>
            <tr>
                <th class="text-center" colspan="5">
                    <h4>Informações</h4>
                </th>
            <tr>
        </thead>
        <tbody>
            <%
                int idproj=0;
                String projDescription="";
                String projName="";
                String responsibleTeam="";
                    try {

                        // Registrar o driver JDBC para PostgreSQL
                        Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
                        // Conectar o banco
                        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/scrumanager", "postgres", "postgres");
                        // Statement para executar os comandos sql
                        Statement st = conn.createStatement();

                        try {
                            String query = "SELECT * FROM projInfo LEFT JOIN tasks ON (projInfo.idProj=tasks.idProj) LEFT JOIN teamInfo ON (projInfo.teamInfo_idteam=teamInfo.idteam) WHERE projInfo.idproj="+request.getParameter("idproj");

                            request.setCharacterEncoding("UTF-8");
                            
                            ResultSet rs = st.executeQuery(query);
                            
                            // Processar cada item do banco e adicionar uma linha na tabela
                            while (rs.next()) {
                                idproj=rs.getInt("idproj");
                                projName = rs.getString("projname");
                                projDescription = rs.getString("projdescription");
                                responsibleTeam = rs.getString("nickname");
                                if (responsibleTeam==null){
                                responsibleTeam="";
                            }
                                
                        } // Fim do while

                        rs.close();

                    } catch (Exception e) {
                        out.write("Ocorreu um erro ao buscar a descrição do projeto <span style='color: red'>" + e.getMessage() + "</span>");
                    } finally {
                    }

                } catch (Exception e) {
                    out.write("Ocorreu um erro conectando a base: <span style='color: red'>" + e.getMessage() + "</span>");
                }

            %>   
            <tr>
                <th class="col-sm-1">Nome</th</td>
                <td colspan="2" class="col-sm-4"><%=projName%></td>
            </tr>
            <tr>
                <th class="col-sm-1">Descrição</th</td>
                <td colspan="2" class="col-sm-4"><%=projDescription%></td>

            </tr>
            <tr>
                <th class="col-sm-1">Equipe responsável</th</td>
                <td class="col-sm-3"><%=responsibleTeam%></td>
                <td class="col-sm-1"> <button onclick="alterarEquipeResponsavel(<%=idproj%>, '<%=projName%>');"><img width= "20px" src="<%=request.getContextPath()%>/images/edit.png" /></button>
            </tr>
        </tbody>
    </table>
    
    <table class="table table-hover table-bordered">
        <thead>
            <tr>
                <th class="text-center" colspan=6><h4>Tarefas</h4></th> 
            </tr>
            <tr>
                <th class="col-sm-1">ID - tarefa</th>
                <th class="col-sm-2">Nome tarefa</th>
                <th class="col-sm-4">Descrição</th>
                <th class="col-sm-1">Estado (clique para alterar)</th>
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
                            String query = "SELECT * FROM projInfo INNER JOIN tasks ON (projInfo.idProj=tasks.idProj) LEFT JOIN teamInfo ON (projInfo.teamInfo_idteam=teamInfo.idteam) WHERE projInfo.idproj="+request.getParameter("idproj");

                            request.setCharacterEncoding("UTF-8");

                            // Se foi informado um valor no campo de pesquisa, adicionar ao SQL
                           

                            ResultSet rs = st.executeQuery(query);
                            // Processar cada item do banco e adicionar uma linha na tabela
                            while (rs.next()) {
                                int idtask = rs.getInt("idtask");
                                String taskName = rs.getString("taskname");
                                String taskDescription = rs.getString("taskdescription");
                                int taskstatus = rs.getInt("taskstatus");
                                String estado = "";
                                switch (taskstatus){
                                    case 0:
                                        estado = "Não iniciado"; break;
                                    case 1:
                                        estado = "Em andamento"; break;
                                    case 2:
                                        estado = "Pausado"; break;
                                    case 3:
                                        estado = "Concluído"; break;
                                    case 4:
                                        estado = "Abandonado"; break;
                                    default:
                                        estado = "Erro de banco de dados";
                                }
                                
                %>
            <!-- Cria nova linha na tabela -->
            <tr>                              
                <!-- Colunas da linha -->
                <td class="col-sm-1"> <%= idtask%> </td>
                <td class="col-sm-2"> <%= taskName%> </td>
                <td class="col-sm-4"> <%= taskDescription%> </td>
                <td class="col-sm-1"> <a href="/ScruManager/gerenciar_projeto/alteraEstado.jsp?idproj=${param.idproj}&projname=${param.projname}&idtask=<%=idtask%>"><%= estado%></a></td>
                <td class="col-sm-1"> <button onclick="editarRegistro(<%= rs.getInt("idproj")%>, '<%= rs.getString("projname")%>', <%=idtask%>);"><img width= "20px" src="<%=request.getContextPath()%>/images/edit.png" /></button>
                <td class="col-sm-1"> <button onclick="excluirRegistro(<%= rs.getInt("idproj")%>, '<%= rs.getString("projname")%>', <%=idtask%>, '<%=taskName%>',<%=taskstatus%>);"><img width= "20px" src="<%=request.getContextPath()%>/images/delete.png" /></button>


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




