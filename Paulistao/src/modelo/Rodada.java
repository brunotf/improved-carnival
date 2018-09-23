package modelo;

import java.sql.Date;

public class Rodada {
	private int rodada = 0;
	private Date dataRodada = null;

	public int getRodada() {
		return rodada;
	}

	public void setRodada(int rodada) {
		this.rodada = rodada;
	}

	public Date getDataRodada() {
		return dataRodada;
	}

	public void setDataRodada(Date dataRodada) {
		this.dataRodada = dataRodada;
	}

}
