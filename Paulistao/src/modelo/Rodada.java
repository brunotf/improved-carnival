package modelo;

import java.sql.Date;

public class Rodada {
	String timeA = "";
	String timeB = "";
	int golsA = 0;
	int golsB = 0;
	Date dataJogo = null;

	public String getTimeA() {
		return timeA;
	}

	public void setTimeA(String timeA) {
		this.timeA = timeA;
	}

	public String getTimeB() {
		return timeB;
	}

	public void setTimeB(String timeB) {
		this.timeB = timeB;
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

	public Date getDataJogo() {
		return dataJogo;
	}

	public void setDataJogo(Date dataJogo) {
		this.dataJogo = dataJogo;
	}

}
