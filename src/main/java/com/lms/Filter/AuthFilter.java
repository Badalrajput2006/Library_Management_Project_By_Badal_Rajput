package com.lms.Filter;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
     
		
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		
		
		String url = httpServletRequest.getRequestURI();
		HttpSession session =httpServletRequest.getSession();
		
		
		boolean loggedIn = (session != null && session.getAttribute("user") != null);
		boolean allowedUrl = url.equals(httpServletRequest.getContextPath() + "/") ||
				url.equals(httpServletRequest.getContextPath() + "/Authentication") ;
		
		
		if(loggedIn || allowedUrl) {
		chain.doFilter(request, response);
		
		}
		else {
		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/login.jsp");
		dispatcher.forward (request, response);
		}
		
	}
}
