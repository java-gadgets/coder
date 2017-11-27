        do${optName?cap_first} () {
            this.page.current = 1;
            this.refresh();
        },
        do${optName?cap_first}Clear () {
<#list opt.attrs as attr>
            this.optForm.${optName}.${attr.name} = <#if opt.type! == "query" && (attr.type! == "datetime" || attr.type! == "date")>[]<#else>''</#if>;
</#list>
            this.do${optName?cap_first}();
        },
        get${optName?cap_first}Form () {
            return this.optForm.${optName};
        },
        get${opt.name?cap_first}List () {
            let _self = this;
            util.ajax.get('${opt.exeUrl!}?page=' + (this.page.current - 1) + '&size=' + this.page.size, {params: this.get${optName?cap_first}Form()}).then(res => {
                if (res.status === 200) {
                    if (res.data.code === "0") {
						_self.tableData = res.data.content.content;
						_self.page.total = res.data.content.totalElements;
						_self.page.size = res.data.content.size;
						_self.page.current = res.data.content.number + 1;
                    } else {
                        _self.$Message.error(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            })
        },
