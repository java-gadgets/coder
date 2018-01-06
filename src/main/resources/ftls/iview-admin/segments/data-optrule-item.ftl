<#if attr.required! == 1 >
                    ${attr.code!}: [
<#if attr.type! == "date" || attr.type! == "datetime" >
                        { required: true, type: 'date', message: '请选择${attr.name!}', trigger: 'change' },
<#elseif attr.type! == "select" || attr.type! == "radio" >
                        { required: true, message: '请选择${attr.name!}', trigger: 'change' },
<#else>
                        { required: true, message: '${attr.name!}不能为空', trigger: 'blur' },
</#if>
                    ],
</#if>
