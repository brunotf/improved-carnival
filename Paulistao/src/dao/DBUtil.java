package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

	private final static String USERNAME = "paulistaoaccess";
	private final static String PASSWORD = "123456";
	private final static String URLDB = "jdbc:jtds:sqlserver://localhost:1433;databaseName=paulistao";
	private static DBUtil instancia;
	private Connection con;

	private DBUtil() {
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection(URLDB, USERNAME, PASSWORD);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace(System.err);
		}
	}

	public static DBUtil getInstance() {
		if (instancia == null)
			instancia = new DBUtil();
		return instancia;
	}

	public Connection getConnection() {
		return con;
	}

}
