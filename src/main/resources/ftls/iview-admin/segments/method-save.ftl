        go${optName?cap_first} (row) {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}(row);
<#elseif opt.mode! == "page" >
            if (row) {
	            this.$router.push({
	                name: '${opt.code!}_${opt.type!}_update',
	                params: {
	                    id: row.id
	                },
	            });
            } else {
            	this.$router.push({
	                name: '${opt.code!}_${opt.type!}_add',
	            });
            }
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (row) {
	        if (row) {
	            this.optModal.${optName!}.title = '编辑${opt.name!}';
<#if opt.preUrl! == "" >
            this.prepare${optName?cap_first}Form(row);
            this.optModal.${optName!}.loading = false;
<#else>
	            let _self = this;
	            util.ajax.get('${opt.preUrl!}?id=' + row.id).then(res => {
	                if (res.status === 200) {
	                    if (res.data.<#include "../spec/" + project.custom + "/res-success.ftl" />) {
	                        _self.prepare${optName?cap_first}Form(res.data.content);
	                    }
	                }
	                this.optModal.${optName!}.loading = false;
	            }).catch(err => {
	                this.optModal.${optName!}.loading = false;
	                console.log(err);
	            });
</#if>
	        } else {
	            this.clear${optName?cap_first}Form ();
                this.optModal.${optName!}.loading = false;
	            this.optModal.${optName!}.title = '添加${opt.name!}';
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
        prepare${optName?cap_first}Form (data) {
            this.optForm.${optName!}.id = data.id;
<#list opt.attrs as attr>
<#if attr.code! != "id" >
            this.optForm.${optName!}.${attr.code!} = data.${attr.code!}.toString();
</#if>
</#list>        
        },
        process${optName?cap_first}Form () {
            let form = {
                id: this.optForm.${optName!}.id,
<#list opt.attrs as attr>
<#if attr.code! != "id" >
                ${attr.code!}: this.optForm.${optName!}.${attr.code!},
</#if>
</#list>
            };
            return form;
        },
        clear${optName?cap_first}Form () {
            this.optForm.${optName!}.id = '';
<#list opt.attrs as attr>
<#if attr.code! != "id" >
<#include "comm-form-expr-item.ftl" />
</#if>
</#list>
            this.$refs.${optName!}Form.resetFields();
        },
        cancel${optName?cap_first} () {
            this.$refs.${optName}Form.resetFields();
        },
</#if>
