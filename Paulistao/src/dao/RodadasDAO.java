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

public class RodadasDAO {
	private Connection CON;

	public void definirRodadas() throws SQLException {

		LinkedList<Grupos> grupoA = obterGrupoA();
		LinkedList<Grupos> grupoB = obterGrupoB();
		LinkedList<Grupos> grupoC = obterGrupoC();
		LinkedList<Grupos> grupoD = obterGrupoD();

		LinkedList<Rodada> datas = obterRodadas();

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

	private LinkedList<Rodada> obterRodadas() throws SQLException {
		CON = DBUtil.getInstance().getConnection();

		LinkedList<Rodada> rodadas = new LinkedList<>();

		String sql = "SELECT * FROM rodada ORDER BY numeroRodada";

		PreparedStatement ps = CON.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Rodada r = new Rodada();

			r.setRodada(rs.getInt("numeroRodada"));
			r.setDataRodada(rs.getDate("dataRodada"));

			rodadas.add(r);

		}

		rs.close();
		ps.close();

		return rodadas;
	}

}
