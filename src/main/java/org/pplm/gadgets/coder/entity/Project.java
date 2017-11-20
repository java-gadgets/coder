package org.pplm.gadgets.coder.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

@Entity
@Table(name = "project")
public class Project extends Base {

	@Column(length = 128)
	private String label;
	@Column(length = 255)
	private String remark;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name="pid")
	@Where(clause="delete_flag = 0")
	private List<Dict> dicts;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name="pid")
	@Where(clause="delete_flag = 0")
	private List<Func> funcs;
	
	public Project() {
		super();
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
	
}
