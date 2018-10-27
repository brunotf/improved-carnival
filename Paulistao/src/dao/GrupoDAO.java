package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashSet;
import java.util.LinkedList;

import modelo.Grupo;
import modelo.Time;

public class GrupoDAO {

	private Connection CONEXAO;

	public String dividirGrupos() throws SQLException {
		CONEXAO = DBUtil.getInstance().getConnection();

		HashSet<Time> times = times();

		String saida = "";

		int contador = 0;

		String sql = "{CALL sp_dividirGrupos(?,?)}";

		CallableStatement cs = CONEXAO.prepareCall(sql);

		for (Time t : times) {
			cs.setString(1, t.getNome());
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			saida = cs.getString(2);
			if (saida == null) {
				contador++;
			}
		}

		cs.close();

		if (contador == 20) {
			saida = "Times adicionados!";
		}

		return saida;
	}

	public LinkedList<Grupo> obterTodosGrupos() throws SQLException {
		CONEXAO = DBUtil.getInstance().getConnection();

		LinkedList<Grupo> grupos = new LinkedList<>();

		String sql = "SELECT * FROM v_grupos ORDER BY grupo";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Grupo g = new Grupo();

			g.setIdTime(rs.getInt("idTime"));
			g.setGrupo(rs.getString("grupo"));
			g.setNomeTime(rs.getString("nomeTime"));

			grupos.add(g);
		}

		rs.close();
		ps.close();

		return grupos;
	}
	
	public LinkedList<Grupo> obterGrupo(String letraGrupo) throws SQLException {
		CONEXAO = DBUtil.getInstance().getConnection();

		LinkedList<Grupo> grupo = new LinkedList<>();

		String sql = "SELECT * FROM v_grupos WHERE grupo = ?";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

		ps.setString(1, letraGrupo);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Grupo g = new Grupo();
			
			g.setIdTime(rs.getInt("idTime"));
			g.setGrupo(rs.getString("grupo"));
			g.setNomeTime(rs.getString("nomeTime"));

			grupo.add(g);
		}

		rs.close();
		ps.close();

		return grupo;
	}

	private HashSet<Time> times() throws SQLException {
		CONEXAO = DBUtil.getInstance().getConnection();

		HashSet<Time> times = new HashSet<>();

		String sql = "SELECT * FROM times";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

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
