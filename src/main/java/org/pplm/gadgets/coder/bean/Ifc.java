package org.pplm.gadgets.coder.bean;

import java.util.List;

import org.pplm.gadgets.coder.bean.base.IfcBase;

public class Ifc extends IfcBase {
	
	private List<IfcAttrReq> attrReqs;
	
	private List<IfcAttrRes> attrRess;

	public List<IfcAttrReq> getAttrReqs() {
		return attrReqs;
	}

	public void setAttrReqs(List<IfcAttrReq> attrReqs) {
		this.attrReqs = attrReqs;
	}

	public List<IfcAttrRes> getAttrRess() {
		return attrRess;
	}

	public void setAttrRess(List<IfcAttrRes> attrRess) {
		this.attrRess = attrRess;
	}
	
}
