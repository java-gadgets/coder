        go${optName?cap_first} (id) {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}(id);
<#elseif opt.mode! == "page" >
            this.$router.push({
                name: '${opt.code!}_${opt.type!}',
                params: {
                    id: id
                },
            });
<#elseif opt.mode! == "tip" >
            let _self = this;
            this.$Modal.confirm({
                title: '${opt.name!}',
                content: '确定要${opt.name!}？',
                loading: true,
                onOk: () => {
                    let _modal = this.$Modal;
                    util.ajax.post('${opt.exeUrl!}?id=' + id).then(res => {
                        if (res.status === 200) {
                            if (res.data.<#include "../spec/" + project.code + "/res-success.ftl" />) {
                                _self.getTableData();
                                _self.$Message.info(res.data.message);
                            } else {
                                _self.$Message.error(res.data.message);
                            }
                        }
                        _modal.remove();
                    }).catch(err => {
                        _modal.remove();
                        console.log(err);
                    });
                }
            });
<#elseif opt.mode! == "switch" >
            let _self = this;
            util.ajax.post('${opt.exeUrl!}/' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "../spec/" + project.code + "/res-success.ftl" />) {
                        _self.getTableData();
                        _self.$Message.info(res.data.message);
                    } else {
                        _self.$Message.error(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            });
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (id) {
            let _self = this;
            util.ajax.get('${opt.preUrl!}?id=' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "../spec/" + project.code + "/res-success.ftl" />) {
                        _self.prepare${optName?cap_first}Form(res.data.content);
                    }
                }
                this.optModal.${optName!}.loading = false;
            }).catch(err => {
                this.optModal.${optName!}.loading = false;
                console.log(err);
            })
            this.optModal.${optName!}.show = true
        },
        do${optName?cap_first} () {
            let _self = this;
            this.$refs.${optName!}Form.validate((valid) => {
                if (valid) {
		            util.ajax.post('${opt.exeUrl!}', this.process${optName?cap_first}Form()).then(res => {
		                _self.getTableData();
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
<#if attr.code! != "id" >
            this.optForm.${optName!}.${attr.code!} = form.${attr.code!}.toString();
</#if>
</#list>        
        },
        process${optName?cap_first}Form () {
            let form = {
<#list opt.attrs as attr>
<#if attr.code! != "id" >
                ${attr.code!}: this.optForm.${optName!}.${attr.code!},
</#if>
</#list>
            };
            return form;
        },
        cancel${optName?cap_first} () {
            this.$refs.${optName}Form.resetFields();
        },
</#if>
