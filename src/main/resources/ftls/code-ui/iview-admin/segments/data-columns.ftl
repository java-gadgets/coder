<#list opt.attrs as attr>
                {
                    title: '${attr.label}',
                    key: '${attr.name}',
                    width: 150,
                    sortable: true,
<#if attr.type! == "enum">
                    render: (h, params) => {
                        return this.dict.${attr.name}.filter(item => {
                            return params.row.${attr.name} == item.value
                        }).map(item => {
                            return item.label
                        })
                    },
</#if>                    
                    align: 'center'
                },