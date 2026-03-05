package com.lms.Filter;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();

		HttpSession session = req.getSession(false);

		boolean loggedIn = session != null && session.getAttribute("user") != null;

		boolean loginRequest = uri.equals(contextPath + "/jsp/login.jsp")
				|| uri.equals(contextPath + "/Authentication");

		boolean resourceRequest = uri.contains("assets") || uri.contains("css")
				|| uri.contains("js") || uri.contains("bootstrap");

		if (loggedIn || loginRequest || resourceRequest) {
			chain.doFilter(request, response);
		} else {
			res.sendRedirect(contextPath + "/jsp/login.jsp");
		}
	}
}
