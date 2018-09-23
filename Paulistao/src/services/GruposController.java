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
import modelo.Grupos;

@WebServlet("/GruposController")
public class GruposController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String cmd = request.getParameter("cmd");
		
		GrupoDAO gDao = new GrupoDAO();
		
		LinkedList<Grupos> grupos;
		
		grupos = (LinkedList<Grupos>) getServletContext().getAttribute("TABELA_GRUPOS");
		
		if (grupos == null) {
			grupos = new LinkedList<>();
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
				grupos = gDao.mostrarGrupos();
			} catch (SQLException e) {
				e.printStackTrace(System.err);
			}
			
		}
		
		request.getSession().setAttribute("MESSAGE", msg);
		request.getSession().setAttribute("TABELA_GRUPOS", grupos);
		
		response.sendRedirect("./grupos.jsp");
		
	}

}
