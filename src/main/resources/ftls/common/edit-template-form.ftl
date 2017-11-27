    <Form :model="optForm" :label-width="100" >
<#list attrs as attr>    
        <Row>
            <Col span="8">
                <FormItem label="${attr.label!}" prop="{attr.name!}">
<#if attr.type! == "datetime">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy-MM-dd HH:mm:ss" type="datetime" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "date">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy/MM/dd" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "year">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "month">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "enum">
                    <Select v-model="optForm.${attr.name}" clearable placeholder="请选择${attr.label}" style="width:174px">
                        <Option v-for="item in dict.${attr.name}" :value="item.value" :key="item.value">{{ item.label }}</Option>
                    </Select>
<#else>
                    <Input type="<#if attr.type! == "textarea">textarea<#elseif attr.type! == "password">password<#else>text</#if>" v-model="optForm.${attr.name}"></Input>
</#if>
                </FormItem>
            </Col>
        </Row>
</#list>
    </Form>