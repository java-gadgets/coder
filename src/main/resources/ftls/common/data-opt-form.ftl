<#if opts? size gt 0>
            optForm: {
<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "query" || ((opt.type! == "update" || opt.type! == "add" || opt.type! == "detail") && opt.mode! == "modal")>
                ${optName}: {
<#list opt.attrs as attr>
                    ${attr.name}: <#if opt.type! == "query" && (attr.type! == "datetime" || attr.type! == "date")>[]<#else>''</#if><#if attr_has_next>,</#if>
</#list>
                },
</#if>
</#list>
            },
</#if>