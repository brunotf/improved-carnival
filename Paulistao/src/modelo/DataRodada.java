package modelo;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DataRodada {
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

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();

		String data = this.dataRodada.toString();
		SimpleDateFormat dataHtml = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dataSql = new SimpleDateFormat("dd/MM/yyyy");
		String dataFormatada = "";

		try {
			dataFormatada = dataSql.format(dataHtml.parse(data));
		} catch (ParseException e) {
			e.printStackTrace(System.out);
		}

		sb.append(dataFormatada);

		return sb.toString();
	}

}
