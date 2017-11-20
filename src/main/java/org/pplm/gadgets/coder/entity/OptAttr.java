package org.pplm.gadgets.coder.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "opt_attr")
public class OptAttr extends Base {
	
	@Column(columnDefinition = "BIGINT(20)")
	private String oid;
	
	@Column(columnDefinition = "BIGINT(20)")
	private String aid;
	
	public OptAttr() {
		super();
	}

	public OptAttr(String oid, String aid) {
		super();
		this.oid = oid;
		this.aid = aid;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

}
