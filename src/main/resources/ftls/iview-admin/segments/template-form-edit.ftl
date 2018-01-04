${spaces!}    <Form ref="${optName!}Form" :model="optForm.${optName!}" :label-width="100" :rules="optRule.${optName}">
${spaces!}        <Row>
<#if opt.attrs? size == 0 >
${spaces!}        </Row>
<#else>
<#list opt.attrs as attr >
${spaces!}            <Col span="11">
${spaces!}                <FormItem label="${attr.name!}" prop="${attr.code!}" <#if attr.required! == 1>required</#if>>
<#include "template-formitem-component.ftl" />
${spaces!}                </FormItem>
${spaces!}            </Col>
<#if attr_has_next>
<#if (attr_index + 1) % 2 == 0 >
${spaces!}        </Row>
${spaces!}        <Row>
</#if>
<#else>
${spaces!}        </Row>
</#if>
</#list>
</#if>
${spaces!}    </Form>
