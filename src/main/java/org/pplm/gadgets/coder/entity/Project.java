package org.pplm.gadgets.coder.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "project")
public class Project extends Base {

	@Column(length = 128)
	private String label;

	@Column(length = 128)
	private String name;
	
	@Column(length = 255)
	private String remark;

	@JsonIgnore
	@OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	@JoinColumn(name="pid")
	@Where(clause="delete_flag = 0")
	private List<Dict> dicts;
	
	@JsonIgnore
	@OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<Dict> getDicts() {
		return dicts;
	}

	public void setDicts(List<Dict> dicts) {
		this.dicts = dicts;
	}

	public List<Func> getFuncs() {
		return funcs;
	}

	public void setFuncs(List<Func> funcs) {
		this.funcs = funcs;
	}	
	
}
