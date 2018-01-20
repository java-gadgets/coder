<#assign optName = opt.code + opt.type?cap_first />
<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        <Icon type="clipboard"></Icon>
        ${name}详情
    </p>
    <Row>
        <Col span="10">${attr.name!}：{{ <#if attr.type! == "select" || attr.type! == "radio" >this.dict.${attr.code!}.filter(item => detailData.${attr.code!} == item.value).map(item => item.label)[0]<#elseif attr.type! == "select" ><img :src="optForm.${optName}.${attr.code!}" /><#else>optForm.${optName}.${attr.code!}</#if> }}</Col>
    </Row>
</Card>
</div></template>
<script>
import util from '@/libs/util';
export default {
    data () {
        return {
            optForm: {
                ${optName}: {
<#include "segments/comm-form-json-item.ftl" />
                },
            },
<#include "segments/data-dict.ftl" />            
        }
    },
    mounted () {
        this.init();
    },
    methods: {
        init () {
            let _self = this;
            util.ajax.get('${(opt.exeUrl)!}?id=' + this.$route.params.id).then(res => {
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