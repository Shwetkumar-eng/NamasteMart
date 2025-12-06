package com.namastemart.service;

import java.util.List;

import com.namastemart.beans.TransactionBean;

public interface TransService {

	
	public String getUserId(String transId);
	
	
	public List<TransactionBean> getAllTransactions();
	
	public String refundTransaction(String transId);
}
