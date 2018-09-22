package services;

import java.io.IOException;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GrupoDAO;
import modelo.Grupos;

@WebServlet("/MostrarGrupos")
public class MostrarGrupos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		GrupoDAO gDao = new GrupoDAO();
		
		HashSet<Grupos> grupos;
		
		grupos = (HashSet<Grupos>) getServletContext().getAttribute("TABELA_GRUPOS");
		
		if (grupos == null) {
			grupos = new HashSet<>();
		}
		
		grupos = gDao.exibirGrupos();
				
		request.setAttribute("TABELA_GRUPOS", grupos);
		
		response.sendRedirect("./mostrargrupos.jsp");
		
	}

}
