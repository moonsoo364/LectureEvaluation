package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM USER WHERE userID= ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)){
					return 1;//로그인 성공
				}
				else {
					return 0; //비밀번호
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
		

			
	

