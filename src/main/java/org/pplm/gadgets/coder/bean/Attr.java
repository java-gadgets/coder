package org.pplm.gadgets.coder.bean;

import java.util.List;

import org.pplm.gadgets.coder.bean.base.AttrBase;

public class Attr extends AttrBase {

	private Dict dict;
	private List<Opt> opts;
	
	public Dict getDict() {
		return dict;
	}

	public void setDict(Dict dict) {
		this.dict = dict;
	}

	public List<Opt> getOpts() {
		return opts;
	}

	public void setOpts(List<Opt> opts) {
		this.opts = opts;
	}
	
}