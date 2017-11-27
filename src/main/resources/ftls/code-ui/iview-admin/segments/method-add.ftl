        go${optName?cap_first} () {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}();
<#elseif opt.mode! == "page" >
            this.$router.push({
                name: '${opt.name}_${opt.type}',
            });
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} () {
            this.optModal.${optName}.show = true;
        },
        do${optName?cap_first} () {
            let _self = this;
            util.ajax.post('${opt.exeUrl!}', this.optForm.${optName}).then(res => {
                _self.optModal.${optName}.show = false;
                _self.$Message.info(res.data.message);
            }).catch(err => {
                _self.optModal.${optName}.show = false;
            });
        },
</#if>