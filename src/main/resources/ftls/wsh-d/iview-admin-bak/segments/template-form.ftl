${spaces!}    <Form :model="optForm.${optName!}" :label-width="100">
${spaces!}        <Row>
<#if opt.attrs? size == 0 >
${spaces!}        </Row>
<#else>
<#list opt.attrs as attr >
${spaces!}            <Col span="11">
${spaces!}                <FormItem label="${attr.label!}" prop="${attr.name!}">
<#if attr.type! == "datetime">
${spaces!}                    <DatePicker :value="optForm.${optName!}.${attr.name!}" format="yyyy-MM-dd HH:mm:ss" type="datetime" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "date">
${spaces!}                    <DatePicker :value="optForm.${optName!}.${attr.name!}" format="yyyy/MM/dd" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "year">
${spaces!}                    <DatePicker :value="optForm.${optName!}.${attr.name!}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "month">
${spaces!}                    <DatePicker :value="optForm.${optName!}.${attr.name!}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "enum">
${spaces!}                    <Select v-model="optForm.${optName!}.${attr.name!}" clearable placeholder="请选择${attr.label!}">
${spaces!}                        <Option v-for="item in dict.${attr.name!}" :value="item.value" :key="item.value">{{ item.label }}</Option>
${spaces!}                    </Select>
<#else>
${spaces!}                    <Input type="<#if attr.type! == "textarea">textarea<#elseif attr.type! == "password">password<#else>text</#if>" v-model="optForm.${optName!}.${attr.name!}"></Input>
</#if>
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
