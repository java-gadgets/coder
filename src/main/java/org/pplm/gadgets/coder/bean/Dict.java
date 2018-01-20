package org.pplm.gadgets.coder.bean;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.pplm.gadgets.coder.bean.DictItem;

public class Dict extends Record {

	private List<DictItem> dictItems;

	public List<DictItem> getDictItems() {
		return dictItems;
	}

	public void setDictItems(List<DictItem> dictItems) {
		this.dictItems = dictItems;
	}

	private Long id;

	private Integer deleteFlag;

	private Long pid;

	private String name;

	private String remark;

	private Long creatorId;

	private Date createDate;

	private Long updatorId;

	private Date updateDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public Long getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(Long creatorId) {
		this.creatorId = creatorId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getUpdatorId() {
		return updatorId;
	}

	public void setUpdatorId(Long updatorId) {
		this.updatorId = updatorId;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return dictItems.stream().map(dictItem -> StringUtils.joinWith(":", dictItem.getValue(), dictItem.getName()))
				.collect(Collectors.joining(","));
	}
	
}