<#list opts as opt >
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "save" || opt.type == "update") >
<#assign optName = opt.name + opt.type?cap_first />
                ${optName}: {
<#list opt.attrs as attr >
<#if attr.required! == "1" >
                    ${attr.name!}: [
<#if attr.type! == "date" || attr.type! == "datetime" || attr.type! == "enum" >
                        { required: true, message: '请选择${attr.label!}', trigger: 'change' },
<#else>
                        { required: true, message: '${attr.label!}不能为空', trigger: 'blur' },
</#if>
                    ],
</#if>
</#list>
                },
</#if>
</#list>
