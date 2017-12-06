<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        <Icon type="clipboard"></Icon>
        ${label}详情
    </p>
    <Row>
        <Col span="24" class="small-title detail-subtitle-bar">基本信息</Col>
        <Col span="24" class="detail-line">
            <Col span="1">&nbsp;</Col>
<#if attrs?size == 0>
            <Col span="23">&nbsp;</Col>
        </Col>
<#else>
<#list attrs as attr>            
            <Col span="7">
                <Col span="12" class="detail-item-label">${attr.label}：</Col>
                <Col span="12" class="detail-item-value">{{ detailData.${attr.name} }}</Col>
            </Col>
<#if attr_has_next>
<#if (attr_index + 1) % 3 == 0>
            <Col span="2">&nbsp;</Col>
        </Col>
        <Col span="24" class="detail-line">
            <Col span="1">&nbsp;</Col>
</#if>
<#else>
            <Col span="2">&nbsp;</Col>
        </Col>
</#if>
</#list>
</#if>
    </Row>
    <Row>
        <Col span="20" style="text-align: center; margin-top: 20px;">
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
            detailData: {}
        }
    },
    activated () {
        this.init()
    },
    methods: {
        init () {
            let _self = this
            util.ajax.get('${exeUrl}?id=' + this.$route.params.id).then(res => {
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