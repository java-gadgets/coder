package org.pplm.gadgets.coder.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

@Entity(name = "func")
@Inheritance
public class Func extends Base {

	private String label;
	private String name;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name="fid")
	private List<Attr> attrs;

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
	
}
