package org.pplm.gadgets.coder.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "func")
public class Func extends Base {

	private String label;
	private String name;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name="fid")
	private List<Attr> attrs;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name="fid")
	private List<Opt> opts;

	public Func() {
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
	
}
