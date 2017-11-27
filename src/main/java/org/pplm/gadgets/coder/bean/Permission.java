package org.pplm.gadgets.coder.bean;

import java.util.ArrayList;
import java.util.List;

public class Permission {
	
	private String isAdmin;
	private List<String> meunPermissions = new ArrayList<>();
	private List<String> optPermissions = new ArrayList<>();
	
	public Permission() {
		super();
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public List<String> getMeunPermissions() {
		return meunPermissions;
	}

	public void setMeunPermissions(List<String> meunPermissions) {
		this.meunPermissions = meunPermissions;
	}

	public List<String> getOptPermissions() {
		return optPermissions;
	}

	public void setOptPermissions(List<String> optPermissions) {
		this.optPermissions = optPermissions;
	}
	
}
