<#list opts as opt >
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "save" || opt.type == "update") >
<#assign optName = opt.code + opt.type?cap_first />
                ${optName}: {
<#list opt.attrs as attr >
<#include "data-optrule-item.ftl" />
</#list>
                },
</#if>
</#list>
