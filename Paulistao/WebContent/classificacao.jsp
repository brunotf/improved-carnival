<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="modelo.Tabela, java.util.LinkedList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tabela Paulistão</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
	<div class="alert alert-sucess" role="alert">
		<%=msg%>
	</div>
	<%
		session.setAttribute("MESSAGE", null);
		}
	%>

	<div class="container">
		<form action="./TabelaController" method="post">

			<div class="btn-group btn-group-justified">
				<div class="btn-group">
					<button class="btn btn-sucess btn-lg" type="submit" name="cmd"
						value="tabelaGrupo">Mostrar Tabela de Grupo</button>
				</div>
				<div class="btn-group">
					<button class="btn btn-sucess btn-lg" type="submit" name="cmd"
						value="tabelaGeral">Mostrar Tabela Geral</button>
				</div>
			</div>
		</form>
	</div>

	<%
		@SuppressWarnings("unchecked")
		LinkedList<Tabela> tabelaGeral = (LinkedList<Tabela>) session
				.getAttribute("TABELA_GERAL");
		session.setAttribute("TABELA_GERAL", null);

		int contador = 0;

		if (tabelaGeral != null && tabelaGeral.size() > 0) {
	%>
	<div class="row">
		<table class="table table-dark" id="tabela">
			<tr>
				<th scope="col">Time</th>
				<th scope="col">Jogos Disputados</th>
				<th scope="col">Vitórias</th>
				<th scope="col">Empates</th>
				<th scope="col">Derrotas</th>
				<th scope="col">Gols Marcados</th>
				<th scope="col">Gols Sofridos</th>
				<th scope="col">Saldo de Gols</th>
				<th scope="col">Pontos</th>
			</tr>
			<%
				for (Tabela t : tabelaGeral) {
						if (contador < 16) {
			%>
			<tr>
				<td scope="row"><%=t.getNomeTime()%></td>
				<td scope="row"><%=t.getNumJogosDisputados()%></td>
				<td scope="row"><%=t.getVitorias()%></td>
				<td scope="row"><%=t.getEmpates()%></td>
				<td scope="row"><%=t.getDerrotas()%></td>
				<td scope="row"><%=t.getGolsMarcados()%></td>
				<td scope="row"><%=t.getGolsSofridos()%></td>
				<td scope="row"><%=t.getSaldoGols()%></td>
				<td scope="row"><%=t.getPontos()%></td>
			</tr>
			<%
				} else {
			%>
			<tr bgcolor="red">
				<td scope="row"><%=t.getNomeTime()%></td>
				<td scope="row"><%=t.getNumJogosDisputados()%></td>
				<td scope="row"><%=t.getVitorias()%></td>
				<td scope="row"><%=t.getEmpates()%></td>
				<td scope="row"><%=t.getDerrotas()%></td>
				<td scope="row"><%=t.getGolsMarcados()%></td>
				<td scope="row"><%=t.getGolsSofridos()%></td>
				<td scope="row"><%=t.getSaldoGols()%></td>
				<td scope="row"><%=t.getPontos()%></td>
			</tr>
			<%
				}
				contador++;
				}
			%>

		</table>
	</div>

	<%
		}
	%>




	<%
		@SuppressWarnings("unchecked")
		LinkedList<Tabela> grupoA = (LinkedList<Tabela>) session
				.getAttribute("TABELA_A");
		session.setAttribute("TABELA_A", null);

		if (grupoA != null && grupoA.size() > 0) {
	%>
	<div class="row">
		<table class="table table-striped table-dark" id="tabela">
			<tr>
				<th scope="col">Grupo</th>
				<th scope="col">Time</th>
				<th scope="col">Jogos Disputados</th>
				<th scope="col">Vitórias</th>
				<th scope="col">Empates</th>
				<th scope="col">Derrotas</th>
				<th scope="col">Gols Marcados</th>
				<th scope="col">Gols Sofridos</th>
				<th scope="col">Saldo de Gols</th>
				<th scope="col">Pontos</th>
			</tr>
			<%
				for (Tabela t : grupoA) {
			%>
			<tr>
				<td scope="row">A</td>
				<td scope="row"><%=t.getNomeTime()%></td>
				<td scope="row"><%=t.getNumJogosDisputados()%></td>
				<td scope="row"><%=t.getVitorias()%></td>
				<td scope="row"><%=t.getEmpates()%></td>
				<td scope="row"><%=t.getDerrotas()%></td>
				<td scope="row"><%=t.getGolsMarcados()%></td>
				<td scope="row"><%=t.getGolsSofridos()%></td>
				<td scope="row"><%=t.getSaldoGols()%></td>
				<td scope="row"><%=t.getPontos()%></td>
			</tr>
			<%
				}
			%>

		</table>
	</div>

	<%
		}
	%>

	<%
		@SuppressWarnings("unchecked")
		LinkedList<Tabela> grupoB = (LinkedList<Tabela>) session
				.getAttribute("TABELA_B");
		session.setAttribute("TABELA_B", null);

		if (grupoB != null && grupoB.size() > 0) {
	%>
	<div class="row">
		<table class="table table-striped table-dark" id="tabela">
			<tr>
				<th scope="col">Grupo</th>
				<th scope="col">Time</th>
				<th scope="col">Jogos Disputados</th>
				<th scope="col">Vitórias</th>
				<th scope="col">Empates</th>
				<th scope="col">Derrotas</th>
				<th scope="col">Gols Marcados</th>
				<th scope="col">Gols Sofridos</th>
				<th scope="col">Saldo de Gols</th>
				<th scope="col">Pontos</th>
			</tr>
			<%
				for (Tabela t : grupoB) {
			%>
			<tr>
				<td scope="row">B</td>
				<td scope="row"><%=t.getNomeTime()%></td>
				<td scope="row"><%=t.getNumJogosDisputados()%></td>
				<td scope="row"><%=t.getVitorias()%></td>
				<td scope="row"><%=t.getEmpates()%></td>
				<td scope="row"><%=t.getDerrotas()%></td>
				<td scope="row"><%=t.getGolsMarcados()%></td>
				<td scope="row"><%=t.getGolsSofridos()%></td>
				<td scope="row"><%=t.getSaldoGols()%></td>
				<td scope="row"><%=t.getPontos()%></td>
			</tr>
			<%
				}
			%>

		</table>
	</div>

	<%
		}
	%>

	<%
		@SuppressWarnings("unchecked")
		LinkedList<Tabela> grupoC = (LinkedList<Tabela>) session
				.getAttribute("TABELA_C");
		session.setAttribute("TABELA_C", null);

		if (grupoC != null && grupoC.size() > 0) {
	%>
	<div class="row">
		<table class="table table-striped table-dark" id="tabela">
			<tr>
			<tr>
				<th scope="col">Grupo</th>
				<th scope="col">Time</th>
				<th scope="col">Jogos Disputados</th>
				<th scope="col">Vitórias</th>
				<th scope="col">Empates</th>
				<th scope="col">Derrotas</th>
				<th scope="col">Gols Marcados</th>
				<th scope="col">Gols Sofridos</th>
				<th scope="col">Saldo de Gols</th>
				<th scope="col">Pontos</th>
			</tr>
			<%
				for (Tabela t : grupoC) {
			%>
			<tr>
				<td scope="row">C</td>
				<td scope="row"><%=t.getNomeTime()%></td>
				<td scope="row"><%=t.getNumJogosDisputados()%></td>
				<td scope="row"><%=t.getVitorias()%></td>
				<td scope="row"><%=t.getEmpates()%></td>
				<td scope="row"><%=t.getDerrotas()%></td>
				<td scope="row"><%=t.getGolsMarcados()%></td>
				<td scope="row"><%=t.getGolsSofridos()%></td>
				<td scope="row"><%=t.getSaldoGols()%></td>
				<td scope="row"><%=t.getPontos()%></td>
			</tr>
			<%
				}
			%>

		</table>
	</div>

	<%
		}
	%>

	<%
		@SuppressWarnings("unchecked")
		LinkedList<Tabela> grupoD = (LinkedList<Tabela>) session
				.getAttribute("TABELA_D");
		session.setAttribute("TABELA_D", null);

		if (grupoD != null && grupoD.size() > 0) {
	%>
	<div class="row">
		<table class="table table-striped table-dark" id="tabela">
			<tr>
			<tr>
				<th scope="col">Grupo</th>
				<th scope="col">Time</th>
				<th scope="col">Jogos Disputados</th>
				<th scope="col">Vitórias</th>
				<th scope="col">Empates</th>
				<th scope="col">Derrotas</th>
				<th scope="col">Gols Marcados</th>
				<th scope="col">Gols Sofridos</th>
				<th scope="col">Saldo de Gols</th>
				<th scope="col">Pontos</th>
			</tr>
			<%
				for (Tabela t : grupoD) {
			%>
			<tr>
				<td scope="row">D</td>
				<td scope="row"><%=t.getNomeTime()%></td>
				<td scope="row"><%=t.getNumJogosDisputados()%></td>
				<td scope="row"><%=t.getVitorias()%></td>
				<td scope="row"><%=t.getEmpates()%></td>
				<td scope="row"><%=t.getDerrotas()%></td>
				<td scope="row"><%=t.getGolsMarcados()%></td>
				<td scope="row"><%=t.getGolsSofridos()%></td>
				<td scope="row"><%=t.getSaldoGols()%></td>
				<td scope="row"><%=t.getPontos()%></td>
			</tr>
			<%
				}
			%>

		</table>
	</div>

	<%
		}
	%>

</body>
</html>
