<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        {{ card.title }}广告
    </p>
<#include "common/edit-template-form.ftl" />
    <Row>
        <Col span="24" style="text-align: center; margin-top: 20px;">
            <Button type="primary" icon="ios-cloud-upload" @click="doSave">保存</Button>
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
            optForm: {
                id: '',
<#list attrs as attr>
                ${attr.name}: ''<#if attr_has_next>,</#if>
</#list>
            },
<#include "common/data-dict.ftl" />
        }
    },
    mounted () {
        this.optForm.id = this.$route.params.id
        this.init()
    },
    methods: {
        init () {
            if (this.optForm.id) {
                let _self = this
                util.ajax.get('${preUrl}?id=' + this.optForm.id).then(res => {
                    if (res.status === 200) {
                        if (res.data.result === 1) {
                            _self.optForm = res.data.content
                        } else {
                            _self.$Message.error(res.data.message)
                        }
                    }
                }).catch(err => {
                    console.log(err)
                })
            }
        },
        doSave() {
            let url = '${exeUrl}'
            if (this.optForm.id) {
                url = '${exeUrl}'
            }
            util.ajax.post(url, this.optForm).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
                        this.$Message.info(res.data.message) 
                        this.doBack()   
                    } else {
                        this.$Message.info(res.data.message)
                    }
                }
            }).catch(err => {
                console.log(err)
            })
        },
        doBack() {
            this.$router.go(-1)
        },
    }
}
</script>
