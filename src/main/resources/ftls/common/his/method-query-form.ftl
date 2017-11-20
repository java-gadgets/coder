<#list attrs as attr>
<#if attr.name != "id">
            this.queryForm.${attr.name} = <#if attr.type! == "datetime">[]<#else>''</#if>
</#if>
</#list>