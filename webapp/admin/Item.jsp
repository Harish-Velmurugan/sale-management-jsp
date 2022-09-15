<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item</title>
</head>
<body>
	<center>
		<%!static String mode;
		static PreparedStatement stmt;
		%>
		<%
		String mode = request.getParameter("mode");
		if (mode.equals("create")) {
			mode="create";
		%>
		<h1>Create Item</h1>
		

		<%
		} else {
			mode="update";
		%>

		<h1>Update Item</h1>
		<%
		}
		%>
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
			<button formaction="./adminMenu.jsp">Back</button>
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
		<%
		if ((request.getMethod()).equals("POST")) {

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8", "root",
				"Harishwin@123");
				
				int stock, buyingCost, sellingCost;
				String itemName, smanufacturedDate, sexpiryDate;
				itemName = request.getParameter("itemName");
				stock = Integer.parseInt(request.getParameter("currentStock"));
				smanufacturedDate = request.getParameter("manufacturedDate");
				Date manufacturedDate = new SimpleDateFormat("yyyy-MM-dd").parse(smanufacturedDate);
				sexpiryDate = request.getParameter("expiryDate");
				Date expiryDate = new SimpleDateFormat("yyyy-MM-dd").parse(sexpiryDate);
				buyingCost = Integer.parseInt(request.getParameter("buyingCost"));
				sellingCost = Integer.parseInt(request.getParameter("sellingCost"));
				if(mode.equals("create")){
				stmt = con.prepareStatement("INSERT INTO Items(Name,Current_stock,Manufactured_Date,Expiry_Date,Buying_Cost,Selling_cost) VALUES (?,?,?,?,?,?) ");
				
				}
				else{
				stmt = con.prepareStatement(
						"UPDATE Items SET Name=?,Current_stock=?,Manufactured_Date=?,Expiry_Date=?,Buying_Cost=?,Selling_cost=? WHERE Item_ID=?");
				int item_id = Integer.parseInt(request.getParameter("item_ID"));
				stmt.setInt(7,item_id);
				}
				stmt.setString(1, itemName);
				stmt.setInt(2, stock);
				stmt.setTimestamp(3, new Timestamp(manufacturedDate.getTime()));
				stmt.setTimestamp(4, new Timestamp(expiryDate.getTime()));
				stmt.setInt(5, buyingCost);
				stmt.setInt(6, sellingCost);
				stmt.executeUpdate();

				response.sendRedirect("../viewItems.jsp");

			} catch (Exception e) {
				System.out.println(e);
			}
		}
		%>

	</center>

</body>
</html>