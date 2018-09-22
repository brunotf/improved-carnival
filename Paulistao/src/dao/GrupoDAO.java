package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashSet;

import modelo.Grupos;
import modelo.Time;

public class GrupoDAO {

	private Connection CON;

	private HashSet<Time> times() {
		CON = DBUtil.getInstance().getConnection();

		HashSet<Time> times = new HashSet<>();

		String sql = "SELECT * FROM times";

		try {
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
		} catch (SQLException e) {
			e.printStackTrace(System.err);
		}
		return times;
	}

	public String gerarGrupos() {
		CON = DBUtil.getInstance().getConnection();

		HashSet<Time> times = times();

		String saida = "";

		String sql = "{CALL sp_dividirGrupos(?, ?)}";
		for (Time t : times) {
			try {
				CallableStatement cs = CON.prepareCall(sql);
				cs.setString(1, t.getNome());
				cs.registerOutParameter(2, Types.VARCHAR);
				cs.execute();
				cs.close();
				saida = cs.getString(2);
			} catch (SQLException e) {
				e.printStackTrace(System.err);
			}
		}

		return saida;
	}

	public HashSet<Grupos> exibirGrupos() {
		CON = DBUtil.getInstance().getConnection();

		HashSet<Grupos> grupos = new HashSet<>();

		String sql = "SELECT * FROM CHAVES";

		try {
			PreparedStatement ps = CON.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Grupos g = new Grupos();

				g.setNomeTime(rs.getString("nomeTime"));
				g.setGrupo(rs.getString("grupo"));

				grupos.add(g);
			}
		} catch (SQLException e) {
			e.printStackTrace(System.err);
		}

		return grupos;
	}
}
