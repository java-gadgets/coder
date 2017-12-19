<#list opts as opt >
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "detail" || opt.type! == "save" || opt.type! == "update") >
                ${optName}: {
                    show: false,
                    title: '${opt.label}',
<#if opt.type! == "add" || opt.type! == "save" || opt.type! == "update" >
                    okLoading: true,
</#if>
<#if opt.type! == "detail" || opt.type! == "save" || opt.type! == "update" >
                    loading: true
</#if>
                },
</#if>
</#list>
