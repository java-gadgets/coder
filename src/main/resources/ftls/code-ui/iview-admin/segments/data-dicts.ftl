<#list attrs as attr >
<#if attr.type! == "enum" >
                ${attr.name!}: [
                    {
                        label: '请修改字典项1',
                        value: '0'
                    },
                    {
                        label: '请修改字典项2',
                        value: '1'
                    }
                ],
</#if>
</#list>
