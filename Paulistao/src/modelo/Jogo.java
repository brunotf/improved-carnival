package modelo;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Objects;

public class Jogo {
	private int timeA = 0;
	private int timeB = 0;
	private int golsA = 0;
	private int golsB = 0;
	private Date data = null;

	public int getTimeA() {
		return timeA;
	}

	public void setTimeA(int timeA) {
		this.timeA = timeA;
	}

	public int getTimeB() {
		return timeB;
	}

	public void setTimeB(int timeB) {
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

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	@Override
	public int hashCode() {
		return Objects.hash(data, golsA, golsB, timeA, timeB);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Jogo)) {
			return false;
		}
		Jogo other = (Jogo) obj;
		return Objects.equals(data, other.data) && golsA == other.golsA && golsB == other.golsB && timeA == other.timeA
				&& timeB == other.timeB;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(timeA + " contra " + timeB);
		String data = this.data.toString();
		SimpleDateFormat dataHtml = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dataSql = new SimpleDateFormat("dd/MM/yyyy");
		String dataFormatada = "";

		try {
			dataFormatada = dataSql.format(dataHtml.parse(data));
		} catch (ParseException e) {
			e.printStackTrace(System.out);
		}
		
		sb.append(" - dia: " + dataFormatada);
		return sb.toString();
	}

}
