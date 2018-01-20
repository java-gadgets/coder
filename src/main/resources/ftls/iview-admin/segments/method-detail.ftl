        go${optName?cap_first} (row) {
<#if opt.mode! == "modal">
            this.showModal${optName?cap_first}(row);
<#elseif opt.mode! == "page">
            this.$router.push({
                name: '<#if opt.preUrl! == "" >${opt.code!}_${opt.type!}<#else>${opt.preUrl!}</#if>',
                params: {
                    id: row.id
                },
            });
<#else>
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (row) {
            let _self = this;
            util.ajax.get('${opt.exeUrl!}?id=' + row.id).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "spec/res-success.ftl" />) {
<#list opt.attrs as attr>
                        _self.optForm.${optName!}.${attr.code!} = res.data.content.${attr.code!};
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
