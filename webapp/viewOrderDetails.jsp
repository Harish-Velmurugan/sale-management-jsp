<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8", "root",
		"Harishwin@123");

		int Order_ID = Integer.parseInt(request.getParameter("order_ID"));
		out.print("<h1>Order no : " + Order_ID + "</h1>");
		PreparedStatement stmt = con.prepareStatement(
		"select Items.Item_ID,Name,Selling_cost,OrderItems.Quantity from Items join OrderItems on Items.Item_ID=OrderItems.Item_ID where OrderItems.Order_ID = ?;");
		PreparedStatement tot = con.prepareStatement("select Total from Orders where Order_ID = ?");
		tot.setInt(1, Order_ID);
		ResultSet r = tot.executeQuery();
		r.next();
		stmt.setInt(1, Order_ID);
		ResultSet rs = stmt.executeQuery();
		out.println("Item ID || Item Name || Cost || Quantity <br>");
		while (rs.next()) {
			out.println(rs.getInt(1) + " || " + rs.getString(2) + " || " + rs.getInt(3) + " || " + rs.getInt(4) + "<br>");

		}
		out.println("Total : " + r.getInt("Total"));

	} catch (Exception e) {
		System.out.println(e);
	}
	%>
	<% 
	if (((Integer) session.getAttribute("isAdmin")) == 1) {
		%>
		<form>
		<button formaction="./admin/adminMenu.jsp">Back</button>
	</form>
		<%
		} else {
		%>
	<form>
		<button formaction="./customer/customerMenu.html">Back</button>
	</form>
	<%
		}
		%>
</body>
</html>