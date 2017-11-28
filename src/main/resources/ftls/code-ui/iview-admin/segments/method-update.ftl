        go${optName?cap_first} (id) {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}(id);
<#elseif opt.mode! == "page" >
            this.$router.push({
                name: '${opt.name!}_${opt.type!}',
                params: {
                    id: id
                },
            });
<#elseif opt.mode! == "tip" >
            let _self = this;
            this.$Modal.confirm({
                title: '${opt.label!}',
                content: '确定要${opt.label!}？',
                loading: true,
                onOk: () => {
                    let _modal = this.$Modal;
                    util.ajax.post('${opt.exeUrl!}?id=' + id).then(res => {
                        if (res.status === 200) {
                            if (res.data.code === "0") {
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

</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (id) {
            let _self = this;
            util.ajax.get('${opt.preUrl!}?id=' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.code === "0") {
                        _self.optForm.${optName!}.id = res.data.content.id;
<#list opt.attrs as attr >
<#if attr.name! != "id" >
                        _self.optForm.${optName!}.${attr.name!} = res.data.content.${attr.name!};
</#if>
</#list>
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
            util.ajax.post('${opt.exeUrl!}', this.optForm.${optName!}).then(res => {
                _self.getTableData();
                _self.optModal.${optName!}.show = false;
                _self.$Message.info(res.data.message);
            }).catch(err => {
                console.log(err);
                _self.optModal.${optName!}.show = false;
            });
        },
</#if>
