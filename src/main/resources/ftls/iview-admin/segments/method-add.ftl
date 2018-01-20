        go${optName?cap_first} () {
<#if opt.mode! == "modal" >
            this.showModal${optName?cap_first}();
<#elseif opt.mode! == "page" >
            this.$router.push({
                name: '${opt.code!}_${opt.type!}',
            });
</#if>
        },
<#if opt.mode! == "modal" >
        showModal${optName?cap_first} () {
            this.optModal.${optName!}.show = true;
        },
        do${optName?cap_first} () {
            let _self = this;
            this.$refs.${optName!}Form.validate((valid) => {
                if (valid) {
		            util.ajax.post('${opt.exeUrl!}', this.process${optName?cap_first}Form()).then(res => {
		                _self.getTableData();
		                _self.clear${optName?cap_first}Form ();
		                _self.optModal.${optName!}.show = false;
		                _self.$Message.info(res.data.message);
		            }).catch(err => {
		                _self.optModal.${optName!}.show = false;
		            });
                } else {
                    _self.optModal.${optName!}.okLoading = false;
                    _self.$nextTick(() => _self.optModal.${optName!}.okLoading = true);
                }
		    });
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
        clear${optName?cap_first}Form () {
            this.optForm.${optName!}.id = '';
<#list opt.attrs as attr>
<#if attr.code! != "id" >
            this.optForm.${optName!}.${attr.code} = '${attr.defaultValue!}';
</#if>
</#list>
            this.$refs.${optName}Form.resetFields();
        },
        cancel${optName?cap_first} () {
            this.$refs.${optName}Form.resetFields();
        },
</#if>
