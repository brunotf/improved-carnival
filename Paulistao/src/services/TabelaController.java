package services;

import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ResultadosDAO;
import modelo.Tabela;

@SuppressWarnings("unchecked")
@WebServlet("/TabelaController")
public class TabelaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String grupo = request.getParameter("grupo");

		String cmd = request.getParameter("cmd");

		ResultadosDAO resDao = new ResultadosDAO();

		LinkedList<Tabela> grupoA;
		LinkedList<Tabela> grupoB;
		LinkedList<Tabela> grupoC;
		LinkedList<Tabela> grupoD;
		LinkedList<Tabela> tabelaGeral;

		grupoA = (LinkedList<Tabela>) getServletContext().getAttribute("GRUPO_A");

		if (grupoA == null) {
			grupoA = new LinkedList<>();
		}

		grupoB = (LinkedList<Tabela>) getServletContext().getAttribute("GRUPO_B");

		if (grupoB == null) {
			grupoB = new LinkedList<>();
		}

		grupoC = (LinkedList<Tabela>) getServletContext().getAttribute("GRUPO_C");

		if (grupoC == null) {
			grupoC = new LinkedList<>();
		}

		grupoD = (LinkedList<Tabela>) getServletContext().getAttribute("GRUPO_D");

		if (grupoD == null) {
			grupoD = new LinkedList<>();
		}
		
		tabelaGeral = (LinkedList<Tabela>) getServletContext().getAttribute("TABELA_GERAL");
		
		if (tabelaGeral == null) {
			tabelaGeral = new LinkedList<>();
		}

		String msg = "";

		if ("tabelaGrupo".contains(cmd)) {
			try {
			grupoA = resDao.tabelaGrupo("A");
			grupoB = resDao.tabelaGrupo("B");
			grupoC = resDao.tabelaGrupo("C");
			grupoD = resDao.tabelaGrupo("D");
			} catch (SQLException e) {
				e.printStackTrace(System.out);
			}
		} else if ("tabelaGeral".contains(cmd))
			try {
				tabelaGeral = resDao.tabelaGeral();
			} catch (SQLException e) {
				e.printStackTrace(System.out);
			}
		
		
		request.getSession().setAttribute("TABELA_A", grupoA);
		request.getSession().setAttribute("TABELA_B", grupoB);
		request.getSession().setAttribute("TABELA_C", grupoC);
		request.getSession().setAttribute("TABELA_D", grupoD);
		
		request.getSession().setAttribute("TABELA_GERAL", tabelaGeral);

		response.sendRedirect("./classificacao.jsp");
	}

}
