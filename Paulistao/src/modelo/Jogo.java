package modelo;

import java.sql.Date;

public class Jogo {
	private int TimeA = 0;
	private int TimeB = 0;
	private int golsA = 0;
	private int golsB = 0;
	private Date data = null;

	public int getTimeA() {
		return TimeA;
	}

	public void setTimeA(int timeA) {
		TimeA = timeA;
	}

	public int getTimeB() {
		return TimeB;
	}

	public void setTimeB(int timeB) {
		TimeB = timeB;
	}

	public int getGolsA() {
		return golsA;
	}

	public void setGolsA(int golsA) {
		this.golsA = golsA;
	}

	public int getGolsB() {
		return golsB;
	}

	public void setGolsB(int golsB) {
		this.golsB = golsB;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

}
