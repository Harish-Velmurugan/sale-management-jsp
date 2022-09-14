<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Item</title>
</head>
<body>
	<center>
		<h1>Create Item</h1>
		<form action="#" method="POST">
			<input type="text" placeholder="Item Name" name="itemName" /><br>
			<input type="number" placeholder="Current Stock" name="currentStock" /><br>
			Manufactured Date: <input type="date" placeholder="Manufactured Date"
				name="manufacturedDate" /><br> Expiry Date: <input type="date"
				placeholder="Expiry Date" name="expiryDate" /><br> <input
				type="number" placeholder="Buying Cost" name="buyingCost" /><br>
			<input type="number" placeholder="Selling Cost" name="sellingCost" /><br>
			<input type="submit" />
		</form>
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

	</center>
	<%
	if ((request.getMethod()).equals("POST")) {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8", "root",
			"Harishwin@123");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT Item_ID FROM Items");
			int id = 0, stock, buyingCost, sellingCost;
			String itemName, smanufacturedDate, sexpiryDate;
			if (rs.last()) {
		id = rs.getInt("Item_ID") + 1;
			}
			itemName = request.getParameter("itemName");
			stock = Integer.parseInt(request.getParameter("currentStock"));
			smanufacturedDate = request.getParameter("manufacturedDate");
			Date manufacturedDate = new SimpleDateFormat("yyyy-MM-dd").parse(smanufacturedDate);
			sexpiryDate = request.getParameter("expiryDate");
			Date expiryDate = new SimpleDateFormat("yyyy-MM-dd").parse(sexpiryDate);
			buyingCost = Integer.parseInt(request.getParameter("buyingCost"));
			sellingCost = Integer.parseInt(request.getParameter("sellingCost"));
			PreparedStatement ins = con.prepareStatement("INSERT INTO Items VALUES (?,?,?,?,?,?,?) ");
			ins.setInt(1, id);
			ins.setString(2, itemName);
			ins.setInt(3, stock);
			ins.setTimestamp(4, new Timestamp(manufacturedDate.getTime()));
			ins.setTimestamp(5, new Timestamp(expiryDate.getTime()));
			ins.setInt(6, buyingCost);
			ins.setInt(7, sellingCost);
			ins.executeUpdate();
			System.out.println("Item Created");
			response.sendRedirect("../viewItems.jsp");

		} catch (Exception e) {
			System.out.println(e);
		}
	}
	%>



</body>
</html>