<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
</head>
<body>
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8", "root",
		"Harishwin@123");
		int choice = 1;
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM Customers WHERE Customer_ID=?");
		int id = (Integer) session.getAttribute("customer_id");
		stmt.setInt(1, id);
		ResultSet rs = stmt.executeQuery();
		out.println("<h1>Your Profile</h1><b>Customer Id || Name || Age || Phone || Mail</b><br>");
		while (rs.next()) {
			out.println(rs.getInt(1) + " || " + rs.getString(2) + " || " + rs.getInt(3) + " || " + rs.getString(4) + " || "
			+ rs.getString(5));

		}

	} catch (Exception e) {
		System.out.println(e);
	}
	%>
	<br>
	<br>
	<%
	if (((Integer) session.getAttribute("isAdmin")) == 1) {
	%>
	<a href="./admin/adminMenu.jsp">Back</a>
	<%
	} else {
	%>
	<a href="./customer/customerMenu.html">Back</a>
	<%
	}
	%>

</body>
</html>