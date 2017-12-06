<#assign optName = name + type?cap_first />
<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        {{ card.title }}广告
    </p>
    <Form ref="${optName!}Form" :model="optForm.${optName}" :label-width="100" :rules="optRule.${optName}" >
<#list attrs as attr >
        <Row>
            <Col span="10">
                <FormItem label="${attr.label!}" prop="${attr.name!}" <#if attr.required! == "1">required</#if>>
<#include "segments/template-formitem-component.ftl" />
                </FormItem>
            </Col>
        </Row>
</#list>
    </Form>
    <Row>
        <Col span="24" style="text-align: center; margin-top: 20px;">
            <Button type="primary" icon="ios-cloud-upload" :loading="card.okLoading" @click="doBack">保存</Button>
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
                ${optName}: {
                    id: '',
<#list attrs as attr >
<#if attr.name! != "id" >
<#include "segment/comm-form-json-item.ftl" />
</#if>
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
            card: {
                title: '',
                okLoading: true,
            },
            upload: {
                url: util.uploadUrl,
<#list attrs as attr >
<#if attr.type == "pic" >
                ${attr.name!}: {
                    imageUrl: '',
                    visible: false,
                    uploadList: []
                },
</#if>
</#list>
            },
            dict: {
<#include "segments/data-dict.ftl" />
            }
        }
    },
    mounted () {
        this.optForm.id = this.$route.params.id;
        this.init();
    },
    methods: {
        init () {
            this.clearOptForm()
            if (this.optForm.id) {
                let _self = this
                util.ajax.get('/AdvertisingService/AdvertisingById?id=' + this.optForm.id).then(res => {
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
            this.prepareUpload();
        },
        do${optName?cap_first} () {
            let _self = this;
            this.$refs.${optName!}Form.validate((valid) => {
                if (valid) {
                    util.ajax.post('${opt.exeUrl!}<#if relaAttr! != "" >?${relaAttr}=' + this.optForm.${relaAttr}<#else>'</#if>, this.process${optName?cap_first}Form()).then(res => {
                        _self.clear${optName?cap_first}Form ();
                        _self.$Message.info(res.data.message);
                        _self.doBack();
                    }).catch(err => {
                        console.log(err);
                    });
                } else {
                    _self.card.okLoading = false;
                    _self.$nextTick(() => _self.card.okLoading = true);
                }
            });
        },
        prepare${optName?cap_first}Form (form) {
            this.optForm.${optName!}.id = form.id;
<#list opt.attrs as attr>
<#if attr.name! != "id" >
            this.optForm.${optName!}.${attr.name!} = form.${attr.name!};
</#if>
</#list>        
        },
        process${optName?cap_first}Form () {
            let form = {
                id: this.optForm.${optName!}.id,
<#list opt.attrs as attr>
<#if attr.name! != "id" >
                ${attr.name!}: this.optForm.${optName!}.${attr.name!},
</#if>
</#list>
            };
            return form;
        },
        clear${optName?cap_first}Form () {
            this.optForm.${optName!}.id = '';
<#list attrs as attr>
<#if attr.name! != "id" >
<#include "segment/comm-form-expr-item.ftl" />
</#if>
</#list>        
        },
        doBack() {
            this.$router.go(-1)
        },
    }
}
</script>
<style>
    .demo-upload-list{
        display: inline-block;
        width: 60px;
        height: 60px;
        text-align: center;
        line-height: 60px;
        border: 1px solid transparent;
        border-radius: 4px;
        overflow: hidden;
        background: #fff;
        position: relative;
        box-shadow: 0 1px 1px rgba(0,0,0,.2);
        margin-right: 4px;
    }
    .demo-upload-list img{
        width: 100%;
        height: 100%;
    }
    .demo-upload-list-cover{
        display: none;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0,0,0,.6);
    }
    .demo-upload-list:hover .demo-upload-list-cover{
        display: block;
    }
    .demo-upload-list-cover i{
        color: #fff;
        font-size: 20px;
        cursor: pointer;
        margin: 0 2px;
    }
</style>