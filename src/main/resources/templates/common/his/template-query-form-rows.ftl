        <Row>
<#list attrs as attr>
<#if attr.name != "id">
            <Col span="6" style="margin-bottom: -15px;">
                <FormItem label="${attr.label}" prop="${attr.name}">
<#if attr.type! == "datetime">
                    <DatePicker :value="queryForm.${attr.name}" format="yyyy/MM/dd" type="daterange" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "enum">
                    <Select v-model="queryForm.${attr.name}" clearable placeholder="请选择${attr.label}" style="width:174px">
                        <Option v-for="item in dict.${attr.name}" :value="item.value" :key="item.value">{{ item.label }}</Option>
                    </Select>
<#else>
                    <Input type="text" v-model="queryForm.${attr.name}"></Input>
</#if>
                </FormItem>
            </Col>
</#if>
</#list>
        </Row>