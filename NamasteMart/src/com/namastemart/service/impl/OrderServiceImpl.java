package com.namastemart.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;

import com.namastemart.beans.CartBean;
import com.namastemart.beans.OrderBean;
import com.namastemart.beans.TransactionBean;
import com.namastemart.service.OrderService;

import com.namastemart.utility.DBUtil;
import com.namastemart.utility.MailMessage;

public class OrderServiceImpl implements OrderService {

	
	@Override
	public String paymentSuccess(String userName,double paidAmount) {
		String status="Order placed failed";
		
		List<CartBean> cartItems=new CartServiceImpl().getAllCartItems(userName);
		
		if(cartItems.size()==0)
			return status;
		
		TransactionBean transaction=new TransactionBean(userName, paidAmount);
		boolean ordered=false;
		
		String transactionId=transaction.getTransactionId();
		
		for(CartBean item: cartItems) {
			double amount=new ProductServiceImpl().getProductPrice(item.getProdId())*item.getQuantity();
			OrderBean order=new OrderBean(transactionId,item.getProdId(),item.getQuantity(),amount);
			
			
			ordered=addOrder(order);
			if(!ordered) break;
			
			else ordered=new CartServiceImpl().removeAProduct(item.getUserId(), item.getProdId());
			
			if(!ordered) break;
			
			else ordered=new ProductServiceImpl().sellNProduct(item.getProdId(),item.getQuantity());
			
			if(!ordered) break;
		}
		if(ordered) {
			ordered=addTransaction(transaction);
			if(ordered) {
				MailMessage.transactionSuccess(userName,new UserServiceImpl().getFName(userName),
						transaction.getTransactionId(),transaction.getTransAmount());
				
				status="Ordered placed successfully";
			}
		}
		return status;
	} 
	
	@Override
	public boolean addOrder(OrderBean order) {
		boolean flag=false;
		Connection con=DBUtil.provideConnection();
		PreparedStatement ps=null;
		
		try {
			ps=con.prepareStatement("insert into orders(orderid,prodid,quantity,amount,shipped,order_date)value(?,?,?,?,?,?)");
			
			ps.setString(1,order.getTransactionId());
			ps.setString(2, order.getProductId());
			ps.setInt(3, order.getQuantity());
			ps.setDouble(4, order.getAmount());
			ps.setInt(5, 0);
			ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			
			int k=ps.executeUpdate();
			if(k>0) {
				flag=true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(ps !=null)ps.close();
				if(con !=null)con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return flag;
	}
	
	@Override
	public boolean addTransaction(TransactionBean transaction) {
		
		boolean flag=false;
		Connection con=DBUtil.provideConnection();
		PreparedStatement ps=null;
		
		try {
			ps=con.prepareStatement("insert into transactions(transid,username,time,amount,status)value(?,?,?,?,?)");
			
			ps.setString(1,transaction.getTransactionId());
			ps.setString(2, transaction.getUserName());
			ps.setTimestamp(3, transaction.getTransDateTime());
			ps.setDouble(4, transaction.getTransAmount());
			ps.setString(5, "completed");
			//ps.set(6, new Timestamp(System.currentTimeMillis()));
			
			int k=ps.executeUpdate();
			if(k>0) {
				flag=true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(ps !=null)ps.close();
				if(con !=null)con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return flag;
		
	}
	
	@Override
	public int countSoIdItem(String prodId) {
		int count=0;
		Connection con=DBUtil.provideConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
ps=con.prepareStatement("select sum(quantity) from orders where prodid=?");
			
			ps.setString(1,prodId);
			//ps.set(6, new Timestamp(System.currentTimeMillis()));
			rs=ps.executeQuery();
			
			if(rs.next()) {
				rs.getInt(1);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
