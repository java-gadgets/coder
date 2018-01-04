<#if attr.type! == "radio" >
            this.optForm.${optName!}.${attr.code} = '<#if attr.defaultValue! == "">0</#if>';
<#else>
            this.optForm.${optName!}.${attr.code} = '${attr.defaultValue!}';
</#if>
