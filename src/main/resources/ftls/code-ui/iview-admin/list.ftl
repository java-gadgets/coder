<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
    <Table :columns="columns" :data="tableData" border></Table>
    <div style="text-align: right; padding-top: 10px;">
        <Page :total="page.total" :current="page.current" :page-size="page.size" show-total show-elevator @on-change="changePage">
            总计 {{page.total}} 条
        </Page>
    </div>
</Card>
</div></template>
<script>
import util from '@/libs/util';
export default {
    data () {
        return {
            tableData: [],
            page: {
                total: 0,
                size: 10,
                current: 1,
                num: 0
            },
            columns: [
<#list opts as opt >
<#if opt.type! == "list" >
<#include "segments/data-columns.ftl" />
<#break></#break>
</#if>
            ],
            optForm: {
<#list opts as opt >
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "query" || ((opt.type! == "add" || opt.type! == "detail" || opt.type! == "save" || opt.type! == "update") && opt.mode! == "modal") >
                ${optName}: {
<#list opt.attrs as attr>
                    ${attr.name}: <#if opt.type! == "query" && (attr.type! == "datetime" || attr.type! == "date")>[]<#else>''</#if><#if attr_has_next>,</#if>
</#list>
                },
</#if>
</#list>
            },
            optModal: {
<#list opts as opt >
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "detail" || opt.type! == "save" || opt.type! == "update") >
                ${optName}: {
                    show: false,
                    title: '${opt.label}',
<#if opt.type! == "detail" || opt.type! == "save" || opt.type! == "update" >
                    loading: true
</#if>
                },
</#if>
</#list>
            },
            dict: {
<#include "segments/data-dicts.ftl" />
            },
        }
    },
    mounted () {
        this.init();
    },
    methods: {
        changePage (number) {
            this.page.current = number;
            this.refresh();
        },
        init () {
            this.refresh();
        },
        refresh () {
<#list opts as opt >
<#if opt.type! == "list" >
            this.get${opt.name?cap_first}List();
<#break></#break>
</#if>        
        },
<#list opts as opt >
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "query">
<#include "segments/method-query.ftl" />
<#else if opt.type! == "add" >
<#include "segments/method-add.ftl" />
<#else if opt.type! == "save" >
<#include "segments/method-save.ftl" />
<#else if opt.type! == "update" >
<#include "segments/method-update.ftl" />
<#else if opt.type! == "detail" >
<#include "segments/method-detail.ftl" />
<#else if opt.type! == "delete" >
<#include "segments/method-delete.ftl" />
<#else if opt.type! == "export" >
<#include "segments/method-export.ftl" />
</#if>

</#list>
    }
</script>