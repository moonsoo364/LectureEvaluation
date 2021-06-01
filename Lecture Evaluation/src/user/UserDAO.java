package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	//login id와 비밀번호를 받아서 로그인 해주는 함수.
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
					return 0; //비밀번호 틀림
				}
			
			}
			return -1;	
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -2;//DB 오류
	}
	//join 사용자의 정보를 받아 회원가입 실행
	public int join(UserDTO user) {
		String SQL="INSERT INTO USER VALUES (?,?,?,?,false)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate();//1을 반환하면 정상	
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1;//회원 가입 실패
	}
	//getUserEmail 사용자의 아이디를 받아 사용자의 이메일 주소 반환
	public String getUserEmail(String userID) {
		String SQL="SELECT userEmail FROM USER WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null;//DB 오류
		
	}
	//사용자가 이메일 인증 되었는 지 확인
	public boolean getUserEmailChecked(String userID) {
		String SQL="SELECT userEmailChecked FROM USER WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return false;//DB 오류
	}
	//특정 사용자의 이메일 인증을 수행하는 함수
	public boolean setUserEmailChecked(String userID) {
		String SQL="UPDATE USER SET userEmailChecked=true WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;//이미 인증된 이메일이라도 인증할 수 있도록 구현
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return false;//DB 오류
	}
}
		

			
	

