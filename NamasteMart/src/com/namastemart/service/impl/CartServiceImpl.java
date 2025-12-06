package com.namastemart.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.namastemart.beans.CartBean;
import com.namastemart.beans.DemandBean;
import com.namastemart.beans.ProductBean;
import com.namastemart.service.CartService;
import com.namastemart.utility.DBUtil;
import com.ziclix.python.sql.connect.Connect;


public class CartServiceImpl implements CartService {

@Override
public String addProductToCart(String userId,String prodId,int prodQty) {
	String status="Failed to add into Cart";
	
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	PreparedStatement ps2=null;
	
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("select * from usercart where username=? and prodid=?");
		
		ps.setString(1,userId);
		ps.setString(2,prodId);
		
		rs=ps.executeQuery();
		
		if(rs.next()) {
			int cartQuantity =rs.getInt("quantity");
			ProductBean product=new ProductServiceImpl().getProductDetails(prodId);
			
			int availableQty=product.getProdQuantity();
			
			prodQty +=cartQuantity;
			
			if(availableQty < prodQty) {
			status =updateProductToCart(userId,prodId,availableQty);
			status="Only"+availableQty+"no of "+product.getProdName()
			+"are available in the shop so we adding only"+availableQty
			+"no of that item into your cart"+"";
			DemandBean demandBean=new DemandBean(userId,product.getProdId(),prodQty-availableQty);
			DemandServiceImpl demand=new DemandServiceImpl();
			
			boolean flag=demand.addProduct(demandBean);
			
			if(flag) {
				status +="<br> Lather we will mail you when "+product.getProdName()
				+"will we available into the stock";
			}
			}else {
				status =updateProductToCart(userId, prodId, prodQty);
			}
			
		}
	}catch(Exception e) {
		status="Error"+e.getMessage();
		e.printStackTrace();
	}
	
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	DBUtil.closeConnection(rs);
	DBUtil.closeConnection(ps2);
	
	return status;
}
@Override
public List<CartBean> getAllCartItems(String userId){
	List<CartBean> items=new ArrayList<CartBean>();
	
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("select * from usercart where username=?");
		
		ps.setString(1, userId);
		
		rs=ps.executeQuery();
		
		while(rs.next()) {
			CartBean cart=new CartBean();
			
			cart.setUserId(rs.getString("username"));
			cart.setProdId(rs.getString("prodid"));
			cart.setQuantity(Integer.parseInt(rs.getString("username")));
			
			items.add(cart);
		}
	}catch(Exception e) {
		
		e.printStackTrace();
	}
	
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	DBUtil.closeConnection(rs);
	//DBUtil.closeConnection(ps2);
	
	return items;
	
	
}
@Override
public int getCartCount(String userId){
	int count=0;
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("select sum(quantity) from usercart where username=?");
		
		ps.setString(1,userId);
		
		rs=ps.executeQuery();
		
		if(rs.next() && !rs.wasNull())
			count=rs.getInt(1);
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	DBUtil.closeConnection(rs);
	//DBUtil.closeConnection(ps2);
	
	return count;
	
}

@Override
public String removeProductFromCart(String userId,String prodId) {
	String status="Product removal failed";
	
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	PreparedStatement ps2=null;
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("select * from usercart where username=? and prodid=?");
		
		ps.setString(1,userId);
		ps.setString(2,prodId);
		
		rs=ps.executeQuery();
		
		if(rs.next()) {
			int prodQuantity=rs.getInt("quantity");
			
			prodQuantity -=1;
			
			if(prodQuantity>0){
				ps2=con.prepareStatement("update usercart set quantity=? where username=? and prodid=?");
				
				ps2.setInt(1,prodQuantity);
				
				ps2.setString(2,userId);
				
				ps2.setString(3, prodId);
				
				int k=ps2.executeUpdate();
				
				if(k>0)
					status="product successfully removed from the cart";
			}else if(prodQuantity<=0) {
				ps2=con.prepareStatement("delete from usercart where username=? and prodid=?");
				
				ps2.setString(1, userId);
				
				ps2.setString(2, prodId);
				
int k=ps2.executeUpdate();
				
				if(k>0)
					status="product successfully removed from the cart";
			}
		}else {
			status="Product not available in the cart";
		}
	}
	catch(Exception e) {
		status="Error"+e.getMessage();
		e.printStackTrace();
	}
	
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	DBUtil.closeConnection(rs);
	DBUtil.closeConnection(ps2);
	
	return status;
	
}

@Override
public boolean removeAProduct(String userId,String prodId) {
	boolean flag=false;
	
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("delete from usercart where username=? and prodid=?");
		ps.setString(1, userId);
		ps.setString(2, prodId);
		
		int k=ps.executeUpdate();
		if(k>0)
			flag=true;
		
		
	}catch(Exception e) {
		flag=false;
		e.printStackTrace();
	}
	
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	DBUtil.closeConnection(rs);
//	DBUtil.closeConnection(ps2);
	
	return false;
}
@Override
public String updateProductToCart(String userId,String prodId,int prodQty) {

	String status="failed to add into cart";
	
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	PreparedStatement ps2=null;
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("select * from usercart where username=? and prodid=?");
		
		ps.setString(1,userId);
		ps.setString(2,prodId);
		
		rs=ps.executeQuery();
		
		if(rs.next()) {
			
			if(prodQty>0){
				ps2=con.prepareStatement("update usercart set quantity=? where username=? and prodid=?");
				
				ps2.setInt(1,prodQty);
				
				ps2.setString(2,userId);
				
				ps2.setString(3, prodId);
				
				int k=ps2.executeUpdate();
				
				if(k>0)
					status="product successfully update to the cart";
			}else if(prodQty==0) {
				ps2=con.prepareStatement("delete from usercart where username=? and prodid=?");
				
				ps2.setString(1, userId);
				
				ps2.setString(2, prodId);
				
int k=ps2.executeUpdate();
				
				if(k>0)
					status="product successfully updated to the cart";
			}
		}else {
			ps2=con.prepareStatement("insert into usercart values(?,?,?)");
			ps.setString(1, userId);
			ps.setString(2, prodId);
			ps.setInt(3, prodQty);
			
			int k=ps2.executeUpdate();
			
			if(k>0)
			status="Product succesfully updated in the cart";
		}
	}
	catch(Exception e) {
		status="Error"+e.getMessage();
		e.printStackTrace();
	}
	
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	DBUtil.closeConnection(rs);
	DBUtil.closeConnection(ps2);
	
	return status;

	
}

public int getProductCount(String userId,String prodId) {
	int count=0;
	
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	try {
ps=con.prepareStatement("select sum(quantity) from usercart where username=? and prodId=?");
		
		ps.setString(1,userId);
		ps.setString(2,prodId);
		rs=ps.executeQuery();
		
		if(rs.next() && !rs.wasNull())
			count=rs.getInt(1);
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	
	return count;
		
}

@Override
public int getCartItemCount(String userId,String itemId) {
	int count =0;
	
	if(userId==null || itemId==null)
		return 0;
	Connection con=DBUtil.provideConnection();
	
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	try {
		ps=con.prepareStatement("select quantity from usercart where username=? and prodid=?");
		
		ps.setString(1, userId);
		ps.setString(2, itemId);
		
		rs=ps.executeQuery();
		
		if(rs.next() && !rs.wasNull())
			count=rs.getInt(1);
	}catch(Exception e) {
		e.printStackTrace();
	}
	return count;
}
}
