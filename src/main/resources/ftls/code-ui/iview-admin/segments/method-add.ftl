        go${optName?cap_first} () {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}();
<#elseif opt.mode! == "page" >
            this.$router.push({
                name: '${opt.name!}_${opt.type!}',
            });
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} () {
            this.optModal.${optName!}.show = true;
        },
        do${optName?cap_first} () {
            let _self = this;
            util.ajax.post('${opt.exeUrl!}', this.optForm.${optName!}).then(res => {
                _self.getTableData();
                _self.clear${optName?cap_first}Form ();
                _self.optModal.${optName!}.show = false;
                _self.$Message.info(res.data.message);
            }).catch(err => {
                _self.optModal.${optName!}.show = false;
            });
        },
        clear${optName?cap_first}Form () {
            this.optForm.${optName!}.id = '';
<#list opt.attrs as attr>
<#if attr.name! != "id" >
            this.optForm.${optName!}.${attr.name} = '${attr.defaultValue!}';
</#if>
</#list>        
        },
</#if>
