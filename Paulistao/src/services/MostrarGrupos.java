package services;

import java.io.IOException;
import java.sql.SQLException;
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
		
		String cmd = request.getParameter("cmd");
		
		GrupoDAO gDao = new GrupoDAO();
		
		HashSet<Grupos> grupos;
		
		grupos = (HashSet<Grupos>) getServletContext().getAttribute("TABELA_GRUPOS");
		
		if (grupos == null) {
			grupos = new HashSet<>();
		}
		
		String msg = "";
		
		if ("dividir".contains(cmd)) {
			try {
				gDao.dividirGrupos();
			} catch (SQLException e) {
				e.printStackTrace(System.err);
			}
			
		} else if ("mostrar".contains(cmd)) {
			try {
				grupos = gDao.mostrarGrupos();
			} catch (SQLException e) {
				e.printStackTrace(System.err);
			}
			
		}
		
		request.setAttribute("MESSAGE", msg);
		request.setAttribute("TABELA_GRUPOS", grupos);
		
		response.sendRedirect("./mostrargrupos.jsp");
		
	}

}
