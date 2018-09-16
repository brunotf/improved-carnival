<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Página Inicial</title>
<link rel="stylesheet" href="./resources/bootstrap.min.css" />
<script src="./resources/jquery-3.3.1.slim.min.js"></script>
<script src="./resources/popper.min.js"></script>
<script src="./resources/bootstrap.min.js"></script>
</head>
<body>
<h1>PAULISTÃO 2019</h1>
<hr />

<div class="container">
	<form action="./IndexController" method="post">
		<div class="row">
			<div class="input-sm-8">
				<button class="btn btn-primary" type="submit"
					name="cmd" value="gerarGrupos">Gerar Grupos</button>
				<button class="btn btn-primary" type="submit"
					name="cmd" value="mostrarGrupos">Mostrar Grupos</button>
			</div>	
		</div>	
	</form>
</div>
</body>
</html>