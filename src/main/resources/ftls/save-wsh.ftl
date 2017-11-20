<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        {{ card.title }}广告
    </p>
    <Form :model="optForm" :label-width="100" >
        <Row>
<#list opts as opt>
<#if (opt.type! == "save" && opt.mode! == "page")>
<#list opt.attrs as attr>
<#if attr.name! != "id">
            <Col span="8">
                <FormItem label="${attr.label}" prop="${attr.name}">
<#if attr.type! == "datetime">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy-MM-dd HH:mm:ss" type="datetime" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "date">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy/MM/dd" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "year">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "month">
                    <DatePicker :value="optForm.${attr.name}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "enum">
                    <Select v-model="optForm.${attr.name}" clearable placeholder="请选择${attr.label}" style="width:174px">
                        <Option v-for="item in dict.${attr.name}" :value="item.value" :key="item.value">{{ item.label }}</Option>
                    </Select>
<#else>
                    <Input type="text" v-model="optForm.${attr.name}"></Input>
</#if>
                </FormItem>
            </Col>
</#if>
</#list>
</#if>
</#list>
        </Row>
    </Form>
    <Row>
        <Col span="24" style="text-align: center; margin-top: 20px;">
            <Button type="primary" icon="ios-cloud-upload" @click="doBack">保存</Button>
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
<#if opts? size gt 0>
            optForm: {
<#list opts as opt>
<#assign optName = opt.name + opt.type?cap_first />
<#if (opt.type! == "save" && opt.mode! == "page")>
                ${optName}: {
<#list opt.attrs as attr>
                    ${attr.name}: ''<#if attr_has_next>,</#if>
</#list>
                },
</#if>
</#list>
            },
</#if>
            card: {
                title: ''
            },
<#include "common/data-dict.ftl" />
        }
    },
    activated () {
        this.optForm.id = this.$route.params.id 
        this.init()
    },
    methods: {
        init () {
            if (this.optForm.id) {
                let _self = this
                util.ajax.get('/AdvertisingService/ExportAdvertising?id=' + this.optForm.id).then(res => {
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
            }
        },
        doBack() {
            this.$router.go(-1)
        }
    }
}
</script>    
