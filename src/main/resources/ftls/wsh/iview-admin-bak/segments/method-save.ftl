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
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} (id) {
	        if (id) {
	            this.optModal.${optName!}.title = '编辑${opt.label!}';
	            let _self = this;
	            util.ajax.get('${opt.preUrl!}?id=' + id).then(res => {
	                if (res.status === 200) {
	                    if (res.data.result === 1) {
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
	            });
	        } else {
	            this.optModal.${optName!}.title = '添加${opt.label!}';
	        }
            this.optModal.${optName!}.show = true;
        },
        do${optName?cap_first} () {
            let _self = this;
            util.ajax.post('${opt.exeUrl!}<#if relaAttr! != "" >?${relaAttr}=' + this.optForm.${relaAttr}<#else>'</#if>, this.optForm.${optName!}).then(res => {
                _self.getTableData();
                _self.clear${optName?cap_first}Form ();
                _self.optModal.${optName!}.show = false;
                _self.$Message.info(res.data.message);
            }).catch(err => {
                console.log(err);
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
