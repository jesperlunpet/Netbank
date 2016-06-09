package model;

import netbank.*;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.UUID;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Database db = null;
		try {
			db = new Database();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		CustomerInf cust = DatabaseGet.getCustomer(username);
		if(cust != null && Dao.loginValidate(cust.getSalt(),cust.getHash(),password)) {
			ArrayList<Account> accounts = DatabaseGet.getAccounts(IDType.CUSID,cust.getID());
			request.setAttribute("accounts", accounts); // add to request
			request.setAttribute("customer", cust); // add to request
			request.getSession().setAttribute("accounts", accounts); // add to session
			request.getSession().setAttribute("customer", cust); // add to session
			this.getServletConfig().getServletContext().setAttribute("accounts", accounts);
			this.getServletConfig().getServletContext().setAttribute("customer", cust);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("MainMenu.jsp");
			dispatcher.forward(request, response);
		} else {
			request.setAttribute("message", "Username or password error");
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);
		}
		out.close(); 
	}
}
