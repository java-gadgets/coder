<#assign optName = code + type?cap_first />
<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        <Icon type="clipboard"></Icon>
        ${name!}
    </p>
<#list attrs as attr >
    <Row>
        <Col span="10">${attr.name!}：{{ <#if attr.type! == "select" || attr.type! == "radio" >this.dict.${attr.code!}.filter(item => optForm.${optName}.${attr.code!} == item.value).map(item => item.label)[0]<#elseif attr.type! == "select" ><img :src="optForm.${optName}.${attr.code!}" /><#else>optForm.${optName}.${attr.code!}</#if> }}</Col>
    </Row>
</#list>
</Card>
</div></template>
<script>
import util from '@/libs/util';
export default {
    data () {
        return {
            optForm: {
                ${optName}: {
<#list attrs as attr >
<#include "segments/comm-form-json-item.ftl" />
</#list>
                },
            },
            dict: {
<#include "segments/data-dict.ftl" />
            },            
        }
    },
    mounted () {
        this.init();
    },
    methods: {
        init () {
            let _self = this;
            util.ajax.get('${exeUrl!}?id=' + this.$route.params.id).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "spec/" + project.code + "/res-success.ftl" />) {
                        _self.perpare${optName?cap_first} (res.data.content);
                    } else {
                        _self.$Message.error(res.data.message)
                    }
                }
            }).catch(err => {
                console.log(err);
            })
        },
        perpare${optName?cap_first} (data) {
        
        },
        doBack() {
            this.$router.go(-1);
        }
    }
}
</script>