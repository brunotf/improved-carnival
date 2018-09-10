package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import model.Produto;

public class ProdutoDao {

	private Connection c;

	public ProdutoDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}

	public String insereProduto(Produto p) throws SQLException {
		String sql = "{CALL sp_insereproduto(?, ?}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, p.getNome());
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.execute();

		String saida = cs.getString(2);
		cs.close();

		return saida;
	}

}
