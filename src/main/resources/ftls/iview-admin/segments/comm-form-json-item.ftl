<#if attr.type! == "radio" >
                    ${attr.code}: '<#if attr.defaultValue! == "">0</#if>',
<#else>
                    ${attr.code}: '${attr.defaultValue!}',
</#if>
