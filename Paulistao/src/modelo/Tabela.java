package modelo;

import java.util.Objects;

public class Tabela {

	private String nomeTime = "";
	private int numJogosDisputados = 0;
	private int vitorias = 0;
	private int empates = 0;
	private int derrotas = 0;
	private int golsMarcados = 0;
	private int golsSofridos = 0;
	private int saldoGols = 0;
	private int pontos = 0;
	private String rebaixado = "";

	public String getNomeTime() {
		return nomeTime;
	}

	public void setNomeTime(String nomeTime) {
		this.nomeTime = nomeTime;
	}

	public int getNumJogosDisputados() {
		return numJogosDisputados;
	}

	public void setNumJogosDisputados(int numJogosDisputados) {
		this.numJogosDisputados = numJogosDisputados;
	}

	public int getVitorias() {
		return vitorias;
	}

	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}

	public int getEmpates() {
		return empates;
	}

	public void setEmpates(int empates) {
		this.empates = empates;
	}

	public int getDerrotas() {
		return derrotas;
	}

	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}

	public int getGolsMarcados() {
		return golsMarcados;
	}

	public void setGolsMarcados(int golsMarcados) {
		this.golsMarcados = golsMarcados;
	}

	public int getGolsSofridos() {
		return golsSofridos;
	}

	public void setGolsSofridos(int golsSofridos) {
		this.golsSofridos = golsSofridos;
	}

	public int getSaldoGols() {
		return saldoGols;
	}

	public void setSaldoGols(int saldoGols) {
		this.saldoGols = saldoGols;
	}

	public int getPontos() {
		return pontos;
	}

	public void setPontos(int pontos) {
		this.pontos = pontos;
	}

	public String getRebaixado() {
		return rebaixado;
	}

	public void setRebaixado(String rebaixado) {
		this.rebaixado = rebaixado;
	}

	@Override
	public int hashCode() {
		return Objects.hash(derrotas, empates, golsMarcados, golsSofridos, nomeTime, numJogosDisputados, pontos,
				saldoGols, vitorias);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Tabela)) {
			return false;
		}
		Tabela other = (Tabela) obj;
		return derrotas == other.derrotas && empates == other.empates && golsMarcados == other.golsMarcados
				&& golsSofridos == other.golsSofridos && Objects.equals(nomeTime, other.nomeTime)
				&& numJogosDisputados == other.numJogosDisputados && pontos == other.pontos
				&& saldoGols == other.saldoGols && vitorias == other.vitorias;
	}

}
