<#if attr.type! == "radio" >
                    ${attr.name}: '<#if attr.defaultValue! == "">0</#if>',
<#else>
                    ${attr.name}: '${attr.defaultValue!}',
</#if>
