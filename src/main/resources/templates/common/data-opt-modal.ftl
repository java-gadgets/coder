<#if opts? size gt 0>
            optModal: {
<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.mode! == "modal" && (opt.type! == "update" || opt.type! == "add")>
                ${optName}: {
                    show: false,
                    title: '${opt.label}',
<#if opt.type! == "update">
                    loading: true
</#if>
                },
</#if>
</#list>
            },
</#if>