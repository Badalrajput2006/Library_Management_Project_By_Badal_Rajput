package com.lms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.pojo.User;
import com.lms.service.UserService;
import com.lms.servicelmpl.UserServiceimpl; 

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println("action:" + action);
		
		 if("showAddUser".equalsIgnoreCase(action)) 
		 {
			 request.setAttribute("currentPage", "addUser");
			 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addUser.jsp");
			 dispatcher.forward(request, response);
		 }
		 else if("addUser".equalsIgnoreCase(action))
		 {
			 String firstName= request.getParameter("firstName");
			 String lastName= request.getParameter("lastName");
			 String email= request.getParameter("email");
			 String phoneNo= request.getParameter("phone");
			 String  address= request.getParameter("address");
			 
			 
			 User user = new User();
			 user.setFirstName(firstName);
			 user.setLastName(lastName);
			 user.setEmail(email);
			 user.setPhoneNo(phoneNo);
			 user.setAddress(address);
			 user.setRole("USER");
			 
			 String randomPass = UUID.randomUUID().toString().replace("-", "").substring(0,8);
			 user.setPassword(randomPass);
			 user.setCreatedAt(new Date());
			 
			 
			 UserService userService = new UserServiceimpl();
			 boolean addFlag = userService.addUser(user);
			 if(addFlag)
			 {
				  List<User> userList = new ArrayList<User>();
				  
				 userList = userService.getAllUserList();
				  if(userList!= null && userList.size()>0)
				  {
					  request.setAttribute("userList", userList);
						 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/userList.jsp");
						 dispatcher.forward(request, response);
				  }
				  else
					 {
						 request.setAttribute("errorMessage", "Something Went Wrong");
						 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addUser.jsp");
						 dispatcher.forward(request, response);
					 }
			 }
			 else
			 {
				 request.setAttribute("errorMessage", "Something Went Wrong");
				 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addUser.jsp");
				 dispatcher.forward(request, response);
			 }
			 
		 }
		 else if("allUserList".equalsIgnoreCase(action))
		 {
			 List<User> userList = new ArrayList<User>();
			 
			 UserService userService = new UserServiceimpl();
			 userList = userService.getAllUserList();
			 
			  if(userList!= null && userList.size()>0)
			  {
				  request.setAttribute("currentPage", "users");
				  request.setAttribute("userList", userList);
					 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/userList.jsp");
					 dispatcher.forward(request, response);
			  }
			   
		 }
		 else if("viewUser".equalsIgnoreCase(action))
		 {
			 String userId = request.getParameter("userId");
			 
			 UserService userService = new UserServiceimpl();
			 User user = userService.getUserById(Long.parseLong(userId));
			 
			 if(user != null)
			 {
				 request.setAttribute("user", user);
				  RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editUser.jsp");
			      dispatcher.forward(request, response);
			 }
			 else
			 {
				 List<User> userList = new ArrayList<User>();
				 userList = userService.getAllUserList();
				 
				  if(userList!= null && userList.size()>0)
				  {
					  request.setAttribute("errorMessage", "User Not Found !!");
					  request.setAttribute("userList", userList);
					  RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/userList.jsp");
				      dispatcher.forward(request, response);
				  }
			 }
		 }
		 else if("updateUser".equalsIgnoreCase(action))
		 {
			 String firstName= request.getParameter("firstName");
			 String lastName= request.getParameter("lastName"); 
			 String phoneNo= request.getParameter("phone");
			 String  address= request.getParameter("address");
			 String email = request.getParameter("email");
			 long userId = Long.parseLong(request.getParameter("userId"));
			 
			 User user = new User();
			 user.setFirstName(firstName);
			 user.setLastName(lastName); 
			 user.setEmail(email);
			 user.setPhoneNo(phoneNo);
			 user.setAddress(address);  
			 user.setUserId(userId);
			 
			 UserService userService = new UserServiceimpl();
			 boolean addFlag = userService.updateUser(user);
			 if(addFlag)
			 { 
				 request.setAttribute("user", user);
				 request.setAttribute("successMessage", "User Updated Successfully..!!");
				 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editUser.jsp");
				 dispatcher.forward(request, response);   
			 }
			 else
			 {
				 request.setAttribute("user", user);
				 request.setAttribute("errorMessage", "Something Went Wrong");
				 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/updateUser.jsp");
				 dispatcher.forward(request, response);
			 }
			 
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
