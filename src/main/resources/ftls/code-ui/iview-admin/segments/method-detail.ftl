        go${optName?cap_first} () {
<#if opt.mode! == "modal">
            this.showModal${optName?cap_first}(id);
<#elseif opt.mode! == "page">
            this.$router.push({
                name: '${opt.name}_${opt.type}',
                params: {
                    id: id
                },
            });
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (id) {
            let _self = this;
            util.ajax.get('${opt.exeUrl!}?id=' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.code === "0") {
<#list opt.attrs as attr>
                        _self.optForm.${optName}.${attr.name} = res.data.content.${attr.name};
</#list>
                    }
                }
                this.optModal.${optName}.loading = false;
            }).catch(err => {
                this.optModal.${optName}.loading = false;
                console.log(err);
            })
</#if>
            this.optModal.${optName}.show = true;
        },
</#if>