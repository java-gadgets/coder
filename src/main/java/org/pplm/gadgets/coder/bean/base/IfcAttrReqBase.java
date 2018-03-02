package org.pplm.gadgets.coder.bean.base;

public class IfcAttrReqBase extends Record {
    private Long id;

    private Long iid;

    private Long aid;

    private Integer sov;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIid() {
        return iid;
    }

    public void setIid(Long iid) {
        this.iid = iid;
    }

    public Long getAid() {
        return aid;
    }

    public void setAid(Long aid) {
        this.aid = aid;
    }

    public Integer getSov() {
        return sov;
    }

    public void setSov(Integer sov) {
        this.sov = sov;
    }
}