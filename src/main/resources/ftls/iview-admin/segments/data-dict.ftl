<#list attrs as attr >
<#if attr.type! == "select" || attr.type! == "radio" >
                ${attr.code!}: [
<#if attr.dict?? >
<#list attr.dict.dictItems as dictItem >
                    {
                        label: '${dictItem.name!}',
                        value: '${dictItem.value!}'
                    },
</#list>
<#else>
                    {
                        label: '请修改字典项1',
                        value: '0'
                    },
                    {
                        label: '请修改字典项2',
                        value: '1'
                    },
</#if>
                ],
</#if>
</#list>