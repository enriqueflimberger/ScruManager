
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Redirecionando...</title>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script>
            if(<%= request.getParameter("success")%>===1){ 
                alert("Incluído com sucesso")
            }else if(<%= request.getParameter("success")%>===2){
                alert("Excluído com sucesso")
            }else if(<%= request.getParameter("success")%>===3){
                alert("Alterado com sucesso")
            }else{
                alert("Ocorreu um problema ao atender a solicitação")
            }
        </script>
        <!-- A próxima linha redireciona para o arquivo principal.jsp -->
        <meta http-equiv="refresh" content="0; url=listar.jsp"> 
    </head>
    <body>
        
    </body>
</html>
