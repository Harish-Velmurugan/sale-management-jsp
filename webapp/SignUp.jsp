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
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT Customer_ID FROM Customers");
		int id = 0;
		if (rs.last()) {
			id = rs.getInt("Customer_ID") + 1;
		}

		PreparedStatement ins = con.prepareStatement("INSERT INTO Customers VALUES (?,?,?,?,?,?,?) ");

		ins.setInt(1, id);
		ins.setString(2, request.getParameter("username"));
		ins.setInt(3, Integer.parseInt(request.getParameter("age")));
		ins.setString(4, request.getParameter("phone"));
		ins.setString(5, request.getParameter("email"));
		ins.setInt(6, 0);
		ins.setString(7, request.getParameter("password"));
		int i = ins.executeUpdate();
		con.close();
	} catch (Exception e) {
		System.out.println(e);
	}
	%>

	<h1>Account Sucessfully Created</h1>
	<h2>
		<a href="./SignIn.html">Login</a>
	</h2>
</body>
</html>