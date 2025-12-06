<html>

















<body>
<%
//checking the user crediantials
String userType=(String)session.getAttribute("usertype");
String userName=(String)session.getAttribute("username");
String password=(String)session.getAttribute("password");

if(userType==null||userType.equals("admin")){
	
	response.sendRedirect("login.jsp?message=Access denied, Login as admin");
	
}

else if(userName==null|| password==null){
	
response.sendRedirect("login.jsp?message=Seesion expired,Login Again");	
	
} 
%>
<!--we cannot call it from anywhere-->
<jsp:include page="header.jsp"/>

<div class="products" style="background-color:#f1cdf6;">

<div class="tab"align="center">
<form>
<button type="submit" formaction="adminViewProduct.jsp">View
Products</button>
<br>
<br>
<button type="submit" formaction="addProduct.jsp">Add
Products</button>
<br>
<br>
<button type="submit" formaction="removeProduct.jsp">Remove
Products</button>
<br>
<br>
<button type="submit" formaction="updateProductById.jsp">Update
Products</button>
<br>
<br>
</form>
</div>
</div>

<%@include file="footer.html"%>
</body>
</html>