package org.pplm.gadgets.coder.entity;

import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "opt_attr", indexes = { @Index(columnList = "oid"), @Index(columnList = "aid") })
public class OptAttr extends Base {
	private Long oid;
	private Long aid;
	
	public OptAttr() {
		super();
	}

	public OptAttr(Long oid, Long aid) {
		super();
		this.oid = oid;
		this.aid = aid;
	}

	public Long getOid() {
		return oid;
	}

	public void setOid(Long oid) {
		this.oid = oid;
	}

	public Long getAid() {
		return aid;
	}

	public void setAid(Long aid) {
		this.aid = aid;
	}
	
}
