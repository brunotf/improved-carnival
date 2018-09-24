package services;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RodadasDAO;

@WebServlet("/RodadasController")
public class RodadasController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RodadasDAO rDao = new RodadasDAO();
		
		try {
			rDao.definirRodadas();
		} catch (SQLException e) {
			e.printStackTrace(System.err);
		}
		
		response.sendRedirect("./rodadas.jsp");

	}

}
