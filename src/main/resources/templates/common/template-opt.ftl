<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "query" || ((opt.type! == "update" || opt.type! == "add" || opt.type == "detail") && opt.mode! == "modal")>
<#if (opt.type! == "update" || opt.type! == "add" || opt.type == "detail") && opt.mode! == "modal">
<Modal width="800" v-model="optModal.${optName}.show" loading @on-ok="do${optName?cap_first}" :title="optModal.${optName}.title">
<Card :bordered="false" dis-hover>
<#elseif opt.type! == "query">
<Card>
</#if>
    <Form :model="optForm.${optName}" :label-width="80" >
        <Row>
<#list attrs as attr>
            <Col span="10" style="margin-bottom: -15px;">
                <FormItem label="${attr.label}" prop="${attr.name}">
<#if attr.type! == "datetime">
                    <DatePicker :value="optForm.${optName}.${attr.name}" format="yyyy-MM-dd HH:mm:ss" type="<#if opt.type! == "query">datetimerange<#else>datetime</#if>" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "date">
                    <DatePicker :value="optForm.${optName}.${attr.name}" format="yyyy/MM/dd" type="<#if opt.type! == "query">daterange<#else>date</#if>" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "year">
                    <DatePicker :value="optForm.${optName}.${attr.name}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "month">
                    <DatePicker :value="optForm.${optName}.${attr.name}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "enum">
                    <Select v-model="optForm.${optName}.${attr.name}" clearable placeholder="请选择${attr.label}" style="width:174px">
                        <Option v-for="item in dict.${attr.name}" :value="item.value" :key="item.value">{{ item.label }}</Option>
                    </Select>
<#else>
                    <Input type="text" v-model="optForm.${optName}.${attr.name}"></Input>
</#if>
                </FormItem>
            </Col>
</#list>
        </Row>
    </Form>
<#if opt.type! == "query">
        <Row>
            <Col span="24" style="text-align: center; margin-bottom: -15px;">
                <Button type="primary" icon="android-search" @click="do${optName?cap_first}">查询</Button>
                <Button type="error" icon="android-refresh" @click="do${optName?cap_first}Clear">清空</Button>
            </Col>
        </Row>

</#if>
<#if (opt.type! == "update" || opt.type! == "detail") && opt.mode! == "modal">
    <Spin size="large" fix v-if="optModal.${optName}.loading">
        <Icon type="load-c" size=18 class="spin-icon-loading"></Icon>
        <div>加载中</div>
    </Spin>
</#if>
</Card>
<#if (opt.type! == "update" || opt.type! == "add" || opt.type! == "detail") && opt.mode! == "modal">
</Modal>
</#if>
</#if>
</#list>
<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "export" || opt.type! == "add">
<Card>
    <Row>
        <Col span="24" style="text-align: center; margin-bottom: -15px;">
<#if opt.type! == "export">
            <Button type="success" icon="archive" @click="do${optName?cap_first}">导出</Button>
<#elseif opt.type! == "add">
            <Button type="primary" icon="plus" @click="showModalAdd">添加</Button>
</#if>            
        </Col>
    </Row>
</Card>
</#if>
</#list>