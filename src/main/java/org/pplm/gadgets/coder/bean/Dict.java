package org.pplm.gadgets.coder.bean;

import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.pplm.gadgets.coder.bean.DictItem;
import org.pplm.gadgets.coder.bean.base.DictBase;

public class Dict extends DictBase {

	private List<DictItem> dictItems;

	public List<DictItem> getDictItems() {
		return dictItems;
	}

	public void setDictItems(List<DictItem> dictItems) {
		this.dictItems = dictItems;
	}

	@Override
	public String toString() {
		return dictItems.stream().map(dictItem -> StringUtils.joinWith(":", dictItem.getValue(), dictItem.getName()))
				.collect(Collectors.joining(","));
	}
	
}