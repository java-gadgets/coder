        go${optName?cap_first} (id) {
<#if opt.mode! == "modal">
            this.showModal${optName?cap_first}(id);
<#elseif opt.mode! == "page">
            this.$router.push({
                name: '<#if opt.preUrl! == "" >${opt.name!}_${opt.type!}<#else>${opt.preUrl!}</#if>',
                params: {
                    id: id
                },
            });
<#else>
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (id) {
            let _self = this;
            util.ajax.get('${opt.exeUrl!}?id=' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
<#list opt.attrs as attr>
                        _self.optForm.${optName!}.${attr.name!} = res.data.content.${attr.name!};
</#list>
                    }
                }
                this.optModal.${optName!}.loading = false;
            }).catch(err => {
                this.optModal.${optName!}.loading = false;
                console.log(err);
            });
            this.optModal.${optName!}.show = true;
        },
</#if>
