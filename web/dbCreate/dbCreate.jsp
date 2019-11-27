<%-- 
    Document   : dbCreate
    Created on : 28/04/2018, 00:07:39
    Author     : enriquelimberger
--%>

<%@ page import="java.io.*,java.sql.*" %>

<%@page contentType="text/html" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Criação do Banco de Dados e Tabelas</title>
        <!-- Utilizar a font-awesome  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">        
    </head>
    <body>

        <%!
            //Informe os dados de conexão à base
            String nome_base = "scrumanager";
            String user = "postgres";
            String pass = "postgres";

            public String mostraErroFormatado(String str) {
                String res = "<span style='color: red'>" + str + "</span>";

                return res;
            }
        %>
        
        <h2>Criação Base de Dados: <%= nome_base%> </h2>

        <%
            String sql = "";

            try {
                
                if (nome_base.equals("") || user.equals("")) {
                    throw new Exception("É necessário informar o nome da base e o nome do usuário!!");
                }

                out.write("Conectando o banco... <i class='fa fa-database' style='color: blue'></i> <br/>");

                // Registrar o driver JDBC para PostgreSQL
                Class.forName("org.postgresql.Driver"); // ou DriverManager.registerDriver(new org.postgresql.Driver());
                // Conectar o banco
                Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", user, pass);
                // Statement para executar os comandos sql
                Statement statement = conn.createStatement();

                try {
                    out.write("Criando Base de dados... ");
                    sql = "CREATE DATABASE " + nome_base;
                    statement.executeUpdate(sql);

                    out.write("<i class='fa thumbs-o-up'></i> <br/>");

                } catch (Exception e) {
                    out.write("<i class='fa fa-thumbs-o-down' style='color: red'></i> " + mostraErroFormatado(e.getMessage()) + "<br/>");
                }

                out.write("Acessando a base... <i class='fa fa-database' style='color: blue'></i>");

                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/" + nome_base, user, pass);
                statement = conn.createStatement();

                out.write("<i class='fa thumbs-o-up'></i> <br/>");
                
                // Criação da tabela devs
                try {
                    out.write("Criando tabela 'devs'... ");

                    sql = "CREATE TABLE devs(";
                    sql += "  idDev SERIAL PRIMARY KEY,";
                    sql += "  name VARCHAR(45) NOT NULL,";
                    sql += "  email VARCHAR(45) NOT NULL";
                    sql += ")";

                    statement.executeUpdate(sql);

                    out.write("<i class='fa fa-thumbs-o-up' style='color: blue'></i> <br/>");
                } catch (Exception e) {
                    out.write("<i class='fa fa-thumbs-o-down' style='color: red'></i> " + mostraErroFormatado(e.getMessage()) + "<br/>");
                }

                // Criação da tabela team
                try {
                    out.write("Criando tabela 'team'... ");

                    sql = "CREATE TABLE team(";
                    sql += "  isScrummaster BOOLEAN,";
                    sql += "  teamInfo_idTeam INT NOT NULL,";
                    sql += "  devs_IdDev INT NOT NULL";
                    sql += ")";

                    statement.executeUpdate(sql);

                    out.write("<i class='fa fa-thumbs-o-up' style='color: blue'></i> <br/>");
                } catch (Exception e) {
                    out.write("<i class='fa fa-thumbs-o-down' style='color: red'></i> " + mostraErroFormatado(e.getMessage()) + "<br/>");
                }

                // Criação da tabela teamInfo
                try {
                    out.write("Criando tabela 'teamInfo'... ");

                    sql = "CREATE TABLE teamInfo(";
                    sql += "  idTeam SERIAL PRIMARY KEY,";
                    sql += "  nickname VARCHAR(45) NOT NULL";
                    sql += ")";

                    //out.write(sql);
                    statement.executeUpdate(sql);

                    out.write("<i class='fa fa-thumbs-o-up' style='color: blue'></i> <br/>");
                } catch (Exception e) {
                    out.write("<i class='fa fa-thumbs-o-down' style='color: red'></i> " + mostraErroFormatado(e.getMessage()) + "<br/>");
                }

                // Criação da tabela projInfo
                try {
                    out.write("Criando tabela 'projInfo'... ");

                    sql = "CREATE TABLE projInfo(";
                    sql += "  idProj SERIAL PRIMARY KEY,";
                    sql += "  projName VARCHAR(45) NOT NULL,";
                    sql += "  projDescription VARCHAR(150) NOT NULL,";
                    sql += "  teamInfo_idTeam INT";
                    sql += ")";

                    statement.executeUpdate(sql);

                    out.write("<i class='fa fa-thumbs-o-up' style='color: blue'></i> <br/>");
                } catch (Exception e) {
                    out.write("<i class='fa fa-thumbs-o-down' style='color: red'></i> " + mostraErroFormatado(e.getMessage()) + "<br/>");
                }

                // Criação tabela tasks
                try {
                    out.write("Criando tabela 'tasks'... ");

                    sql = "CREATE TABLE tasks(";
                    sql += "  idTask SERIAL,";
                    sql += "  taskName VARCHAR(45),";
                    sql += "  taskDescription VARCHAR(150) NOT NULL,";
                    sql += "  taskStatus INT,";
                    sql += "  idProj INT";
                    sql += ")";

                    statement.executeUpdate(sql);

                    out.write("<i class='fa fa-thumbs-o-up' style='color: blue'></i> <br/>");

                } catch (Exception e) {
                    out.write("<i class='fa fa-thumbs-o-down' style='color: red'></i> " + mostraErroFormatado(e.getMessage()) + "<br/>");
                }

            } catch (Exception e) {
                out.print("<i class='fa fa-thumbs-o-down' style='color: red'></i> Ocorreu um erro no processo: " + e.getMessage());
            } finally {
                //statement.close();

                //conn.close();
                out.write("<br/>Processo concluído.");
            }
        %>

    </body>
</html>

