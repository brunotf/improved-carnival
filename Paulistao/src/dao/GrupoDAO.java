package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashSet;
import java.util.LinkedList;

import modelo.Grupos;
import modelo.Time;

public class GrupoDAO {

	private Connection CON;

	public String dividirGrupos() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		HashSet<Time> times = times();

		String saida = "";

		int contador = 0;

		String sql = "{CALL sp_dividirGrupos(?,?)}";

		CallableStatement cs = CON.prepareCall(sql);

		for (Time t : times) {
			cs.setString(1, t.getNome());
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			saida = cs.getString(2);
			if (saida == null) {
				contador++;
			}
			System.out.println(saida);
		}

		cs.close();

		if (contador == 20) {
			saida = "Times adicionados!";
		}

		return saida;
	}

	public LinkedList<Grupos> mostrarGrupos() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Grupos> grupos = new LinkedList<>();

		String sql = "SELECT * FROM v_grupos ORDER BY grupo";

		PreparedStatement ps = CON.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Grupos g = new Grupos();

			g.setNomeTime(rs.getString("nomeTime"));
			g.setGrupo(rs.getString("grupo"));

			grupos.add(g);
		}

		rs.close();
		ps.close();

		return grupos;
	}

	private HashSet<Time> times() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		HashSet<Time> times = new HashSet<>();

		String sql = "SELECT * FROM times";

		PreparedStatement ps = CON.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Time t = new Time();

			t.setId(rs.getInt("idTime"));
			t.setNome(rs.getString("nomeTime"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));

			times.add(t);
		}

		rs.close();
		ps.close();

		return times;
	}
}
