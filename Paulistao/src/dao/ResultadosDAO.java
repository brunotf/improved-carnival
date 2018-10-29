package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import modelo.Tabela;

public class ResultadosDAO {
	private Connection CONEXAO;

	public LinkedList<Tabela> tabelaGrupo(String grupo) throws SQLException {

		CONEXAO = DBUtil.getInstance().getConnection();

		LinkedList<Tabela> tabela = new LinkedList<>();

		String sql = "SELECT * FROM fn_validagrupo(?) ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

		ps.setString(1, grupo);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Tabela t = new Tabela();

			t.setNomeTime(rs.getString("nomeTime"));
			t.setNumJogosDisputados(rs.getInt("numJogosDisputados"));
			t.setVitorias(rs.getInt("vitorias"));
			t.setEmpates(rs.getInt("empates"));
			t.setDerrotas(rs.getInt("derrotas"));
			t.setGolsMarcados(rs.getInt("golsMarcados"));
			t.setGolsSofridos(rs.getInt("golsSofridos"));
			t.setSaldoGols(rs.getInt("saldoGols"));
			t.setPontos(rs.getInt("pontos"));

			tabela.add(t);

		}

		rs.close();
		ps.close();

		return tabela;

	}

	public LinkedList<Tabela> tabelaGeral() throws SQLException {

		CONEXAO = DBUtil.getInstance().getConnection();

		LinkedList<Tabela> tabelaGeral = new LinkedList<>();

		String sql = "SELECT * FROM fn_campeonato() ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC";

		PreparedStatement ps = CONEXAO.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Tabela t = new Tabela();

			t.setNomeTime(rs.getString("nomeTime"));
			t.setNumJogosDisputados(rs.getInt("numJogosDisputados"));
			t.setVitorias(rs.getInt("vitorias"));
			t.setEmpates(rs.getInt("empates"));
			t.setDerrotas(rs.getInt("derrotas"));
			t.setGolsMarcados(rs.getInt("golsMarcados"));
			t.setGolsSofridos(rs.getInt("golsSofridos"));
			t.setSaldoGols(rs.getInt("saldoGols"));
			t.setPontos(rs.getInt("pontos"));

			tabelaGeral.add(t);

		}

		rs.close();
		ps.close();

		return tabelaGeral;

	}

}
