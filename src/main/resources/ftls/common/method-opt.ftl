<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "query">
        init () {
            this.get${opt.name?cap_first}List()
        },
        changePage (num) {
            this.page.current = num
            this.get${opt.name?cap_first}List()
        },
        do${optName?cap_first} () {
            this.page.current = 1
            this.get${opt.name?cap_first}List()
        },
        do${optName?cap_first}Clear () {
<#list opt.attrs as attr>
            this.optForm.${optName}.${attr.name} = <#if opt.type! == "query" && (attr.type! == "datetime" || attr.type! == "date")>[]<#else>''</#if>
</#list>
        },
        get${opt.name?cap_first}List () {
            let _self = this
            util.ajax.get('${opt.exeUrl!}?page=' + this.page.current + '&limit=' + this.page.size, {params: this.get${optName?cap_first}Form()}).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
                        _self.tableData = res.data.content.data
                        _self.page.total = res.data.content.total
                        _self.page.size = res.data.content.per_page
                        _self.page.current = res.data.content.current_page
                    }
                }
            }).catch(err => {
                console.log(err)
            })
        },
        get${optName?cap_first}Form () {
            return this.optForm.${optName}
        },
<#elseif opt.type! == "export">
        do${optName?cap_first} () {
            let _self = this
            util.ajax.post('${opt.exeUrl!}', this.get${optName?cap_first}Form()).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
                        window.open(res.data.content)
                    } else {
                        _self.$Message.error(res.data.message)
                    }
                }
            }).catch(err => {
                console.log(err)
            })
        },
        get${optName?cap_first}Form () {
        },
<#elseif opt.type! == "update" || opt.type! == "add" || opt.type! == "detail" || opt.type! == "delete">
        go${optName?cap_first} (<#if opt.type! != "add">id</#if>) {
<#if opt.mode! == "modal">
            this.showModal${optName?cap_first}(<#if opt.type! != "add">id</#if>)
<#elseif opt.mode! == "page">
            this.$router.push({
                name: '${opt.name}_${opt.type}',
<#if opt.type! != "add">
                params: {
                    id: id
                }
</#if>
            })
<#elseif opt.mode! == "tip" || opt.type! == "delete">
            let _self = this
            this.$Modal.confirm({
                title: '${opt.label}',
                content: '确定要${opt.label}？',
                loading: true,
                onOk: () => {
                    let _modal = this.$Modal
                    util.ajax.post('${opt.exeUrl!}?id=' + id).then(res => {
                        if (res.status === 200) {
                            if (res.data.code === "0") {
                                _self.$Message.info(res.data.message)
                            } else {
                                _self.$Message.error(res.data.message)
                            }
                        }
                        _self.afterDo${optName?cap_first}(res)
                        _modal.remove()
                    }).catch(function (err) {
                        console.log(err)
                        _self.afterDo${optName?cap_first}(err)
                        _modal.remove()
                    })
                }
            })
</#if>
        },
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "update")>
        do${optName?cap_first} () {
            let _self = this
            util.ajax.post('${opt.exeUrl!}', this.optForm.${optName}).then(function (res) {
                _self.optModal.${optName}.show = false
                _self.$Message.info(res.data.message)
                _self.afterDo${optName?cap_first}()
              }).catch(function (err) {
                _self.optModal.${optName}.show = false
              })
        },
</#if>
<#if opt.mode! == "tip" || opt.mode! == "switch" || opt.type! == "delete" || (opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "update"))>
        afterDo${optName?cap_first} (res) {
        },
</#if>
</#if>
<#if opt.mode! == "modal" && (opt.type! == "detail" || opt.type! == "update" || opt.type! == "add")>
        showModal${optName?cap_first} (<#if opt.type! == "update" || opt.type! == "detail">id</#if>) {
<#if opt.type! == "update" || opt.type! == "detail">
            let _self = this
            util.ajax.get('${opt.exeUrl!}?id=' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
<#list opt.attrs as attr>
                        _self.optForm.${optName}.${attr.name} = res.data.content.${attr.name}
</#list>
                    }
                }
                this.optModal.${optName}.loading = false
            }).catch(err => {
                console.log(err)
                this.optModal.${optName}.loading = false
            })
</#if>
            this.optModal.${optName}.show = true
        },
</#if>
</#list>