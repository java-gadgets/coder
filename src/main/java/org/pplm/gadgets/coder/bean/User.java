package org.pplm.gadgets.coder.bean;

import org.pplm.gadgets.coder.bean.base.UserBase;
import org.springframework.data.annotation.Transient;

public class User extends UserBase {
	
    @Transient
    private String token;
    
    public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

}