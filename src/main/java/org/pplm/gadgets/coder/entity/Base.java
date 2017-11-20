package org.pplm.gadgets.coder.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

@MappedSuperclass
public class Base {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(columnDefinition = "BIGINT(20)")
	private String id;
	
	@Column(length = 1, columnDefinition="INT(1) default 0")
	private Integer deleteFlag = 0;
	
	@Column(columnDefinition = "BIGINT(20)")
	private String creatorId;

	private Date createDate;
	
	@Column(columnDefinition = "BIGINT(20)")
	private String updatorId;
	
	@OrderBy("desc")
	private Date updateDate;

	public Base() {
		super();
	}

	@PrePersist
    public void prePersist(){
		this.createDate = new Date();
		this.updateDate = this.createDate;
    }

    @PreUpdate
    public void preUpdate(){
        this.updateDate = new Date();                
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUpdatorId() {
		return updatorId;
	}

	public void setUpdatorId(String updatorId) {
		this.updatorId = updatorId;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

}
