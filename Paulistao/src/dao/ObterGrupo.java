package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.concurrent.Callable;

import modelo.Grupos;

public class ObterGrupo implements Callable<LinkedList<Grupos>> {

	private Connection CON;
	private String grupo;

	public ObterGrupo(String grupo) {
		this.grupo = grupo;
	}

	@Override
	public LinkedList<Grupos> call() throws Exception {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Grupos> grupos = new LinkedList<>();

		String sql = "SELECT * FROM grupos WHERE grupo = ? ORDER BY idTime";

		PreparedStatement ps = CON.prepareStatement(sql);

		ps.setString(1, grupo);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Grupos g = new Grupos();

			g.setGrupo(rs.getString("grupo"));
			g.setIdTime(rs.getInt("idTime"));

			grupos.add(g);
		}

		rs.close();
		ps.close();

		return grupos;
	}

}
