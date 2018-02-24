package org.pplm.gadgets.coder.bean;

import java.util.List;

import org.pplm.gadgets.coder.bean.base.FuncBase;

public class Func extends FuncBase {

	private Project project;
	
	private List<Opt> opts;
	
	private List<Attr> attrs;

    public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public List<Opt> getOpts() {
		return opts;
	}

	public void setOpts(List<Opt> opts) {
		this.opts = opts;
	}

	public List<Attr> getAttrs() {
		return attrs;
	}

	public void setAttrs(List<Attr> attrs) {
		this.attrs = attrs;
	}

}