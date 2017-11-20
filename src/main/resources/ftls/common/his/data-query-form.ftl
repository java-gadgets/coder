            queryForm: {
<#list attrs as attr>
<#if attr.name != "id">
                ${attr.name}: <#if attr.type! == "datetime">[]<#else>''</#if><#if attr_has_next>,</#if>
</#if>
</#list>
            }