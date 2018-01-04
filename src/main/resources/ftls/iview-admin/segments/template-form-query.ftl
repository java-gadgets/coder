<#if opt.attrs? size gt 0 >
    <p slot="title">${opt.label!}</p>
<#assign optName = "queryForm" />
    <Form :model="optForm.${optName!}" :label-width="100">
        <Row>
<#if opt.attrs? size == 0 >
        </Row>
<#else>
<#list opt.attrs as attr >
            <Col span="11">
                <FormItem label="${attr.name!}" prop="${attr.code!}">
<#include "template-formitem-component.ftl" />
                </FormItem>
            </Col>
<#if attr_has_next>
<#if (attr_index + 1) % 2 == 0 >
        </Row>
        <Row>
</#if>
<#else>
        </Row>
</#if>
</#list>
</#if>
    </Form>
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
