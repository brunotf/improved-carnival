import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.LinkedList;

import dao.GrupoDAO;
import dao.RodadaDAO;
import modelo.DataRodada;
import modelo.Grupo;
import modelo.Jogo;

public class Separador {

	public static void main(String[] args) throws SQLException {

		GrupoDAO gDao = new GrupoDAO();

		RodadaDAO rDao = new RodadaDAO();

		LinkedList<Grupo> grupoA = gDao.obterGrupo("A");
		LinkedList<Grupo> grupoB = gDao.obterGrupo("B");
		LinkedList<Grupo> grupoC = gDao.obterGrupo("C");
		LinkedList<Grupo> grupoD = gDao.obterGrupo("D");

		LinkedList<DataRodada> datas = rDao.obterRodadas();

		System.out.println(datas);

		LinkedHashSet<Jogo> rodadas = new LinkedHashSet<Jogo>();

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

		System.out.println(rodadas);

	}

}
