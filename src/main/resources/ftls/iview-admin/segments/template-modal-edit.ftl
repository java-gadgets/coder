<#list opts as opt >
<#if (opt.type! == "add" || opt.type! == "save" || opt.type! == "update") && opt.mode! == "modal" >
<#assign optName = opt.code + opt.type?cap_first />
<#assign spaces = "    "/>
<Modal width="800" v-model="optModal.${optName!}.show" :mask-closable="false" :loading="optModal.${optName!}.okLoading" @on-ok="do${optName?cap_first}()" @on-cancel="cancel${optName?cap_first}()" :title="optModal.${optName!}.title">
    <Card :bordered="false" dis-hover>
<#include "template-form-edit.ftl" />
        <Spin size="large" fix v-if="optModal.${optName!}.loading">
            <Icon type="load-c" size=18 class="spin-icon-loading"></Icon>
            <div>加载中</div>
        </Spin>
    </Card>
</Modal>
</#if>
</#list>
