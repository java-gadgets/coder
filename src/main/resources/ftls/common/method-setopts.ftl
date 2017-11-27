        setOpts() {
<#if opts? size > 0 >
            let opts = [
<#list opts as opt >
<#if opt.type! == "update" || opt.type! == "delete" || opt.type! == "detail">
                {
                    widget: 'Button',
                    attrs: {
                        props: {
                        type: 'primary',
                        size: 'small'
                        },
                        style: {
                            marginRight: '5px',
<#if opt.permissionTag! != "">
                            display: this.$store.getters.hasPermission('${opt.permissionTag!}') ? 'inline' : 'none'
</#if>
                        },
                        on: {
                            click: () => {
                                this.go${opt.name?cap_first}${opt.type?cap_first}(params.row.id)
                            }
                        }
                    },
                    label: '${opt.label}'
                },
</#if>
            ]
            let optCount = opts.filter(opt => opt.attrs.style.display !== 'none').length
            if (optCount > 0) {
                this.columnsList.push({
                    title: '操作',
                    key: 'action',
                    fixed: 'right',
                    align: 'center',
                    width: 80 * optCount,
                    render: (h, params) => {
                        return h('div', opts.map(optItem => {
                            return h(optItem.widget, optItem.attrs, optItem.label)
                        }))
                    }
                })
            }
</#if>
        }