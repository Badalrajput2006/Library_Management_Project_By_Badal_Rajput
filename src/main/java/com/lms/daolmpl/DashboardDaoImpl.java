package com.lms.daolmpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; 

import com.lms.dao.DashboardDao; 
import com.lms.pojo.DashboardStats;
import com.lms.util.Dbutil;

public class DashboardDaoImpl implements DashboardDao{
	

	private final  String TOTAL_BOOK = "Select COUNT(*) from books";
	private final  String TOTAL_USER = "Select COUNT(*) from users where role = 'user'";
	
	private final  String BOOK_STATUS = "Select COUNT(*) from book_issued WHERE status = ? ";
	 
	private int fetchCount(String sql )
	{
		
		return  fetchCount(sql,null);
	}
	
	private int fetchCount(String sql, String status)
	{
		Connection conn = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null; 
		
		int count =0;
		try
		{
			conn = Dbutil.getConnection();
			preparedStatement = conn.prepareStatement(sql);
			
			if(status!=null)
			{
				preparedStatement.setString(1, status);
			}
			
			rs=preparedStatement.executeQuery();
			if(rs.next())
			{
				count = rs.getInt(1);
			}
			
		}
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
		 finally
		{
			try
			{
				if(rs!=null)
				{
					 rs.close();
				}
				if(preparedStatement!= null)
				{
					preparedStatement.close();
				}
				if(conn!=null)
				{
					conn.close();
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		return count;
	}
	
	
	public DashboardStats fetchDashboardStats()
	{
		int totalBook = fetchCount(TOTAL_BOOK);
		int totalUsers = fetchCount(TOTAL_USER);
		int bookAssigned = fetchCount(BOOK_STATUS,"ISSUED");
        int bookReturned = fetchCount(BOOK_STATUS,"RETURN");

		
		DashboardStats dashboardStats = new DashboardStats();
		dashboardStats.setTotalBooks(totalBook);
		dashboardStats.setTotalUsers(totalUsers);
		dashboardStats.setBooksAssigned(bookAssigned);
		dashboardStats.setBooksReturned(bookReturned);
		
		
		return dashboardStats;
	}
	 

}
