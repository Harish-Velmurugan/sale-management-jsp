<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "java.io.*,java.util.*,java.sql.*"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Orders</title>
</head>
<body>
<%
try {
	Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
    //int choice = 1;
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * from Orders");
    out.println("<h1>Your Orders</h1><br><b>Order ID  ||  Customer ID   ||   Placed on  ||  Total  ||  Discount</b>	<br>");
    while(rs.next()){
    	out.println(rs.getInt(1)+" &emsp;&emsp;&emsp;&ensp;|| "+rs.getInt(6)+"  ||   "+ rs.getString(2)+" || "+rs.getInt(3)+" || "+rs.getInt(4)+"<br>" );

    }
} catch (Exception e) {
    System.out.println(e);
}
%>

<form>
    <button formaction="./placeOrder.jsp">Place Order</button>
</form>
<form action="viewOrderDetails.jsp" method = "POST">
	<input type = "number" name = "order_ID"/>
	<input type = "submit" name = "submit" /> 
</form>
<%
	if(((Integer)session.getAttribute("isAdmin"))==1){ %>
		<a href="./adminMenu.html">Back</a>
<% 		
	}
	else{
%> <a href="./customerMenu.html">Back</a>
<% 
	}%>
</body>
</html>