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
<#if attr.type! == "pics" || attr.type == "pic">
    <Row>
        <Col span="22">
            <div>${attr.name!}：
                <template>
                    <div class="pic-upload-list" v-for="item in upload.${attr.code!}.uploadList">
		                <img :src="item">
		                <div class="pic-upload-list-cover">
		                    <Icon type="ios-eye-outline" @click.native="${attr.code!}HandleView(item)"></Icon>
		                </div>
		            </div>
                </template>
            </div>
            <Modal title="图片预览" width="50%" v-model="upload.${attr.code!}.visible">
                <img :src="upload.${attr.code!}.imageUrl" v-if="upload.${attr.code!}.visible" style="width: 100%;">
            </Modal>
        </Col>
    </Row>
<#else>
    <Row>
        <Col span="10">${attr.name!}：{{ <#if attr.type! == "select" || attr.type! == "radio" >this.dict.${attr.code!}.filter(item => optForm.${optName}.${attr.code!} == item.value).map(item => item.label)[0]<#elseif attr.type! == "select" ><img :src="optForm.${optName}.${attr.code!}" /><#else>optForm.${optName}.${attr.code!}</#if> }}</Col>
    </Row>
</#if>
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
            upload: {
<#list attrs as attr >
<#if attr.type! == "pics" >
                ${attr.code!}: {
                    imageUrl: '',
                    visible: false,
                    uploadList: [],
                },
</#if>
</#list>
            }
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
                    if (res.data.<#include "spec/" + project.custom + "/res-success.ftl" />) {
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
<#list attrs as attr >
<#if attr.code! != "id" >
<#if attr.type! == "pics" || attr.type! == "pic" >
            if (data.${attr.code!}) {
                let ${attr.code!} = data.${attr.code!}.split(',');
                ${attr.code!}.forEach(item => this.upload.${attr.code!}.uploadList.push(decodeURIComponent(item)));
            }
<#else>
            this.optForm.${optName!}.${attr.code!} = data.${attr.code!};
</#if>
</#if>
</#list>
        },
        doBack() {
            this.$router.go(-1);
        },
<#list attrs as attr >
<#if attr.type! == "pics" || attr.type! == "pic">
        ${attr.code}HandleView (url) {
            this.upload.${attr.code}.imageUrl = url;
            this.upload.${attr.code}.visible = true;
        },
</#if>
</#list>
    }
}
</script>