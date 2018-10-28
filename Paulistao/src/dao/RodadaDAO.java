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
			r.setGolsA(rs.getInt("GOLS A"));
			r.setGolsB(rs.getInt("GOLS B"));
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

		// Grupo A com grupo B
		grupoAxB(grupoA, grupoB, datas);

		// Grupo C com o grupo D
		grupoCxD(grupoC, grupoD, datas);

		// Grupo A com o grupo C
		grupoAxC(grupoA, grupoC, datas);

		// Grupo B com o grupo D
		grupoBxD(grupoB, grupoD, datas);

		// Grupo A com o grupo D
		grupoAxD(grupoA, grupoD, datas);

		// Grupo B com o grupo C
		grupoBxC(grupoB, grupoC, datas);
	}

	private void grupoAxB(LinkedList<Grupo> grupoA, LinkedList<Grupo> grupoB,
						  LinkedList<DataRodada> datas) throws SQLException {

		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<>();

		int rodada = 0;

		for (int i = 0; i < 5; i++) {
			int contador = 0;

			for (int inicio = i; contador < 5; contador++) {

				Jogo jogo = new Jogo();

				jogo.setTimeA(grupoA.get(i).getIdTime());
				jogo.setTimeB(grupoB.get(inicio).getIdTime());
				jogo.setGolsA((int) (Math.random() * 12));
				jogo.setGolsB((int) (Math.random() * 12));
				jogo.setData(datas.get(rodada).getDataRodada());

				rodadas.add(jogo);

				inicio++;

				if (inicio > 4)
					inicio = 0;

				rodada++;

			}
			rodada = 0;
		}

		inserirRodadas(rodadas);

	}

	private void grupoCxD(LinkedList<Grupo> grupoC, LinkedList<Grupo> grupoD, 
						  LinkedList<DataRodada> datas)	throws SQLException {

		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<>();

		int rodada = 0;

		for (int i = 0; i < 5; i++) {
			int contador = 0;

			for (int inicio = i; contador < 5; contador++) {

				Jogo jogo = new Jogo();

				jogo.setTimeA(grupoC.get(i).getIdTime());
				jogo.setTimeB(grupoD.get(inicio).getIdTime());
				jogo.setGolsA((int) (Math.random() * 12));
				jogo.setGolsB((int) (Math.random() * 12));
				jogo.setData(datas.get(rodada).getDataRodada());

				rodadas.add(jogo);

				inicio++;

				if (inicio > 4)
					inicio = 0;

				rodada++;

			}
			rodada = 0;
		}

		inserirRodadas(rodadas);

	}

	private void grupoAxC(LinkedList<Grupo> grupoA, LinkedList<Grupo> grupoC, 
						  LinkedList<DataRodada> datas) throws SQLException {
		
		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<>();

		int rodada = 5;

		for (int i = 0; i < 5; i++) {
			int contador = 0;

			for (int inicio = i; contador < 5; contador++) {

				Jogo jogo = new Jogo();

				jogo.setTimeA(grupoA.get(i).getIdTime());
				jogo.setTimeB(grupoC.get(inicio).getIdTime());
				jogo.setGolsA((int) (Math.random() * 12));
				jogo.setGolsB((int) (Math.random() * 12));
				jogo.setData(datas.get(rodada).getDataRodada());

				rodadas.add(jogo);

				inicio++;

				if (inicio > 4)
					inicio = 0;

				rodada++;

			}
			rodada = 5;
		}

		inserirRodadas(rodadas);

	}

	private void grupoBxD(LinkedList<Grupo> grupoB, LinkedList<Grupo> grupoD, 
						  LinkedList<DataRodada> datas)	throws SQLException {
		
		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<>();

		int rodada = 5;

		for (int i = 0; i < 5; i++) {
			int contador = 0;

			for (int inicio = i; contador < 5; contador++) {

				Jogo jogo = new Jogo();

				jogo.setTimeA(grupoB.get(i).getIdTime());
				jogo.setTimeB(grupoD.get(inicio).getIdTime());
				jogo.setGolsA((int) (Math.random() * 12));
				jogo.setGolsB((int) (Math.random() * 12));
				jogo.setData(datas.get(rodada).getDataRodada());

				rodadas.add(jogo);

				inicio++;

				if (inicio > 4)
					inicio = 0;

				rodada++;

			}
			rodada = 5;
		}

		inserirRodadas(rodadas);

	}

	private void grupoAxD(LinkedList<Grupo> grupoA, LinkedList<Grupo> grupoD, 
						  LinkedList<DataRodada> datas) throws SQLException {
		
		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<>();

		int rodada = 10;

		for (int i = 0; i < 5; i++) {
			int contador = 0;

			for (int inicio = i; contador < 5; contador++) {

				Jogo jogo = new Jogo();

				jogo.setTimeA(grupoA.get(i).getIdTime());
				jogo.setTimeB(grupoD.get(inicio).getIdTime());
				jogo.setGolsA((int) (Math.random() * 12));
				jogo.setGolsB((int) (Math.random() * 12));
				jogo.setData(datas.get(rodada).getDataRodada());

				rodadas.add(jogo);

				inicio++;

				if (inicio > 4)
					inicio = 0;

				rodada++;

			}
			rodada = 10;
		}

		inserirRodadas(rodadas);

	}

	private void grupoBxC(LinkedList<Grupo> grupoB, LinkedList<Grupo> grupoC, 
						  LinkedList<DataRodada> datas)	throws SQLException {
		
		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<>();

		int rodada = 10;

		for (int i = 0; i < 5; i++) {
			int contador = 0;

			for (int inicio = i; contador < 5; contador++) {

				Jogo jogo = new Jogo();

				jogo.setTimeA(grupoB.get(i).getIdTime());
				jogo.setTimeB(grupoC.get(inicio).getIdTime());
				jogo.setGolsA((int) (Math.random() * 12));
				jogo.setGolsB((int) (Math.random() * 12));
				jogo.setData(datas.get(rodada).getDataRodada());

				rodadas.add(jogo);

				inicio++;

				if (inicio > 4)
					inicio = 0;

				rodada++;

			}
			rodada = 10;
		}

		inserirRodadas(rodadas);

	}

	public void inserirRodadas(LinkedHashSet<Jogo> rodada) throws SQLException {
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

	public LinkedList<DataRodada> obterRodadas() throws SQLException {
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
