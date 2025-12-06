<%@page language="java"contentType="text/html;charset=UTF-8"%>
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

.product-container{
	background-color:#f1cdf6;
	min-height:100vh;
	padding-bottom:20px;
}

.product-name{
font-weight:bold;
}

.thumbnail{
height:350px;
padding:15px;
margin-bottom:30px;
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

<%@include file="adminheader.jsp"%>

<div class="content">
<div class="text-center"style="color:black; font-size:14px; font-weight:bold;">
<%
String userName=(String)session.getAttribute("username");
String password=(String)session.getAttribute("password");
if(userName==null||password==null){
	response.sendRedirect("login.jsp?message=session Expired,Login Again");
}

ProductServiceImpl prodDao=new ProductServiceImpl();
List<ProductBean> products=new ArrayList<ProductBean>();

String search=request.getParameter("search");
String type=request.getParameter("type");
String message="All Products";
if(search !=null){
	products=prodDao.searchAllProducts(search);
	message="showing result for'"+search+"'";
}
else if(type !=null){
	products=prodDao.getAllProductsByType(type);
	message="showing result for'"+type+"'";
}
else{
	products=prodDao.getAllProducts();
}

if(products.isEmpty()){
	message="No item found for the search '"+(search !=null?search:type)+"'";
	products=prodDao.getAllProducts();
}

%>
<%=message%>
</div>

<div class="container product-container">
<div class="row text-center">
<%for(ProductBean product:products){%>
<div class="col-sm-4">
<div class="thumbnail">
<img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product" style="height:150px;
max-width:180px;">
<p class="productname"><%=product.getProdName()%></p>

<p class="productinfo"><%=product.getProdInfo()%></p>
<p class="price"><%=product.getProdPrice()%></p>
<form method="post">
<button type="submit" formaction="./RemoveProductSrv.jsp?prodid=<%=product.getProdId()%>"
class="btn btn-danger">Remove Product</button>

<button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>"
class="btn btn-success">Update Product</button>
</form>
</div>
</div>
<%}%>
</div>
</div>
</div>

</body>
</html>