<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="modelo.Grupos, java.util.HashSet"%>
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

	<div class="container">
		<form action="./MostrarGrupos" method="post">
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
		HashSet<Grupos> tabelaGrupos = (HashSet<Grupos>) session.getAttribute("TABELA_GRUPOS");
		session.setAttribute("TABELA_GRUPOS", null);
		if (tabelaGrupos != null && tabelaGrupos.size() > 0) {
	%>
	<h2>Grupos</h2>
	<table class="table table-striped" id="tabela">
		<tr>
			<th scope="col">Nome do Time</th>
			<th scope="col">Grupo</th>
		</tr>
		<%
			for (Grupos g : tabelaGrupos) {
		%>
		<tr>
			<th scope="row"><%=g.getNomeTime()%></th>
			<td><%=g.getGrupo()%></td>
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