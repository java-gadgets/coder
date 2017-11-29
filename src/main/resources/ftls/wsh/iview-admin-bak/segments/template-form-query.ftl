<#if opt.attrs? size gt 0 >
    <p slot="title">${opt.label!}</p>
<#assign optName = "queryForm" />
<#include "template-form.ftl" />
</#if>
    <Row>
        <Col span="24" style="text-align: center;">
<#list opts as opt >
<#if opt.type! == "query" >
            <Button type="primary" icon="android-search" @click="doQuery">查询</Button>
            <Button type="error" icon="android-refresh" @click="doQueryClear">清空</Button>
<#break>
</#if>
</#list>
        </Col>
    </Row>
