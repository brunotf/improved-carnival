package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class RodadasDAO {
	private Connection CON;
	
	public void gerarRodadas() throws SQLException {
		CON = DBUtil.getInstance().getConnection();
				
		String sql = "{CALL sp_gerarRodadas(?, ?, ?)}";
		
		CallableStatement cs = CON.prepareCall(sql);
	}

}
