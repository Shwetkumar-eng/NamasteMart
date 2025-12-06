<%@page language="java"contentType="text/html;charset=ISO-8859-1"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.namastemart.service.impl.*"%>
<%@page import="com.namastemart.service.*"%>
<%@page import="com.namastemart.beans.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>

<head>
<title>Admin Home</title>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width,initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
//
//
<style>
body{
	margin:0;
	font-family:Arial,sans-serif;
}

.content{
	margin-left:250px;
	padding:20px;
	transition:margin-left 0.3s;
}

.sidebar.collapsed~.content{
	margin-left:100px;
}

.form-container{
	background-color:#f1cdf6;
	min-height:100vh;
	padding-bottom:20px;
}
.form-title{
font-weight:bold;
color:black;

}

.footer{
	position:relative;
	left:250px;
	bottom:0;
	width:calc(100%-250px);
	background-color:#333;
	color:white;
	text-align:center;
	padding:10px;
	margin-top:20px;
	transition: left 0.3s,width 0.3s;
}

.sidebar.collapsed~.footer{
	left:60px;
	width:calc(100%-60px);
}


</style>
</head>
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
<%@include file="adminheader.jsp"%>

<%
String message=request.getParameter("message");
%>

<div class="content">
<div class="form-container">
<div class="row" style="margin-top:5px; margin-left:2px; margin-right:2px;">
<form action="./AddProductSrv"method="post" enctype="multipart/form-data" class="col-md-6 col-md-offset-3
" style="border:2px solid black;border-redius:10px;background-color:#b341ab; padding:10px;">
<div class="form-title text-center">
<h3 style="color:black;">Product Addition Form</h3>
<%if(message!=null){%>
<p style="color:rgb(25,252,25);">
<%=message%>
</p>
<%}%>

</div>
<div></div>
<div class="row">
<div class="col-md-6 form-group">
<label for="productname">Product Name</label><input type="text"
placeholder="enter product name" name="name" class="form-control"
id="productname" required>
</div>

<div class="col-md-6 form-group">
<label for="producttype">Product Type</label>
<select name="type" id="producttype" class="form-control" required>
  <option value="electronics">Electronics</option>
  <option value="appliance">Appliance</option>
  <option value="fasion">Fasion and Apparel</option>
  <option value="home">Home</option>
  <option value="kitchen">Kitchen</option>
  <option value="fitness">Fitness</option>
  <option value="outdoor">Outdoor</option>
  <option value="sports">Sports</option>
  <option value="recreation">Recreation</option>
  <option value="toys">Toys</option>
  <option value="games">Games</option>
  <option value="supplements">Supplements</option>
  <option value="personal_care">Personal Care</option>
  <option value="office">Office</option>
  <option value="stationery">Stationery</option>
</select>
</div>
</div>

<div class="form-group">
<label for="productdesc">Product Description</label><textarea name="info" class="form-control"
id="productdesc" required></textarea>
</div>

<div class="row">
<div class="col-md-6 form-group">
<label for="productprice">Unit Price</label><input type="number"
placeholder="enter product price" name="price" class="form-control"
id="productprice" required>
</div>
<div class="col-md-6 form-group">
<label for="productquantity">Stock Quantity</label><input type="number"
placeholder="enter product Quantity" name="quantity" class="form-control"
id="productquantity" required>
</div>
</div>

<div class="form-group">
<label for="productimage">Product Image</label><input type="file" 
placeholder="select Image" name="image" class="form-control"
id="productimage" required>
</div>


<div class="row">
<div class="col-md-6 text-center" style="margin-bottom:2px;" >
<button type="reset" class="btn btn-danger">Reset</button>
</div>


<div class="col-md-6 text-center">
<button type="submit" class="btn btn-success">Add Product</button>
</div>
</div>


</form>
</div>
</div>
</div>
</body>
</html>