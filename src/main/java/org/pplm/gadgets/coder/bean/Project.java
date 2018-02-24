package org.pplm.gadgets.coder.bean;

import java.util.List;

import org.pplm.gadgets.coder.bean.base.ProjectBase;

public class Project extends ProjectBase {
	
	private List<Func> funcs;
	
    public List<Func> getFuncs() {
		return funcs;
	}

	public void setFuncs(List<Func> funcs) {
		this.funcs = funcs;
	}

}