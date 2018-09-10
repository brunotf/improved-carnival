package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.ProdutoDao;
import model.Produto;

@WebServlet("/insereProduto")
public class ProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		Produto p = new Produto();
		p.setNome(request.getParameter("nome"));

		String saida = "";
		try {
			ProdutoDao pDao = new ProdutoDao();
			saida = pDao.insereProduto(p);
		} catch (ClassNotFoundException | SQLException e) {
			saida = e.getMessage();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("saida", saida);
			rd.forward(request, response);

		}
	}

}
