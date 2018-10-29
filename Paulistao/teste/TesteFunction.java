import java.sql.SQLException;
import java.util.LinkedList;

import dao.ResultadosDAO;
import modelo.Tabela;

public class TesteFunction {

	public static void main(String[] args) throws SQLException {
		ResultadosDAO resDao = new ResultadosDAO();

		LinkedList<Tabela> grupoA;
		LinkedList<Tabela> grupoB;
		LinkedList<Tabela> grupoC;
		LinkedList<Tabela> grupoD;

		grupoA = resDao.tabelaGrupo("A");
		grupoB = resDao.tabelaGrupo("B");
		grupoC = resDao.tabelaGrupo("C");
		grupoD = resDao.tabelaGrupo("D");

		for (Tabela t : grupoA) {

			System.out.println(t.getNomeTime());
			System.out.println(t.getNumJogosDisputados());
			System.out.println(t.getVitorias());
			System.out.println(t.getEmpates());
			System.out.println(t.getDerrotas());
			System.out.println(t.getGolsMarcados());
			System.out.println(t.getGolsSofridos());
			System.out.println(t.getSaldoGols());
			System.out.println(t.getPontos());
		}
	}

}
