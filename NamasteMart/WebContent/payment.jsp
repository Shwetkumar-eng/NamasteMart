<%@page import="com.google.gson.Gson"%>
<%@page import="com.namastemart.service.impl.*"%>
<%@page import="com.namastemart.service.*"%>
<%@page import="com.namastemart.beans.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Payment</title>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width,initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
<%
String userName=(String)session.getAttribute("username");
String password=(String)session.getAttribute("password");
if(userName==null||password==null){
	response.sendRedirect("login.jsp?message=session Expired,Login Again");
	
	
}
String sAmount=request.getParameter("amount");
double amount=0;
if(sAmount != null){
	amount=Double.parseDouble(sAmount);
}
%>
<jsp:include page="header.jsp"/>

<div class="container">
<div class="row"
style="margin-top:5px;margin-left:2px;margin-right:2px;">
<form action="./OrderServlet"method="post"
class="col-md-6 col-md-offset-3 "
style="border:2px solid black;border-redius:10px; background-color:#b341ab;padding:10px;">
<div style="font-weight:bold;" class="text-center">
<div class="form-group">
<img src="images/profile.png" alt="Payment Processed"height="100px;"/>
<h2 style="color:black;">Credit Card Payment</h2>
</div>
</div>

<div></div>
<div class="row">
<div class="col-md-12 form-group">
<label for="last_name">Name Of Card Holder</label><input type="text"
placeholder="enter Card Holder Name" name="cardholder" class="form-control"
id="last_name" required>
</div>
</div>

<div class="row">
<div class="col-md-12 form-group">
<label for="last_name">enter credit card number</label><input type="number"
placeholder="2222-4444-5555" name="cardnumber" class="form-control"
id="last_name" required>
</div>
</div>

<div class="row">
<div class="col-md-6 form-group">
<label for="last_name">Expiry Month</label><input type="number"
placeholder="mm" name="expmonth" class="form-control" size="2"
max="12" main="0"
id="last_name" required>
</div>
<div class="col-md-6 form-group">
<label for="last_name">Expiry Year</label><input type="number"
placeholder="yy" name="expyear" class="form-control" size="4"
max="12" main="0"
id="last_name" required>
</div>


</div>

<div class="row text-center">
<div class="col-md-6 form-group">
<label for="last_name">Enter Cvv</label><input type="number"
placeholder="123" name="expyear" class="form-control" size="3"
id="last_name" required><input type="hidden"
name="amount" value="<%=amount%>">
</div>

<div class="col-md-6 form-group">
<label>&nbsp;</label><button type="submit"
class="form-control btn btn-success">
Pay:Rs
<%=amount%></button>
</div>


</div>

</form>
</div>
</div>
<%@:include page="footer.html"%>


</body>
</html>