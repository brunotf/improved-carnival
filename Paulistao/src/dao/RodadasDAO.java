package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedHashSet;
import java.util.LinkedList;

import modelo.Grupos;
import modelo.Jogo;
import modelo.Rodada;
import modelo.DataRodada;

public class RodadasDAO {
	private Connection CON;

	public LinkedList<Rodada> buscarRodada(String data) throws SQLException {

		CON = DBUtil.getInstance().getConnection();

		LinkedList<Rodada> rodada = new LinkedList<>();

		String sql = "SELECT * FROM v_jogos WHERE DATA_JOGO = ?";

		PreparedStatement ps = CON.prepareStatement(sql);
		
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

		LinkedList<Grupos> grupoA = obterGrupoA();
		LinkedList<Grupos> grupoB = obterGrupoB();
		LinkedList<Grupos> grupoC = obterGrupoC();
		LinkedList<Grupos> grupoD = obterGrupoD();

		LinkedList<DataRodada> datas = obterRodadas();

		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<Jogo>();

		for (int i = 0; i < 15; i++) {
			for (int j = 0; j < 5; j++) {

				if (j == 1) {

					Jogo jogo = new Jogo();

					jogo.setTimeA(grupoA.get(i % 5).getIdTime());
					jogo.setTimeB(grupoB.get(j).getIdTime());
					jogo.setGolsA((int) (Math.random() * 12));
					jogo.setGolsB((int) (Math.random() * 12));
					jogo.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo);

					Jogo jogo2 = new Jogo();

					jogo2.setTimeA(grupoC.get(i % 5).getIdTime());
					jogo2.setTimeB(grupoD.get(j).getIdTime());
					jogo2.setGolsA((int) (Math.random() * 12));
					jogo2.setGolsB((int) (Math.random() * 12));
					jogo2.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo2);

				} else if (j == 2) {

					Jogo jogo = new Jogo();

					jogo.setTimeA(grupoA.get(i % 5).getIdTime());
					jogo.setTimeB(grupoC.get(i % 5).getIdTime());
					jogo.setGolsA((int) (Math.random() * 12));
					jogo.setGolsB((int) (Math.random() * 12));
					jogo.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo);

					Jogo jogo2 = new Jogo();

					jogo2.setTimeA(grupoB.get(j).getIdTime());
					jogo2.setTimeB(grupoD.get(j).getIdTime());
					jogo2.setGolsA((int) (Math.random() * 12));
					jogo2.setGolsB((int) (Math.random() * 12));
					jogo2.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo2);

				} else if (j == 3) {

					Jogo jogo = new Jogo();

					jogo.setTimeA(grupoA.get(i % 5).getIdTime());
					jogo.setTimeB(grupoD.get(j).getIdTime());
					jogo.setGolsA((int) (Math.random() * 12));
					jogo.setGolsB((int) (Math.random() * 12));
					jogo.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo);

					Jogo jogo2 = new Jogo();

					jogo2.setTimeA(grupoB.get(j).getIdTime());
					jogo2.setTimeB(grupoC.get(i % 5).getIdTime());
					jogo2.setGolsA((int) (Math.random() * 12));
					jogo2.setGolsB((int) (Math.random() * 12));
					jogo2.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo2);

				} else if (j == 4) {

					Jogo jogo = new Jogo();

					jogo.setTimeA(grupoA.get(j).getIdTime());
					jogo.setTimeB(grupoC.get(j).getIdTime());
					jogo.setGolsA((int) (Math.random() * 12));
					jogo.setGolsB((int) (Math.random() * 12));
					jogo.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo);

					Jogo jogo2 = new Jogo();

					jogo2.setTimeA(grupoB.get(i % 5).getIdTime());
					jogo2.setTimeB(grupoD.get(i % 5).getIdTime());
					jogo2.setGolsA((int) (Math.random() * 12));
					jogo2.setGolsB((int) (Math.random() * 12));
					jogo2.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo2);

				} else if (j == 0) {

					Jogo jogo = new Jogo();

					jogo.setTimeA(grupoA.get(i % 5).getIdTime());
					jogo.setTimeB(grupoC.get(i % 5).getIdTime());
					jogo.setGolsA((int) (Math.random() * 12));
					jogo.setGolsB((int) (Math.random() * 12));
					jogo.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo);

					Jogo jogo2 = new Jogo();

					jogo2.setTimeA(grupoB.get(i % 5).getIdTime());
					jogo2.setTimeB(grupoD.get(i % 5).getIdTime());
					jogo2.setGolsA((int) (Math.random() * 12));
					jogo2.setGolsB((int) (Math.random() * 12));
					jogo2.setData(datas.get(i).getDataRodada());

					rodadas.add(jogo2);
				}

			}
		}

		inserirRodadas(rodadas);

	}

	private void inserirRodadas(LinkedHashSet<Jogo> rodada) throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		String sql = "{CALL sp_inserirRodadas(?, ?, ?, ?, ?, ?)}";

		String saida = "";

		CallableStatement cs = CON.prepareCall(sql);

		for (Jogo j : rodada) {
			cs.setInt(1, j.getTimeA());
			cs.setInt(2, j.getTimeB());
			cs.setInt(3, j.getGolsA());
			cs.setInt(4, j.getGolsB());
			cs.setDate(5, j.getData());
			cs.registerOutParameter(6, Types.VARCHAR);

			cs.execute();

			saida = cs.getString(6);

			System.out.println(saida);
		}

		cs.close();
	}

	private LinkedList<Grupos> obterGrupoA() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Grupos> grupos = new LinkedList<>();

		String sql = "SELECT * FROM grupos WHERE grupo = 'A' ORDER BY idTime";

		PreparedStatement ps = CON.prepareStatement(sql);

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

	private LinkedList<Grupos> obterGrupoB() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Grupos> grupos = new LinkedList<>();

		String sql = "SELECT * FROM grupos WHERE grupo = 'B' ORDER BY idTime";

		PreparedStatement ps = CON.prepareStatement(sql);

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

	private LinkedList<Grupos> obterGrupoC() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Grupos> grupos = new LinkedList<>();

		String sql = "SELECT * FROM grupos WHERE grupo = 'C' ORDER BY idTime";

		PreparedStatement ps = CON.prepareStatement(sql);

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

	private LinkedList<Grupos> obterGrupoD() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Grupos> grupos = new LinkedList<>();

		String sql = "SELECT * FROM grupos WHERE grupo = 'D' ORDER BY idTime";

		PreparedStatement ps = CON.prepareStatement(sql);

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

	private LinkedList<DataRodada> obterRodadas() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<DataRodada> rodadas = new LinkedList<>();

		String sql = "SELECT * FROM rodada ORDER BY numeroRodada";

		PreparedStatement ps = CON.prepareStatement(sql);

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
