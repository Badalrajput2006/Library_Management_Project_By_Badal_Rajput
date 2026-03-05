package com.lms.controller;
import com.lms.service.BookService;
import com.lms.service.UserService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;
import com.lms.pojo.User;
import com.lms.servicelmpl.BookServiceImpl;
import com.lms.servicelmpl.UserServiceimpl;
 

/**
 * Servlet implementation class BookController
 * @param <BookService>
 */
@WebServlet("/BookController")
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @param <BookService>
	 * @param <BooksService>
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String action = request.getParameter("action");
		 System.out.println("action:" + action);
		 
		 if("showAddBook".equalsIgnoreCase(action)) 
		 {
			 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addBook.jsp");
			 dispatcher.forward(request, response);
		 }
		 else if("addbook".equalsIgnoreCase(action))
		 {
			 String bookTitle = request.getParameter("bookTitle");
			 String author = request.getParameter("author");
			 String isbn = request.getParameter("isbn");
			 String category = request.getParameter("category");
			 String publisher = request.getParameter("publisher");
			 String availableCopies = request.getParameter("availableCopies");
			 String numberOfcopies = request.getParameter("numberOfcopies");
			 
			 Book book = new Book();
			 book.setTitle(bookTitle);
			 book.setAuthor(author);
			 book.setIsbn(isbn);
			 book.setCategory(category);
			 book.setPublisher(publisher);
			 book.setTotalCopies(Integer.parseInt(numberOfcopies));
			 book.setAvailableCopies(Integer.parseInt(availableCopies));
			 book.setCreatedAt(new Date());
			 book.setStatus("AVAILABLE");

			 
			 BookService bookService =   new BookServiceImpl();
			boolean flag = bookService.addBook(book);
			
			if(flag)
			{
				List<Book> booklist = new ArrayList<>();
				booklist= bookService.getAllBookList();
				
				if(booklist != null && booklist.size()>0)
				{
					request.setAttribute("booklist",booklist);
					request.setAttribute("SuccessMessage", "Book Added succesfully!!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookList.jsp");
				    dispatcher.forward(request, response);
				}
				else
				{
					request.setAttribute("errorMessage", "Something Went Wrong");
					 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addBook.jsp");
					 dispatcher.forward(request, response);
				}
				
			}
			else
			{
				request.setAttribute("errorMessage", "Something Went Wrong");
				 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addBook.jsp");
				 dispatcher.forward(request, response);
			}
		 }
		 else if("allBookList".equalsIgnoreCase(action))
		 {
			List<Book> booklist = new ArrayList<>();
			 
			BookService bookService =   new BookServiceImpl();
			booklist= bookService.getAllBookList();
				
				if(booklist != null && booklist.size()>0)
				{
					request.setAttribute("booklist",booklist);
					 
				    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookList.jsp");
				    dispatcher.forward(request, response);
				}
				else {
				    request.setAttribute("errorMessage","No Books Found");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookList.jsp");
				    dispatcher.forward(request, response);
				}

		 }
		 else if("viewBook".equalsIgnoreCase(action))
		 {
			 long bookId = Integer.parseInt(request.getParameter("bookId"));
			 
			 BookService bookService =   new BookServiceImpl();
			 Book book=bookService.getBookById(bookId);
			 if(book !=null)
			 {
				 request.setAttribute("book",book);
				 
				    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editBook.jsp");
				    dispatcher.forward(request, response);
			 }
			 else
			 {
				 List<Book> booklist = new ArrayList<>();
				 booklist= bookService.getAllBookList();
					
					if(booklist != null && booklist.size()>0)
					{
						request.setAttribute("errorMessage", "Book Data Not Found..!!");
						request.setAttribute("booklist",booklist);
						 
					    RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookList.jsp");
					    dispatcher.forward(request, response);
					}
			 }
		 }
		 else if("updateBook".equalsIgnoreCase(action))
		 {
		     String bookTitle = request.getParameter("bookTitle");
		     String author = request.getParameter("author");
		     String isbn = request.getParameter("isbn");
		     String category = request.getParameter("category");
		     String publisher = request.getParameter("publisher"); 
		     String numberOfcopies = request.getParameter("numberOfcopies");
		     String availableCopies = request.getParameter("availableCopies");
		     String bookIdStr = request.getParameter("bookId");

		     // 🔐 SAFETY CHECK
		     if(bookIdStr == null || bookIdStr.isEmpty()){
		         request.setAttribute("errorMessage", "Invalid Book ID");
		         RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookList.jsp");
		         dispatcher.forward(request, response);
		         return;
		     }

		     long bookId = Long.parseLong(bookIdStr);

		     int totalCopies = 0;
		     int availCopies = 0;

		     try {
		         if(numberOfcopies != null && !numberOfcopies.isEmpty()){
		             totalCopies = Integer.parseInt(numberOfcopies);
		         }

		         if(availableCopies != null && !availableCopies.isEmpty()){
		             availCopies = Integer.parseInt(availableCopies);
		         }

		     } catch (NumberFormatException e) {
		         request.setAttribute("errorMessage", "Invalid number format");
		         RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editBook.jsp");
		         dispatcher.forward(request, response);
		         return;
		     }

		     Book book = new Book();
		     book.setBookId(bookId);
		     book.setTitle(bookTitle);
		     book.setAuthor(author);
		     book.setIsbn(isbn);
		     book.setCategory(category);
		     book.setPublisher(publisher);
		     book.setTotalCopies(totalCopies);
		     book.setAvailableCopies(availCopies);

		     BookService bookService = new BookServiceImpl();
		     boolean updatedFlag = bookService.updateBook(book);

		     if(updatedFlag)
		     {
		         request.setAttribute("book", book);
		         request.setAttribute("successMessage","Book Updated Successfully...");
		         RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editBook.jsp");
		         dispatcher.forward(request, response);
		     }
		     else
		     {
		         request.setAttribute("book", book);
		         request.setAttribute("errorMessage", "Something Went Wrong");
		         RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editBook.jsp");
		         dispatcher.forward(request, response);
		     }
		 }
		 else if("showAssignBook".equalsIgnoreCase(action)) {
			 UserService userService = new UserServiceimpl();
			 BookService bookService = new BookServiceImpl();
			 
			 List<Book> bookList = new ArrayList<>();
			 bookList = bookService.getAllAvailableBookList();
			 
			 List<User> userList = new ArrayList<>();
			 userList = userService.getAllUserList();
			 
			 if(bookList != null && bookList.size() > 0 && userList != null && userList. size() > 0) 
			 {
			 request.setAttribute("bookList", bookList);
			 request.setAttribute("userList", userList);
			 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/assignBook.jsp");
			 dispatcher.forward(request, response);
			 }
			 else {
			 request.setAttribute("errorMessage", "Either book or user not available. Please try again.");
			 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/assignBook.jsp");
			 dispatcher.forward(request, response);
			 }
		 }else if("assignBook".equalsIgnoreCase(action)) {
			 String bookIdParam = request.getParameter("bookId");

			 if (bookIdParam == null || bookIdParam.isEmpty()) {
			     request.setAttribute("errorMessage", "Book selection is required.");
			     request.getRequestDispatcher("/jsp/assignBook.jsp").forward(request, response);
			     return;
			 }

			 Long bookId = Long.parseLong(bookIdParam);
			 String userIdParam = request.getParameter("userId");

			 if (userIdParam == null || userIdParam.isEmpty()) {
			     request.setAttribute("errorMessage", "Member selection is required.");
			     request.getRequestDispatcher("/jsp/assignBook.jsp").forward(request, response);
			     return;
			 }

			 Long userId = Long.parseLong(userIdParam);
			 String dueDate = request.getParameter("dueDate");
			 String assignmentNotes = request.getParameter("assignmentNotes");
			 Book book = new Book();
			 book.setBookId(bookId);
			 User user = new User();
			 user.setUserId(userId);
			 BookIssued bookIssued = new BookIssued();
			 bookIssued.setBook(book);
			 bookIssued.setUser(user);
			 
			 DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			 LocalDate localDueDate = null;
			 try {
			 localDueDate = LocalDate.parse(dueDate, dateFormatter);
			 System.out.println("Parsed localDueDate: "+ localDueDate);
			 } 
			 catch (DateTimeParseException e) 
			 {
			 System.err.println("Error parsing date: " + e.getMessage());
			 }
			 bookIssued.setDueDate(localDueDate);
			 bookIssued.setAssignmentNotes(assignmentNotes);
			 
			 BookService bookService = new BookServiceImpl();
			 boolean assignflag = bookService.assignBook(bookIssued);
			 
			 if(assignflag) {
			 HttpSession session = request.getSession();
			 session.setAttribute("successMessage", "Book assign successful !! ");
			 
			 response.sendRedirect("BookController?action=showAssignBook");
			 }
			 else {
			 request.setAttribute("errorMessage", "Book not assigned. Please try again.");
			 RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/assignBook.jsp");
			 dispatcher.forward(request, response);
			 }
		 }
		 else if("showReturnBook".equalsIgnoreCase(action)) 
		 {
			  
			 BookService bookService =new BookServiceImpl();
			 List<BookIssued> issuedList =bookService.getAllIssuedBookList();
			 if(issuedList != null && issuedList.size() > 0) 
			 {
				 LocalDate today = LocalDate.now();
				 for(BookIssued bookIssued : issuedList)
				 {
					 LocalDate dueDate = bookIssued.getDueDate();
					 if(dueDate.isBefore(today))
					 {
						 bookIssued.setDueDayStatus("Overdue");
					 }
					 else if(dueDate.isEqual(today))
					 {
						 bookIssued.setDueDayStatus("Due Today");
					 }
					 else
					 {
						 bookIssued.setDueDayStatus("Active");
					 }
				 }
			      request.setAttribute("issuedList", issuedList);
			      RequestDispatcher dispatcher= request.getRequestDispatcher("jsp/returnBook.jsp");
			      dispatcher.forward(request, response);
			 }
			  
		 }
		 else if("showReturnBookDetails".equalsIgnoreCase(action)) 
		 {
			 long issuedId = Long.parseLong(request.getParameter("issuedId"));
			 BookService bookService =new BookServiceImpl();
			BookIssued bookIssued = bookService.getIssuedBookById(issuedId);
			if(bookIssued!=null)
			{
				 request.setAttribute("bookIssued", bookIssued);
			      RequestDispatcher dispatcher= request.getRequestDispatcher("jsp/showReturnBookDetails.jsp");
			      dispatcher.forward(request, response);
			}
		 }
		 else if("returnBook".equalsIgnoreCase(action))
		 {
			 int issuedId= Integer.parseInt(request.getParameter("issuedId"));
			 String returnDate = request.getParameter("returnDate");
			 String bookCondition = request.getParameter("bookCondition");
			 String returnNotes = request.getParameter("returnNotes");
			 BookIssued bookIssued = new BookIssued();
			 bookIssued.setIssueId(issuedId);
			 DateTimeFormatter dateFormatter =DateTimeFormatter.ofPattern("yyyy-MM-dd");
			 LocalDate localReturnDate = null;
			 try 
			 {
			 localReturnDate =LocalDate.parse(returnDate, dateFormatter);
			 }
			 catch (DateTimeParseException e) 
			 {
			 System.err.println("Error parsing date: " + e.getMessage());
			 }
			 bookIssued.setReturnDate (localReturnDate);
			 bookIssued.setBookCondition(bookCondition);
			 bookIssued.setReturnNotes (returnNotes);
			 BookService bookService = new BookServiceImpl();
			 boolean flag =bookService.updateBookReturn (bookIssued);
			 if(flag) {
			 HttpSession session = request.getSession();
			 session.setAttribute("sucessMessage", "Book return successful!!");
			 response.sendRedirect("BookController?action=showReturnBook");
			 }
			 else {
			 HttpSession session = request.getSession();
			 session.setAttribute("errorMessage", "Something went wrong");
			 response.sendRedirect("BookController?action=showReturnBook");
			 } 
		 }
		 else
		 {
			 System.out.print("No Action Found");
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
