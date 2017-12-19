<#if attr.required! == "1" >
                    ${attr.name!}: [
<#if attr.type! == "date" || attr.type! == "datetime" >
                        { required: true, type: 'date', message: '请选择${attr.label!}', trigger: 'change' },
<#elseif attr.type! == "select" || attr.type! == "radio" >
                        { required: true, message: '请选择${attr.label!}', trigger: 'change' },
<#else>
                        { required: true, message: '${attr.label!}不能为空', trigger: 'blur' },
</#if>
                    ],
</#if>
