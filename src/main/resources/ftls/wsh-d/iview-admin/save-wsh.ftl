<#assign optName = name + type?cap_first />
<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <p slot="title">
        {{ card.title }}
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
            <Button type="primary" icon="ios-cloud-upload" :loading="card.okLoading" @click="do${optName?cap_first}">保存</Button>
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
<#include "segments/comm-form-json-item.ftl" />
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
                okLoading: false,
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
        this.init(this.$route.params.id);
    },
    methods: {
        init (id) {
	        if (id) {
	            this.optForm.${optName}.id = id;
	            this.card.title = '编辑${label!}';
	            let _self = this;
	            util.ajax.get('${preUrl!}?id=' + id).then(res => {
	                if (res.status === 200) {
	                    if (res.data.<#include "spec/res-success.ftl" />) {
	                        _self.prepare${optName?cap_first}Form(res.data.content);
	                        _self.prepareUpload();
	                    }
	                }
	            }).catch(err => {
	                console.log(err);
	            });
	        } else {
	            this.card.title = '添加${label!}';
	            this.prepareUpload();
	        }
        },
        do${optName?cap_first} () {
            this.card.okLoading = true;
            let _self = this;
            this.$refs.${optName!}Form.validate((valid) => {
                if (valid) {
                    util.ajax.post('${exeUrl!}', this.process${optName?cap_first}Form()).then(res => {
                        _self.clear${optName?cap_first}Form ();
                        _self.$Message.info(res.data.message);
                        _self.card.okLoading = false;
                        _self.doBack();
                    }).catch(err => {
                        console.log(err);
                    });
                } else {
                    _self.card.okLoading = false;
                }
            });
        },
        prepare${optName?cap_first}Form (form) {
            this.optForm.${optName!}.id = form.id;
<#list attrs as attr>
<#if attr.name! != "id" >
            this.optForm.${optName!}.${attr.name!} = form.${attr.name!} + '';
</#if>
</#list>        
        },
        process${optName?cap_first}Form () {
            let form = {
                id: this.optForm.${optName!}.id,
<#list attrs as attr>
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
<#include "segments/comm-form-expr-item.ftl" />
</#if>
</#list>        
        },
        doBack() {
            this.$router.go(-1);
        },
        prepareUpload () {
<#list attrs as attr >
<#if attr.type! == "pic" >
            this.upload.${attr.name!}.uploadList = this.$refs.${attr.name!}Upload.fileList;
            if (this.optForm.${optName!}.${attr.name!} != '') {
            	this.upload.${attr.name!}.uploadList.push({
            	    response: {
                        content: this.optForm.advertSave.advertising_url,
                    },
                    status: 'finished',
            	});
            }
            
</#if>
</#list>
        },
<#list attrs as attr >
<#if attr.type == "pic" >
        ${attr.name!}HandleView (url) {
            this.upload.${attr.name!}.imageUrl = url;
            this.upload.${attr.name!}.visible = true;
        },
        ${attr.name!}HandleRemove (file) {
            util.removeArray(this.$refs.${attr.name!}Upload.fileList, file);
            this.optForm.${optName!}.${attr.name!} = '';
        },
        ${attr.name!}HandleSuccess (res, file) {
            this.optForm.${optName!}.${attr.name!} = file.response.content;
        },
        ${attr.name!}HandleFormatError (file) {
            this.$Notice.warning({
                title: '不是有效的图片格式',
                desc: file.name + '图片格式无效，只能是jpg或者png格式.'
            });
        },
        ${attr.name!}HandleMaxSize (file) {
            this.$Notice.warning({
                title: '图片大小超过限制',
                desc: '图片大小超过2mb.'
            });
        },
        ${attr.name!}HandleBeforeUpload () {
            util.clearArray(this.upload.${attr.name!}.uploadList);
            return true;
        }
</#if>
</#list>
    }
}
</script>