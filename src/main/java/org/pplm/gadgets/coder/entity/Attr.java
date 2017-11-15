package org.pplm.gadgets.coder.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "attr", indexes = @Index(columnList = "fid"))
public class Attr extends Base {
	private Long fid;
	@Column(length = 128)
	private String label;
	@Column(length = 128)
	private String name;
	@Column(length = 32)
	private String type;
	@Column(length = 5)
	private Integer length;
	@Column(length = 1)
	private Integer precise;
	private String defaultValue;

	public Attr() {
		super();
	}

	public Long getFid() {
		return fid;
	}

	public void setFid(Long fid) {
		this.fid = fid;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getPrecise() {
		return precise;
	}

	public void setPrecise(Integer precise) {
		this.precise = precise;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

}
