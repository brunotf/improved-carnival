<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="modelo.Grupos, java.util.LinkedList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Grupos</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./resources/eztilo.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>

	<jsp:include page="index.jsp"></jsp:include>

	<%
		String msg = (String) session.getAttribute("MESSAGE");
		
		if (msg != null && msg != "null") {
			
	%>
	<div class=alert alert-sucess" role="alert">
		<%=msg%>
	</div>
	<%
		session.setAttribute("MESSAGE", null);
		}
	%>
	
	<div class="container">
		<form action="./GruposController" method="post">
			<div class="btn-group btn-group-justified">
				<div class="btn-group">
					<button class="btn btn-sucess btn-lg" type="submit" name="cmd"
						value="dividir">Dividir Grupos</button>
				</div>
				<div class="btn-group">
					<button class="btn btn-sucess btn-lg" type="submit" name="cmd"
						value="mostrar">Mostrar Grupos</button>
				</div>
			</div>
		</form>
	</div>

	<%
		LinkedList<Grupos> tabelaGrupos = (LinkedList<Grupos>) session.getAttribute("TABELA_GRUPOS");
		session.setAttribute("TABELA_GRUPOS", null);
		if (tabelaGrupos != null && tabelaGrupos.size() > 0) {
	%>
	<h2>Grupos</h2>
	<table class="table table-striped table-dark" id="tabela">
		<tr>
			<th scope="col">Grupo</th>
			<th scope="col">Time</th>
		</tr>
		<%
			for (Grupos g : tabelaGrupos) {
		%>
		<tr>
			<td scope="row"><%=g.getGrupo()%></td>
			<td scope="row"><%=g.getNomeTime()%></td>
		</tr>
		<%
			}
		%>
		
	</table>
	<%
		}
	%>

</body>
</html>