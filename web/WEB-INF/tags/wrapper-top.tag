<%-- 
    Document   : wrapper-top
    Created on : 03/05/2018, 18:10:53
    Author     : enriquelimberger
--%>

<%@tag description="Wrapper-superior" pageEncoding="UTF-8"%>
<%@attribute name="title" fragment="true" %>
<%@attribute name="head" fragment="true" %>
<%@attribute name="navbar" fragment="true" %>
<%@attribute name="localiza" fragment="true" %>


<!DOCTYPE html>
<html lang="pt">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><jsp:invoke fragment="title"/></title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
        <jsp:invoke fragment="head"/>
    </head>
    <body scroll="no" style="overflow: hidden">
        <div id="pageheader">
            <nav class="navbar navbar-default navbar-fixed-top">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="/ScruManager/index.html">ScruManager</a>
                    </div>
                    <ul class="nav navbar-nav">
                        <jsp:invoke fragment="navbar"/>
                    </ul>
                </div>
            </nav>

        </div>
                        
        <div class= "container" id="body" style="padding-top: 70px; padding-bottom:160px">
            
            <jsp:invoke fragment="localiza"/>
<div class= "container" style="height:calc(100vh - 250px); display:block; overflow:scroll">