package services;

import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GrupoDAO;
import modelo.Grupo;

@WebServlet("/GruposController")
public class GruposController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String cmd = request.getParameter("cmd");

		GrupoDAO gDao = new GrupoDAO();

		LinkedList<Grupo> grupoA;
		LinkedList<Grupo> grupoB;
		LinkedList<Grupo> grupoC;
		LinkedList<Grupo> grupoD;

		grupoA = (LinkedList<Grupo>) getServletContext().getAttribute("GRUPO_A");

		if (grupoA == null) {
			grupoA = new LinkedList<>();
		}

		grupoB = (LinkedList<Grupo>) getServletContext().getAttribute("GRUPO_B");

		if (grupoB == null) {
			grupoB = new LinkedList<>();
		}

		grupoC = (LinkedList<Grupo>) getServletContext().getAttribute("GRUPO_C");

		if (grupoC == null) {
			grupoC = new LinkedList<>();
		}

		grupoD = (LinkedList<Grupo>) getServletContext().getAttribute("GRUPO_D");

		if (grupoD == null) {
			grupoD = new LinkedList<>();
		}

		String msg = "";

		if ("dividir".contains(cmd)) {
			try {
				msg = gDao.dividirGrupos();
			} catch (SQLException e) {
				e.printStackTrace(System.err);
			}
		}

		if ("mostrar".contains(cmd)) {
			try {
				grupoA = gDao.obterGrupo("A");
				grupoB = gDao.obterGrupo("B");
				grupoC = gDao.obterGrupo("C");
				grupoD = gDao.obterGrupo("D");
			} catch (SQLException e) {
				e.printStackTrace(System.err);
			}

		}

		request.getSession().setAttribute("MESSAGE", msg);
		request.getSession().setAttribute("GRUPO_A", grupoA);
		request.getSession().setAttribute("GRUPO_B", grupoB);
		request.getSession().setAttribute("GRUPO_C", grupoC);
		request.getSession().setAttribute("GRUPO_D", grupoD);

		response.sendRedirect("./grupos.jsp");

	}

}
