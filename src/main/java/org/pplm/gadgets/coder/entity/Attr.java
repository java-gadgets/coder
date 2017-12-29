package org.pplm.gadgets.coder.entity;

import java.util.List;

//@Entity
//@Table(name = "attr")
public class Attr extends Base {

	//@Column(columnDefinition = "BIGINT(20)")
	private String fid;

	//@Column(length = 128)
	private String label;

	//@Column(length = 128)
	private String name;

	//@Column(length = 32)
	private String type;
	
	//@Column(columnDefinition = "INT(1) DEFAULT 0")
	private String required;

	//@Column(length = 5)
	private Integer length;

	//@Column(length = 1)
	private Integer precise;

	//@Column(length = 128)
	private String defaultValue;

	//@Column(length = 255)
	private String remark;
	
	/*@ManyToMany
	@JoinTable(
		name = "opt_attr",
		joinColumns = @JoinColumn(name = "aid", referencedColumnName = "ID"), 
		inverseJoinColumns = @JoinColumn(name = "oid", referencedColumnName = "ID"))
	@Where(clause="delete_flag = 0")*/
	private List<Opt> opts;
	
	/*@OneToOne
	@JoinColumn(name = "did")*/
	private Dict dict;

	public Attr() {
		super();
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
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

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<Opt> getOpts() {
		if (opts != null) {
			opts.forEach(opt -> {
				opt.setAttrs(null);
			});
		}
		return opts;
	}

	public void setOpts(List<Opt> opts) {
		this.opts = opts;
	}

	public Dict getDict() {
		return dict;
	}

	public void setDict(Dict dict) {
		this.dict = dict;
	}

}
