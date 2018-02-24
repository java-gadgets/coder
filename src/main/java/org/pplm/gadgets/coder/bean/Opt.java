package org.pplm.gadgets.coder.bean;

import java.util.List;

import org.pplm.gadgets.coder.bean.base.OptBase;

public class Opt extends OptBase {
	
	private Project project;
	
	private List<Attr> attrs;

    public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public List<Attr> getAttrs() {
		return attrs;
	}

	public void setAttrs(List<Attr> attrs) {
		this.attrs = attrs;
	}

}