<#if attr.type! == "radio" >
            this.optForm.${optName!}.${attr.name} = '<#if attr.defaultValue! == "">0</#if>';
<#else>
            this.optForm.${optName!}.${attr.name} = '${attr.defaultValue!}';
</#if>
