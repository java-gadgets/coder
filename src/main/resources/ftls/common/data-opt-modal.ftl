<#if opts? size gt 0>
            optModal: {
<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.mode! == "modal" && (opt.type! == "update" || opt.type! == "add" || opt.type! == "detail")>
                ${optName}: {
                    show: false,
                    title: '${opt.label}',
<#if opt.type! == "update" || opt.type! == "detail">
                    loading: true
</#if>
                },
</#if>
</#list>
            },
</#if>