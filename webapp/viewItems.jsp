<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "java.io.*,java.util.*,java.sql.*"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inventory</title>
</head>
<body>
<%
try {
	Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
    //int choice = 1;
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT Item_ID, Name, Current_stock, Selling_cost from Items");
    out.println("Item ID || Name || Stock || Cost");
    %><br><%
    
    while (rs.next()) {
        out.println(rs.getInt(1) + "       || " + rs.getString(2) + " || " + rs.getInt(3) + " || " + rs.getInt(4));
%>
<br>
<%
    }
} catch (Exception e) {
    System.out.println(e);
}
%>
<button type="button" onclick="javascript:history.back()">Back</button>
<form>
    <button formaction="./placeOrder.jsp">Place Order</button>
</form>
</body>
</html>