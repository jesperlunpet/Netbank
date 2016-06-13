<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.UUID"%>
<%@page import="netbank.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% String id=request.getParameter("updateinformation"); %>
<% Account account = DatabaseGet.getAccounts(IDType.ACCID, UUID.fromString(id)).get(0); %>
<form action="ChangeInformationServlet.jsp">
	<table border="1" style="width:100%">
		<tr>
			<td> Account ID </td>
			<td> Balance </td>
			<td> Currency </td>
			<td> Debt </td>
			<td> Interest </td>
			<td> Owner ID </td>
		</tr>
		<% NumberFormat numberFormat = NumberFormat.getCurrencyInstance(); %>
		<% if(account != null) { %>
			<% numberFormat.setCurrency(account.getCurrency()); %>
			<tr>
				<td> <%=account.getAccountID().toString()%> </td>
				<td> <%=numberFormat.format(account.getBalance())%> </td>
				<td> <%=account.getCurrency().getDisplayName()%> </td>
				<td> <%=numberFormat.format(account.getDebt())%> </td>
				<td> <%=account.getInterest()%>% </td>
				<td> <%=account.getOwnerID() %> </td>
			</tr>
			<tr>
				<td> Can't change </td>
				<td> Can't change </td>
				<td> <input type="text" name="currency" placeholder="New currency"> </td>
				<td> <input type="text" name="debt" placeholder="New debt"> </td>
				<td> <input type="text" name="interest" placeholder="New interest"> </td>
				<td> <input type="text" name="cusid" placeholder="New owner"> </td>
			</tr>
		<% } %>
	</table>
	<input type="hidden" name="accid" value="<%= account.getAccountID().toString() %>">
	<input type="submit" name="changeinformation">
</form>
</body>
</html>