package org.pplm.gadgets.coder.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

@Entity
@Table(name = "opt", indexes = @Index(columnList = "fid"))
public class Opt extends Base {

	@Column(columnDefinition = "BIGINT(20)")
	private String fid;

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
	private String preUrl;

	@Column(length = 255)
	private String exeUrl;

	@Column(length = 255)
	private String permissionTag;

	@ManyToMany
	@JoinTable(name = "opt_attr", joinColumns = @JoinColumn(name = "oid", referencedColumnName = "ID"), inverseJoinColumns = @JoinColumn(name = "aid", referencedColumnName = "ID"))
	@Where(clause = "delete_flag = 0")
	private List<Attr> attrs;

	public Opt() {
		super();
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
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

	public String getPreUrl() {
		return preUrl;
	}

	public void setPreUrl(String preUrl) {
		this.preUrl = preUrl;
	}

	public String getExeUrl() {
		return exeUrl;
	}

	public void setExeUrl(String exeUrl) {
		this.exeUrl = exeUrl;
	}

	public List<Attr> getAttrs() {
		if (attrs != null) {
			attrs.forEach(attr -> {
				attr.setOpts(null);
			});
		}
		return attrs;
	}

	public void setAttrs(List<Attr> attrs) {
		this.attrs = attrs;
	}

	public String getPermissionTag() {
		return permissionTag;
	}

	public void setPermissionTag(String permissionTag) {
		this.permissionTag = permissionTag;
	}

}
