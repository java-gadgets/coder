package org.pplm.gadgets.coder.entity;

import java.util.List;


//@Entity
//@Table(name = "dict")
public class Dict extends Base {

	//	@Column(columnDefinition = "BIGINT(20)")
	private String pid;

	//	@Column(length = 128)
	private String label;
	
	//	@Column(length = 255)
	private String remark;
	
	//	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	//	@JoinColumn(name = "did")
	//	@Where(clause="delete_flag = 0")
	private List<DictItem> dictItems;
	
	public Dict() {
		super();
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<DictItem> getDictItems() {
		return dictItems;
	}

	public void setDictItems(List<DictItem> dictItems) {
		this.dictItems = dictItems;
	}
	
}
