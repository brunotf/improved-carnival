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
@WebServlet("/QuartasController")
public class QuartasController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cmd = request.getParameter("cmd");

		ResultadosDAO resDao = new ResultadosDAO();

		LinkedList<Tabela> grupoA;
		LinkedList<Tabela> grupoB;
		LinkedList<Tabela> grupoC;
		LinkedList<Tabela> grupoD;

		grupoA = (LinkedList<Tabela>) getServletContext().getAttribute("QUARTAS_A");

		if (grupoA == null) {
			grupoA = new LinkedList<>();
		}

		grupoB = (LinkedList<Tabela>) getServletContext().getAttribute("QUARTAS_B");

		if (grupoB == null) {
			grupoB = new LinkedList<>();
		}

		grupoC = (LinkedList<Tabela>) getServletContext().getAttribute("QUARTAS_C");

		if (grupoC == null) {
			grupoC = new LinkedList<>();
		}

		grupoD = (LinkedList<Tabela>) getServletContext().getAttribute("QUARTAS_D");

		if (grupoD == null) {
			grupoD = new LinkedList<>();
		}

		if ("projetar".contains(cmd)) {
			try {
				grupoA = resDao.quartas("A");
				grupoB = resDao.quartas("B");
				grupoC = resDao.quartas("C");
				grupoD = resDao.quartas("D");
			} catch (SQLException e) {
				e.printStackTrace(System.out);
			}
		}

		request.getSession().setAttribute("QUARTAS_A", grupoA);
		request.getSession().setAttribute("QUARTAS_B", grupoB);
		request.getSession().setAttribute("QUARTAS_C", grupoC);
		request.getSession().setAttribute("QUARTAS_D", grupoD);

		response.sendRedirect("./quartas.jsp");
	}

}
