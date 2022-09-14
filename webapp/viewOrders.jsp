<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view past orders</title>
</head>
<body>
<% 
try{
	
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
    PreparedStatement stmt = con.prepareStatement("select Order_Id,CreatedAt,Total,Discount from Orders join Customers on Orders.Customer_ID = Customers.Customer_ID where Customers.Customer_ID=?");
    
    int id = (Integer)session.getAttribute("customer_id");
    stmt.setInt(1,id);
    ResultSet rs = stmt.executeQuery();
    out.println("<h1>Your Orders</h1><br><b>Order ID  ||  Placed on  ||  Total  ||  Discount</b>	<br>");
    while(rs.next()){
    	out.println(rs.getInt(1)+" &emsp;&emsp;&emsp;&ensp;|| "+rs.getString(2)+" || "+rs.getInt(3)+" || "+rs.getInt(4) );
%>
<br>
<% 
    }
    
    
    con.close(); 
}catch(Exception e){ System.out.println(e);}


%> 

<form action="viewOrderDetails.jsp" method = "POST">
	<input type = "number" name = "order_ID"/>
	<input type = "submit" name = "submit" /> 
</form>
<%
	if(((Integer)session.getAttribute("isAdmin"))==1){ %>
		<a href="./admin/adminMenu.html">Back</a>
<% 		
	}
	else{
%> <a href="./customer/customerMenu.html">Back</a>
<% 
	}
%>
</body>
</html>