package modelo;

import java.sql.Date;

public class Jogo {
	private String nomeTimeA = "";
	private String golsTimeA = "";
	private String nomeTimeB = "";
	private String golsTimeB = "";
	private Date data = null;

	public String getNomeTimeA() {
		return nomeTimeA;
	}

	public void setNomeTimeA(String nomeTimeA) {
		this.nomeTimeA = nomeTimeA;
	}

	public String getGolsTimeA() {
		return golsTimeA;
	}

	public void setGolsTimeA(String golsTimeA) {
		this.golsTimeA = golsTimeA;
	}

	public String getNomeTimeB() {
		return nomeTimeB;
	}

	public void setNomeTimeB(String nomeTimeB) {
		this.nomeTimeB = nomeTimeB;
	}

	public String getGolsTimeB() {
		return golsTimeB;
	}

	public void setGolsTimeB(String golsTimeB) {
		this.golsTimeB = golsTimeB;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}
}
