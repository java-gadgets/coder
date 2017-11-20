package org.pplm.gadgets.coder.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "dict_item")
public class DictItem extends Base {
	
	@Column(columnDefinition = "BIGINT(20)")
	private String did;
	@Column(length = 128)
	private String label;
	@Column(length = 128)
	private String value;

	public DictItem() {
		super();
	}

	public String getDid() {
		return did;
	}

	public void setDid(String did) {
		this.did = did;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
}
