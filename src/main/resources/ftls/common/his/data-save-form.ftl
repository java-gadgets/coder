            saveForm: {
<#list attrs as attr>
                ${attr.name}: ''<#if attr_has_next>,</#if>
</#list>
            }