<#if relaAttr! != "" >
                ${relaAttr}: '',
</#if>
                queryForm: {
<#list opts as opt >
<#if opt.type! == "query" >
<#list opt.attrs as attr>
                    ${attr.code}: '',
</#list>
<#break>
</#if>
</#list>
                },
<#list opts as opt >
<#assign optName = opt.code! + opt.type! ?cap_first />
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "detail" || opt.type! == "save" || opt.type! == "update") >
                ${optName}: {
                    id: '',
<#list opt.attrs as attr>
<#if attr.code! != "id" >
<#include "comm-form-json-item.ftl" />
</#if>
</#list>
                },
</#if>
</#list>
