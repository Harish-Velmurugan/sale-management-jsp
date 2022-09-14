<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Item</title>
</head>
<body>

 
 <% 
	Class.forName("com.mysql.jdbc.Driver");
 Connection con=DriverManager.getConnection(
         "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
 Statement st = con.createStatement();
 ResultSet rs = st.executeQuery("SELECT Item_ID, Name, Current_stock, Selling_cost from Items");
 out.println("Item ID || Name || Stock || Cost<br>");

 
 while (rs.next()) {
     out.println(rs.getInt(1) + "       || " + rs.getString(2) + " || " + rs.getInt(3) + " || " + rs.getInt(4) +"<br>");

 }
 
if((request.getMethod()).equals("POST")){
	

try {		
	
            int item_ID;
           
            item_ID = Integer.parseInt(request.getParameter("item_ID"));
            
            
            PreparedStatement stmt = con.prepareStatement("DELETE FROM Items WHERE Item_ID=?;");
            stmt.setInt(1, item_ID);
            stmt.executeUpdate();
            response.sendRedirect("./viewItems.jsp");	

        } catch (Exception e) {
            System.out.println(e);
        }


}
 %>
 <br>
 <br>
 <form action="#" method="POST">
<input type="number" placeholder="Item ID" name="item_ID" />
<input type="submit" />
</form>
<button type="button" onclick="javascript:history.back()">Back</button>

</body>
</html>