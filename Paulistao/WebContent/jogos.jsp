<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="modelo.Rodada, java.util.LinkedList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Jogos</title>
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
	<jsp:include page="./index.jsp"></jsp:include>

	<div class="container">
		<form action="./JogosController" method="post">
			<div class="row">
				<div class="col-sm-6 text-right">
					<label>Data do Jogo</label>
				</div>
				<div class="col-sm-6">
					<input type="Date" name="txtData" id="data" />
				</div>
			</div>

			<br>

			<div class="row">
				<div class="col-sm-12 text-center">
					<button class="btn btn-primary" type="submit" name="cmd"
						value="pesquisar">Pesquisar</button>
				</div>
			</div>

		</form>
	</div>

	<%
		@SuppressWarnings("unchecked")
		LinkedList<Rodada> rodada = (LinkedList<Rodada>) session.getAttribute("TABELA_RODADA");
		session.setAttribute("TABELA_RODADA", null);
		if (rodada != null && rodada.size() > 0) {
	%>
	<div class="text-center">
		<table class="table table-striped table-dark" id="tabela">
			<tr>
				<th scope="col">Time A</th>
				<th scope="col">Time B</th>
				<th scope="col">Gols A</th>
				<th scope="col">Gols B</th>
				<th scope="col">Data do Jogo</th>
			</tr>
			<%
				for (Rodada r : rodada) {
			%>
			<tr>
				<td scope="row"><%=r.getTimeA()%></td>
				<td scope="row"><%=r.getTimeB()%></td>
				<td scope="row"><%=r.getGolsA()%></td>
				<td scope="row"><%=r.getGolsB()%></td>
				<td scope="row"><%=r.getDataJogo()%></td>
			</tr>
			<%
				}
			%>

		</table>
		<%
			}
		%>
	</div>

</body>
</html>