<#if opt.attrs? size gt 0 >
    <p slot="title">${opt.label!}</p>
<#assign optName = "queryForm" />
<#include "template-form.ftl" />
</#if>
