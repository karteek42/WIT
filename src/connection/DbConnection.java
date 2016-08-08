package connection;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;


public class DbConnection implements Constants
{
	private static  Connection con=null;
	public static Connection  getConnection()
	{
		
		try {
			Class.forName(Driver);
			con = DriverManager.getConnection(Url,UserName,Password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;

	}
}
