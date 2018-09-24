package services;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RodadasDAO;
import modelo.Rodada;

@WebServlet("/JogosController")
public class JogosController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String data = request.getParameter("txtData");
		SimpleDateFormat dataHtml = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dataSql = new SimpleDateFormat("dd/MM/yyyy");
		String dataFormatada = "";

		try {
			dataFormatada = dataSql.format(dataHtml.parse(data));
		} catch (ParseException e) {
			e.printStackTrace(System.out);
		}

		LinkedList<Rodada> rodada;

		rodada = (LinkedList<Rodada>) getServletContext().getAttribute("TABELA_RODADA");

		if (rodada == null) {
			rodada = new LinkedList<>();
		}

		RodadasDAO rDao = new RodadasDAO();

		try {
			rodada = rDao.buscarRodada(dataFormatada);
		} catch (SQLException e) {
			e.printStackTrace(System.out);
		}

		request.getSession().setAttribute("TABELA_RODADA", rodada);

		response.sendRedirect("./jogos.jsp");
	}

}
