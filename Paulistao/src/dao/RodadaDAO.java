package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedHashSet;
import java.util.LinkedList;

import modelo.Grupo;
import modelo.Jogo;
import modelo.Rodada;
import modelo.DataRodada;

public class RodadaDAO {
	private Connection CONEXAO;

	public LinkedList<Rodada> buscarRodada(String data) throws SQLException {

		CONEXAO = DBUtil.getInstance().getConnection();

		LinkedList<Rodada> rodada = new LinkedList<>();

		String sql = "SELECT * FROM v_jogos WHERE DATA_JOGO = ?";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

		ps.setString(1, data);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Rodada r = new Rodada();

			r.setTimeA(rs.getString("TIME A"));
			r.setTimeB(rs.getString("TIME B"));
			r.setGolsA(rs.getInt("GOLS_A"));
			r.setGolsB(rs.getInt("GOLS_B"));
			r.setDataJogo(rs.getDate("DATA_JOGO"));

			rodada.add(r);
		}

		rs.close();
		ps.close();

		return rodada;

	}

	public void definirRodadas() throws SQLException {
		
		GrupoDAO gDao = new GrupoDAO();

		LinkedList<Grupo> grupoA = gDao.obterGrupo("A");
		LinkedList<Grupo> grupoB = gDao.obterGrupo("B");
		LinkedList<Grupo> grupoC = gDao.obterGrupo("C");
		LinkedList<Grupo> grupoD = gDao.obterGrupo("D");

		LinkedList<DataRodada> datas = obterRodadas();

		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<Jogo>();

		int incremento = 1;

		for (int i = 0; i < 5; i++) {
			for (int inicio = i; inicio < 5; inicio++) {

				Jogo j1 = new Jogo();

				j1.setTimeA(grupoA.get(i).getIdTime());
				j1.setTimeB(grupoB.get(inicio).getIdTime());
				j1.setGolsA((int) (Math.random() * 12));
				j1.setGolsB((int) (Math.random() * 12));
				j1.setData(datas.get(i).getDataRodada());

				rodadas.add(j1);

				Jogo j2 = new Jogo();

				j2.setTimeA(grupoA.get(i).getIdTime());
				j2.setTimeB(grupoB.get(inicio).getIdTime());
				j2.setGolsA((int) (Math.random() * 12));
				j2.setGolsB((int) (Math.random() * 12));
				j2.setData(datas.get(i).getDataRodada());

				rodadas.add(j2);

				if (inicio > 4)
					inicio = 0;

				incremento++;
				if (incremento == 5) {
					break;
				}

			}

		}

	}

	private void inserirRodadas(LinkedHashSet<Jogo> rodada) throws SQLException {
		CONEXAO = DBUtil.getInstance().getConnection();

		String sql = "{CALL sp_inserirRodadas(?, ?, ?, ?, ?, ?)}";

		String saida = "";

		CallableStatement cs = CONEXAO.prepareCall(sql);

		for (Jogo j : rodada) {
			cs.setInt(1, j.getTimeA());
			cs.setInt(2, j.getTimeB());
			cs.setInt(3, j.getGolsA());
			cs.setInt(4, j.getGolsB());
			cs.setDate(5, j.getData());
			cs.registerOutParameter(6, Types.VARCHAR);

			cs.execute();

			saida = cs.getString(6);

		}

		System.out.println(saida);

		cs.close();
	}


	private LinkedList<DataRodada> obterRodadas() throws SQLException {
		CONEXAO = DBUtil.getInstance().getConnection();

		LinkedList<DataRodada> rodadas = new LinkedList<>();

		String sql = "SELECT * FROM rodada ORDER BY numeroRodada";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			DataRodada r = new DataRodada();

			r.setRodada(rs.getInt("numeroRodada"));
			r.setDataRodada(rs.getDate("dataRodada"));

			rodadas.add(r);

		}

		rs.close();
		ps.close();

		return rodadas;
	}

}
