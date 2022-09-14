<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<% 
try{
if((boolean)session.getAttribute("signedIn") == true){
	
	%>
<title>Admin Menu</title>
</head>
<body>
<% 
if((request.getMethod()).equals("POST")){
	out.println("Working");
	session.setAttribute("signedIn",false);
	response.sendRedirect("../SignIn.html");
}
%>
	<center>
		<h1>Admin Menu</h1>
		<h3>
			<a href="../placeOrder.jsp">Place order</a>
		</h3>
		<h3>
			<a href="../viewOrders.jsp">View Orders</a>
		</h3>
		<h3>
			<a href="./viewAllOrders.jsp">View All Orders</a>
		</h3>
		<h3>
			<a href="../viewItems.jsp">View available items</a>
		</h3>
		<h3>
			<a href="./createItem.jsp">Create item</a>
		</h3>
		<h3>
			<a href="./updateItem.jsp">Update item</a>
		</h3>
		
		<h3>
			<a href="./deleteItem.jsp">Delete Item</a>
		</h3>
		<h3>
			<a href="../viewProfile.jsp">View Profile</a>
		</h3>
		<h3>
			<a href="../UpdateProfile.jsp">Update Profile</a>
		</h3>
		<h3>
			<a href="../changePassword.jsp">Change Password</a>
		</h3>
		<form method="POST">
			<button formaction="#">Signout</button>
		</form>
	</center>
<% } 
else{
	%>
  	<script>
	alert("Unauthorized Access..... You will be redirected......");
	window.location = "../SignIn.html";
	</script> 	<%

}}
catch(Exception e){
	out.println(e);

}
%>
</body>
</html>