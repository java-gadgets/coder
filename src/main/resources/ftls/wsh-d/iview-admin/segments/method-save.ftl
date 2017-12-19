        go${optName?cap_first} (id) {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}(id);
<#elseif opt.mode! == "page" >
            if (id) {
	            this.$router.push({
	                name: '${opt.name!}_${opt.type!}_update',
	                params: {
	                    id: id
	                },
	            });
            } else {
            	this.$router.push({
	                name: '${opt.name!}_${opt.type!}_add',
	            });
            }
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (id) {
	        if (id) {
	            this.optModal.${optName!}.title = '编辑${opt.label!}';
	            let _self = this;
	            util.ajax.get('${opt.preUrl!}?id=' + id).then(res => {
	                if (res.status === 200) {
	                    if (res.data.<#include "../spec/res-success.ftl" />) {
	                        _self.prepare${optName?cap_first}Form(res.data.content);
	                    }
	                }
	                this.optModal.${optName!}.loading = false;
	            }).catch(err => {
	                this.optModal.${optName!}.loading = false;
	                console.log(err);
	            });
	        } else {
	            this.optModal.${optName!}.title = '添加${opt.label!}';
	        }
            this.optModal.${optName!}.show = true;
        },
        do${optName?cap_first} () {
            let _self = this;
            this.$refs.${optName!}Form.validate((valid) => {
                if (valid) {
                    util.ajax.post('${opt.exeUrl!}<#if relaAttr! != "" >?${relaAttr}=' + this.optForm.${relaAttr}<#else>'</#if>, this.process${optName?cap_first}Form()).then(res => {
                        _self.getTableData();
                        _self.clear${optName?cap_first}Form ();
                        _self.optModal.${optName!}.show = false;
                        _self.$Message.info(res.data.message);
                    }).catch(err => {
                        console.log(err);
                        _self.optModal.${optName!}.show = false;
                    });
                } else {
                    _self.optModal.${optName!}.okLoading = false;
                    _self.$nextTick(() => _self.optModal.${optName!}.okLoading = true);
                }
            });
        },
        prepare${optName?cap_first}Form (form) {
            this.optForm.${optName!}.id = form.id;
<#list opt.attrs as attr>
<#if attr.name! != "id" >
            this.optForm.${optName!}.${attr.name!} = form.${attr.name!}.toString();
</#if>
</#list>        
        },
        process${optName?cap_first}Form () {
            let form = {
                id: this.optForm.${optName!}.id,
<#list opt.attrs as attr>
<#if attr.name! != "id" >
                ${attr.name!}: this.optForm.${optName!}.${attr.name!},
</#if>
</#list>
            };
            return form;
        },
        clear${optName?cap_first}Form () {
            this.optForm.${optName!}.id = '';
<#list opt.attrs as attr>
<#if attr.name! != "id" >
<#include "comm-form-expr-item.ftl" />
</#if>
</#list>        
        },
</#if>
