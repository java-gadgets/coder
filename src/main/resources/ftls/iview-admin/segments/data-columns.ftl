<#list opts as opt >
<#if opt.type! == "list" >
<#list opt.attrs as attr >
                {
                    title: '${attr.name!}',
                    key: '${attr.code!}',
<#if attr.type! != "textarea" >
                    width: 150,
</#if>
                    sortable: true,
<#if attr.type! == "select" || attr.type! == "radio">
                    render: (h, params) => {
                        return this.dict.${attr.code!}.filter(item => params.row.${attr.code!} == item.value).map(item => item.label);
                    },
</#if>                    
                    align: 'center'
                },
</#list>
<#break>
</#if>
</#list>
