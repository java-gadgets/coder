package org.pplm.gadgets.coder.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "opt", indexes = @Index(columnList = "fid"))
public class Opt extends Base {

	private Long fid;

	@Column(length = 128)
	private String label;

	@Column(length = 128)
	private String name;
	
	/** save(add and udpdate), add, update, delete, detail, list, query **/
	@Column(length = 16)
	private String type;

	/** page, modal **/
	@Column(length = 16)
	private String mode;

	@Column(length = 255)
	private String url;

	@ManyToMany
	@JoinTable(
		name = "opt_attr",
		joinColumns = @JoinColumn(name = "oid", referencedColumnName = "ID"), 
		inverseJoinColumns = @JoinColumn(name = "aid", referencedColumnName = "ID"))
	private List<Attr> attrs;

	public Opt() {
		super();
	}

	public Long getFid() {
		return fid;
	}

	public void setFid(Long fid) {
		this.fid = fid;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<Attr> getAttrs() {
		return attrs;
	}

	public void setAttrs(List<Attr> attrs) {
		this.attrs = attrs;
	}

}