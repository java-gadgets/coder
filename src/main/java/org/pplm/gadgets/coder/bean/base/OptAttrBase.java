package org.pplm.gadgets.coder.bean.base;

public class OptAttrBase extends Record {

	public OptAttrBase() {
		super();
	}

	public OptAttrBase(Long aid, Long oid, Integer sov) {
		super();
		this.aid = aid;
		this.oid = oid;
		this.sov = sov;
	}

	private Long id;

    private Long aid;

    private Long oid;

    private Integer sov;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getAid() {
        return aid;
    }

    public void setAid(Long aid) {
        this.aid = aid;
    }

    public Long getOid() {
        return oid;
    }

    public void setOid(Long oid) {
        this.oid = oid;
    }

    public Integer getSov() {
        return sov;
    }

    public void setSov(Integer sov) {
        this.sov = sov;
    }
}