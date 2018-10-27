package modelo;

import java.sql.Date;
import java.util.Objects;

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

	@Override
	public int hashCode() {
		return Objects.hash(dataJogo, golsA, golsB, timeA, timeB);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Rodada)) {
			return false;
		}
		Rodada other = (Rodada) obj;
		return Objects.equals(dataJogo, other.dataJogo) && golsA == other.golsA && golsB == other.golsB
				&& Objects.equals(timeA, other.timeA) && Objects.equals(timeB, other.timeB);
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(timeA + " contra " + timeB);
		return sb.toString();
	}

}
