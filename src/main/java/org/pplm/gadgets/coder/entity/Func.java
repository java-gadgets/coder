package org.pplm.gadgets.coder.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

//@Entity
//@Table(name = "func")
public class Func extends Base {

	//	@Column(length = 128)
	private String label;
	//	@Column(length = 128)
	private String name;
	//	@Column(length = 128)
	private String relaAttr;
	
	//	@Column(length = 255)
	private String permissionTag;
	
	//	@Column(length = 255)
	private String remark;
	
	//	@ManyToOne(targetEntity = Project.class, fetch = FetchType.LAZY)
	private Project project;
	
	//	@JsonIgnore
	//	@OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	//	@JoinColumn(name="fid")
	//	@Where(clause="delete_flag = 0")
	private List<Attr> attrs;
	
	//	@JsonIgnore
	//	@OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	//	@JoinColumn(name="fid")
	//	@Where(clause="delete_flag = 0")
	private List<Opt> opts;

	public Func() {
		super();
	}

	public Project getProject() {
		project.setFuncs(null);
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
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

	public String getRelaAttr() {
		return relaAttr;
	}

	public void setRelaAttr(String relaAttr) {
		this.relaAttr = relaAttr;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<Attr> getAttrs() {
		return attrs;
	}

	public void setAttrs(List<Attr> attrs) {
		this.attrs = attrs;
	}

	public List<Opt> getOpts() {
		return opts;
	}

	public void setOpts(List<Opt> opts) {
		this.opts = opts;
	}

	public String getPermissionTag() {
		return permissionTag;
	}

	public void setPermissionTag(String permissionTag) {
		this.permissionTag = permissionTag;
	}

}
