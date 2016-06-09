<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="netbank.*" %>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Currency"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Locale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Menu</title>
	<link rel='stylesheet' href=''>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div style="text-align: center">
		<% ArrayList<Account> accounts = (ArrayList<Account>) request.getAttribute("accounts"); %>
		<% CustomerInf cust = (CustomerInf) request.getAttribute("customer"); %>
		Welcome <%= cust.getName() %> <br/>
		<%= cust.getID() %>
		<form action="ShowTransactions" method="post">
			<table border="1" style="width:100%">
				<tr>
					<td> Account ID </td>
					<td> Balance </td>
					<td> Currency </td>
					<td> Debt </td>
					<td> Interest </td>
					<td>  </td>
				</tr>
			<% NumberFormat numberFormat = NumberFormat.getCurrencyInstance(Locale.CANADA); %>
			<% if(accounts != null) { %>
				<% for ( int i =0; i < accounts.size(); i++) { %>
					<% numberFormat.setCurrency(accounts.get(i).getCurrency()); %>
					<tr>
						<td> <%=accounts.get(i).getAccountID().toString()%> </td>
						<td> <%=numberFormat.format(accounts.get(i).getBalance())%> </td>
						<td> <%=accounts.get(i).getCurrency().getDisplayName()%> </td>
						<td> <%=numberFormat.format(accounts.get(i).getDebt())%> </td>
						<td> <%=accounts.get(i).getInterest()%>% </td>
						<td> <button name="showtransactions" value="<%=accounts.get(i).getAccountID()%>">Transactions</button> </td>
					</tr>
				<% } %>
			<% } %>
			</table>
		</form>
			
		<form action="Transaction.jsp" method="post">
			<% session.setAttribute("cusID", cust.getID()); %>
			<input type="submit" name="transaction" value="Transaction">		
		</form>
		<form action="WithdrawalServlet" method="post">
			<button name="withdrawal" type="submit">Withdrawal</button>
		</form>
		<form action="ChangePasswordServlet" method="post">
			<button name="changepassword" type="submit">Change password</button>
		</form>
		<div class="login-options">
			<a href="index.jsp">Back to log-in</a>
		</div>
	
	</div>
</body>
</html>