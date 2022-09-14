<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
</head>
<body>
	<h1>Change Password</h1>
	<form action="#" method="POST">

		<input type="password" placeholder="Enter Old Password"
			name="oldPassword" /><br> <input type="password"
			placeholder="Enter new Password" name="newPassword" /><br> <input
			type="password" placeholder="Enter new Password again"
			name="confirmNewPassword" /><br> <input type="submit" />
	</form>
	<%
	if ((request.getMethod()).equals("POST")) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8", "root",
			"Harishwin@123");
			String oldPassword = request.getParameter("oldPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmNewPassword = request.getParameter("confirmNewPassword");
			PreparedStatement stmt = con.prepareStatement("SELECT Password FROM Customers where Customer_ID=?");
			boolean success = false;
			int customer_id = (Integer) session.getAttribute("customer_id");
			stmt.setInt(1, customer_id);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			if (rs.getString(1).equals(oldPassword)) {
		if (newPassword.equals(confirmNewPassword)) {
			stmt = con.prepareStatement("UPDATE Customers SET Password=? WHERE Customer_ID=?");
			stmt.setInt(2, customer_id);
			stmt.setString(1, newPassword);
			stmt.executeUpdate();
			success = true;

		} else {
			out.println("Passwords dont match");
		}
			} else {
		out.print("old password is wrong");
			}
			con.close();
			if (success) {
		response.sendRedirect("./SignIn.html");
			}
		} catch (Exception e) {
			out.println(e);
		}
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
		<button formaction="./customer/customerMenu.html">back</button>
	</form>
	<%
	}
	%>
</body>
</html>