import java.sql.Date;
import java.util.HashSet;

public class Separador {

	public static void main(String[] args) {
		
		Jogo j1 = new Jogo();
		Jogo j2 = new Jogo();
		
		j1.setTimeA(1);
		j1.setGolsB(2);
		j1.setGolsA(5);
		j1.setGolsB(3);
		j1.setData(new Date(1000000));
		
		j2.setTimeA(1);
		j2.setGolsB(2);
		j2.setGolsA(5);
		j2.setGolsB(3);
		j2.setData(new Date(1000000));
		
		System.out.println(j1.equals(j2));
		
		System.out.println(j1.equals(j1));
		
		HashSet<Jogo> rodada = new HashSet<>();
		
		rodada.add(j1);
		
		rodada.add(j1);
		
		rodada.add(j2);
		
		System.out.println(rodada);
		

	}

}
