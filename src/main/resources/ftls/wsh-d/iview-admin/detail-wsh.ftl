<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        <Icon type="clipboard"></Icon>
        ${label}详情
    </p>
    <Row class="detail-line">
        <Col span="24" class="small-title detail-subtitle-bar">基本信息</Col>
    </Row>
    <Row class="detail-line">
        <Col span="2">&nbsp;</Col>
<#if attrs?size == 0>
        <Col span="22">&nbsp;</Col>
    </Row>
<#else>
<#list attrs as attr>
            <Col span="7" class="detail-item-cell">${attr.label}：{{ <#if attr.type! == "select" || attr.type! == "radio" >this.dict.${attr.name}.filter(item => {return detailData.${attr.name} == item.value}).map(item => {return item.label})[0]<#else>detailData.${attr.name}</#if> }}</Col>
<#if attr_has_next>
<#if (attr_index + 1) % 3 == 0>
        <Col span="1">&nbsp;</Col>
    </Row>
    <Row class="detail-line">
        <Col span="2">&nbsp;</Col>
</#if>
<#else>
        <Col span="1">&nbsp;</Col>
    </Row>
</#if>
</#list>
</#if>
    </Row>
    <Row>
        <Col span="24" style="text-align: center; margin-top: 20px;">
            <Button type="primary" icon="reply" @click="doBack">返回</Button>
        </Col>
    </Row>
</Card>
</div></template>
<script>
import util from '@/libs/util';
export default {
    data () {
        return {
            detailData: {},
            dict: {
<#include "segments/data-dict.ftl" />
            },
        }
    },
    mounted () {
        this.init()
    },
    methods: {
        init () {
            let _self = this
            util.ajax.get('${exeUrl!}/' + this.$route.params.id).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
                        _self.detailData = res.data.content
                    } else {
                        _self.$Message.error(res.data.message)
                    }
                }
            }).catch(err => {
                console.log(err)
            })
        },
        doBack() {
            this.$router.go(-1)
        }
    }
}
</script>