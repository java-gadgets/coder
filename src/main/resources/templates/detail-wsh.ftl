<template><div>
<Card>
    <p slot="title">
        <Icon type="clipboard"></Icon>
        ${label}详情
    </p>
    <Row style="padding-left: 200px; paddig-right: 200px">
<#list attrs as attr>
        <Col span="12">
            <div>${attr.label}：{{ detailData.${attr.name} }}</div>
        </Col>
</#list>
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
        util.ajax.get('${name}/detail?id=' + this.$route.params.id).then(res => {
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
        window.history.go(-1)
        }
    }
}
</script>
