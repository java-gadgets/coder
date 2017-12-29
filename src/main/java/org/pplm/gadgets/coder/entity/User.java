package org.pplm.gadgets.coder.entity;

//@Entity
//@Table(name = "user", indexes = //@Index(columnList = "username"))
public class User extends Base {

	//@Column(length = 128)
	private String username;
	
	//@Column(length = 128)
	private String password;
	
	//@Column(columnDefinition = "INT(1) DEFAULT 1 COMMENT '用户状态：0停用，1正常'")
	private String status;
	
	//@Transient
	private String token;
	
	public User() {
		super();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
