    <Row>
        <Col span="24" style="text-align: center;">
<#list opts as opt >
<#if opt.type! == "query" >
            <Button type="primary" icon="android-search" @click="doQuery">查询</Button>
            <Button type="error" icon="android-refresh" @click="doQueryClear">清空</Button>
<#break>
</#if>
</#list>
<#list opts as opt >
<#if opt.type! == "export" >
            <Button type="success" icon="archive" @click="do${opt.name?cap_first}${opt.type?cap_first}">${opt.label!}</Button>
</#if>
</#list>
<#list opts as opt >
<#if opt.type! == "add" >
            <Button type="primary" icon="plus" @click="go${opt.name?cap_first}${opt.type?cap_first}">${opt.label!}</Button>            
</#if>
<#if opt.type! == "save" >
            <Button type="primary" icon="plus" @click="go${opt.name?cap_first}${opt.type?cap_first}">添加</Button>
</#if>
</#list>
        </Col>
    </Row>
