package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
		public static Connection getConnection() {
			try {
				String dbURL= "jdbc:mysql://localhost:3306/LectureEvaluation?serverTimezone=UTC&characterEncording=UTF-8";
				String dbID= "root";
				String dbPassword= "1234";
				String dbDriver= "com.mysql.cj.jdbc.Driver";
				Class.forName(dbDriver);
				return DriverManager.getConnection(dbURL,dbID,dbPassword);
				
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	

}
