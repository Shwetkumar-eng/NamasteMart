package com.namastemart.beans;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CartBean implements Serializable {

public CartBean() {}

public String UserId;
public String prodId;
public int quantity;
public String getUserId() {
	return UserId;
}
public void setUserId(String userId) {
	UserId = userId;
}
public String getProdId() {
	return prodId;
}
public void setProdId(String prodId) {
	this.prodId = prodId;
}
public int getQuantity() {
	return quantity;
}
public void setQuantity(int quantity) {
	this.quantity = quantity;
}
public CartBean(String userId, String prodId, int quantity) {
	UserId = userId;
	this.prodId = prodId;
	this.quantity = quantity;
}


}
