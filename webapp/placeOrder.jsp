<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlaceOrder</title>
</head>
<body>

	<%!static HashMap<Integer, Integer> cart = new HashMap<>();
	static int item_id, quantity = 0, total = 0, current_stock = 0, updated_stock = 0;
	static Connection con;
	static ResultSet rs;
	static PreparedStatement ps;
	static PreparedStatement ks;
	static PreparedStatement gs;
	static PreparedStatement order;
	static PreparedStatement ds;
	static ResultSet stock_set;
	static int id;
	static ResultSet iss;
	static PreparedStatement cost;
	static int difference;%>
	<%
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8", "root", "Harishwin@123");

	try {
		out.println("<h1>Inventory</h1>");
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT Item_ID, Name, Current_stock, Selling_cost from Items");
		out.println("Item ID || Name || Stock || Cost");
	%><br>
	<%
	while (rs.next()) {
		out.println(rs.getInt(1) + "       || " + rs.getString(2) + " || " + rs.getInt(3) + " || " + rs.getInt(4));
	%>
	<br>
	<%
	}
	%>

	<h3>Add item</h3>
	<form action="#" method="POST">
		<input type="hidden" name="confirmOrder" value="false" /> <input
			type="number" name="item_ID" placeholder="item_ID" /> <input
			type="number" name="quantity" placeholder="Quantity" /> <input
			type="submit">
	</form>
	<h2>Cart</h2>
	<%
	if ((request.getMethod().equals("GET"))) {
		cart = new HashMap<>();
		total = 0;
	}

	if (((request.getMethod()).equals("POST")) && (request.getParameter("confirmOrder")).equals("false")) {
		item_id = Integer.parseInt(request.getParameter("item_ID"));
		quantity = Integer.parseInt(request.getParameter("quantity"));
		if (cart.containsKey(item_id)) {
			difference = quantity - cart.get(item_id);
			cart.put(item_id, quantity);
			cost = con.prepareStatement("SELECT Selling_cost FROM Items WHERE Item_ID=? ");
			cost.setInt(1, item_id);
			iss = cost.executeQuery();
			iss.next();
			total += (iss.getInt("Selling_cost")) * difference;

		} else {
			cart.put(item_id, quantity);
			cost = con.prepareStatement("SELECT Selling_cost FROM Items WHERE Item_ID=? ");
			cost.setInt(1, item_id);
			iss = cost.executeQuery();
			iss.next();
			total += (iss.getInt("Selling_cost")) * quantity;
		}
		for (Map.Entry<Integer, Integer> curr_item : cart.entrySet()) {
			item_id = curr_item.getKey();
			quantity = curr_item.getValue();

			ps = con.prepareStatement("SELECT Name FROM Items WHERE Item_ID = ?");
			ps.setInt(1, item_id);
			rs = ps.executeQuery();
			rs.next();
			out.println(item_id + "  " + rs.getString(1) + " " + quantity + " " + "<br>");

		}

		out.print("<b>Total : " + total + "<b/>");

	}
	if (((request.getMethod()).equals("POST")) && (request.getParameter("confirmOrder")).equals("true")) {
		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT MAX(Order_ID) FROM Orders");
		rs.next();
		id = rs.getInt(1) + 1;
		out.print(id);

		gs = con.prepareStatement("SELECT Current_stock FROM Items where Item_ID=?");
		ks = con.prepareStatement("INSERT INTO OrderItems VALUES (?,?,?)");
		order = con.prepareStatement("INSERT INTO Orders VALUES (?,?,?,?,?,?)");
		ds = con.prepareStatement("UPDATE Items SET Current_stock=? WHERE Item_ID=?");
		Calendar cal = Calendar.getInstance();
		Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
		order.setInt(1, id);
		order.setTimestamp(2, timestamp);
		order.setInt(3, total);
		order.setInt(4, 10);
		order.setInt(5, 18);
		int cid = (Integer) session.getAttribute("customer_id");
		order.setInt(6, cid);
		order.executeUpdate();

		for (Map.Entry<Integer, Integer> curr_item : cart.entrySet()) {
			item_id = curr_item.getKey();
			quantity = curr_item.getValue();
			gs.setInt(1, item_id);
			stock_set = gs.executeQuery();
			stock_set.next();
			current_stock = stock_set.getInt("Current_stock");
			updated_stock = current_stock - quantity;
			if (updated_stock < 0) {
		out.println("Low stock couldn't place order");
		break;
			}
			ds.setInt(1, updated_stock);
			ds.setInt(2, item_id);
			ds.executeUpdate();

			ks.setInt(1, item_id);
			ks.setInt(2, id);
			ks.setInt(3, quantity);
			ks.executeUpdate();
			total = 0;
			cart = new HashMap<>();

		}
		response.sendRedirect("./viewOrders.jsp");

		out.print("<h3>Order placed sucessfully</h3>");

	}

	} catch (Exception e) {
	System.out.println(e);
	}
	%>
	<form action="#" method="POST">
		<input type="hidden" name="confirmOrder" value="true" /> <input
			type="submit" />
	</form>

	<%
	if (((Integer) session.getAttribute("isAdmin")) == 1) {
	%>
	<a href="./admin/adminMenu.jsp">Cancel Order</a>
	<%
	} else {
	%>
	<a href="./customer/customerMenu.html">Cancel Order</a>
	<%
	}
	%>
</body>
</html>