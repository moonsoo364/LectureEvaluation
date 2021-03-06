package evaluation;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	

	public int write(EvaluationDTO evaluationDTO) {
		String SQL="INSERT INTO EVALUATION VALUES (NULL,?,?,?,?,?,?,?,?,?,?,?,?,0)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, evaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3,evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, evaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, evaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, evaluationDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, evaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1;//DB ??????
	}
	//?????? ??????
	public ArrayList<EvaluationDTO> getList(String lectureDivide,String searchType,String search ,int pageNumber){
		if(lectureDivide.equals("??????")) {
			 lectureDivide="";
			 
		}
		ArrayList<EvaluationDTO> evaluationList=null;
		String SQL="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		try {
			if(searchType.equals("?????????")) {
				SQL="SELECT * FROM EVALUATION WHERE  lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent) LIKE"+
						"? ORDER BY evaluationID DESC limit "+pageNumber*5+","+pageNumber*5+6;
				System.out.println("searchType="+searchType+"\n");
			}else if(searchType.equals("?????????")) {

				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT "
				+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
				System.out.println("searchType="+searchType+"\n");

			}
			System.out.println("lecturedivide="+lectureDivide+"\n");
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,"%"+lectureDivide+"%");
			pstmt.setString(2,"%"+search+"%");
			System.out.printf("search=%s\n", search);
			rs=pstmt.executeQuery();
			evaluationList =new ArrayList<EvaluationDTO>();
			while(rs.next()) {//?????? ???????????? ????????? ??? ?????? ???????????? ??????
				EvaluationDTO evaluation = new EvaluationDTO(
				rs.getInt(1),
				rs.getString(2),
				rs.getString(3),
				rs.getString(4),
				rs.getInt(5),
				rs.getString(6),
				rs.getString(7),
				rs.getString(8),
				rs.getString(9),
				rs.getString(10),
				rs.getString(11),
				rs.getString(12),
				rs.getString(13),
				rs.getInt(14)
				);
				evaluationList.add(evaluation);
			}
	
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList;
	}
	public int like(String evaluationID) {
		String SQL="update evaluation set likecount = likecount+1 where evaluationID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		conn=DatabaseUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationID);
			return  pstmt.executeUpdate();
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1;//DB ??????
	}
	public int delete(String evaluationID) {
		String SQL=" delete from evaluation where evaluationID =?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		conn=DatabaseUtil.getConnection();
		try {
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,Integer.parseInt(evaluationID));
			return  pstmt.executeUpdate();	//?????? ??????
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1;//DB ??????
	}
	public String getUserID(String evaluationID) {//evaluationID ??? ????????? userID??? ????????????.
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		conn=DatabaseUtil.getConnection();
		try {
			String SQL="SELECT userID FROM evaluation WHERE evaluationID=?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,Integer.parseInt(evaluationID));
			rs= pstmt.executeQuery();
			while(rs.next()) {//?????? ?????? ????????? ??? ????????? True ???????????? ????????? False??? ??????
				System.out.println("rs.setString(1)="+rs.getString(1)+"\n");
				return rs.getString(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("DB?????? ???????????? SQL?????? ???????????????.\n");
			
		}finally {
			try {if(conn!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null;//DB ??????
	}
}
