<#assign optName = code + type?cap_first />
<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        ${name}
    </p>
    <Form ref="${optName!}Form" :model="optForm.${optName!}" :label-width="100" :rules="optRule.${optName}">
<#list attrs as attr >
        <Row>
            <Col span="11">
                <FormItem label="${attr.name!}" prop="${attr.code!}" <#if attr.required! == 1>required</#if>>
<#include "segments/template-formitem-component.ftl" />
                </FormItem>
            </Col>
        </Row>
</#list>
    </Form>
    <Row>
        <Col span="24" style="text-align: center; margin-top: 20px;">
            <Button type="primary" icon="ios-cloud-upload" @click="do${optName}()">保存</Button>
            <Button type="primary" icon="reply" @click="doBack()">返回</Button>
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
                ${optName}: {
                    id: '',
<#list attrs as attr>
<#include "segments/comm-form-json-item.ftl" />
</#list>
                },
            },
            optRule: {
                ${optName}: {
<#list attrs as attr >
<#include "segments/data-optrule-item.ftl" />
</#list>
                },
            },
            dict: {
<#include "segments/data-dict.ftl" />
            },
        }
    },
    mounted () {
        this.optForm.${optName}.id = this.$route.params.id;
        this.init();
    },
    methods: {
        init () {
            let _self = this;
            util.ajax.get('${preUrl}/' + this.optForm.${optName}.id).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "spec/" + project.code + "/res-success.ftl" />) {
                        _self.prepare${optName?cap_first}Form (res.data.content);
                    } else {
                        _self.$Message.error(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            });
        },
        do${optName}() {
            util.ajax.post('${exeUrl}', this.optForm.${optName}).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "spec/" + project.code + "/res-success.ftl" />) {
                        this.$Message.info(res.data.message); 
                        this.doBack();
                    } else {
                        this.$Message.info(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            });
        },
        prepare${optName?cap_first}Form (form) {
            this.optForm.${optName!}.id = form.id;
<#list attrs as attr>
<#if attr.code! != "id" >
            this.optForm.${optName!}.${attr.code!} = form.${attr.code!}.toString();
</#if>
</#list>        
        },
        doBack() {
            this.$router.go(-1);
        },
    }
}
</script>
