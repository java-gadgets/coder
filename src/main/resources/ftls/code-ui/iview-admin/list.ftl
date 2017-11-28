<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<Card>
<#list opts as opt >
<#if opt.type! == "query" >
<#include "segments/template-form-query.ftl" />
<#break>
</#if>
</#list>
<#include "segments/template-button.ftl" />
</Card>
<Card>
    <Table :columns="columns" :data="tableData" border></Table>
    <div style="text-align: right; padding-top: 10px;">
        <Page :total="page.total" :current="page.current" :page-size="page.size" show-total show-elevator @on-change="changePage">
            总计 {{page.total}} 条
        </Page>
    </div>
</Card>
<#include "segments/template-modal-edit.ftl" />
<#include "segments/template-modal-detail.ftl" />
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
<#break>
</#if>
</#list>
            ],
            optForm: {
                queryForm: {
<#list opts as opt >
<#if opt.type! == "query" >
<#list opt.attrs as attr>
                    ${attr.name}: '',
</#list>
<#break>
</#if>
</#list>
                },
<#list opts as opt >
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.mode! == "modal" && (opt.type! == "add" || opt.type! == "detail" || opt.type! == "save" || opt.type! == "update") >
                ${optName}: {
                    id: '',
<#list opt.attrs as attr>
<#if attr.name! != "id" >
                    ${attr.name}: '${attr.defaultValue!}',
</#if>
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
    activated () {
        this.doQuery();
    }
    mounted () {
        this.init();
    },
    methods: {
        init () {
        	this.setOpts();
        },
        getQueryForm () {
            let queryForm = this.optForm.queryForm;
            queryForm.page = this.page.current - 1;
            queryForm.size = this.page.size;
            return queryForm;
        },
        getTableData () {
            let _self = this;
<#list opts as opt >
<#if opt.type! == "query" && opt.exeUrl! != "" >
<#assign getTableDataUrl = opt.exeUrl />
<#break>
</#if>
</#list>
<#if getTableDataUrl! == "" >
<#list opts as opt >
<#if opt.type! == "list" && opt.exeUrl! != "" >
<#assign getTableDataUrl = opt.exeUrl />
<#break>
</#if>
</#list>
</#if>
            util.ajax.get('${getTableDataUrl!}', { params: this.getQueryForm() }).then(res => {
                if (res.status === 200) {
                    if (res.data.code === "0") {
                        if (res.data.content.content.length == 0 && _self.page.current > 1 ) {
                            _self.page.current = _self.page.current - 1;
                            _self.getTableData();
                        } else {
						    _self.tableData = res.data.content.content;
						    _self.page.total = res.data.content.totalElements;
						    _self.page.size = res.data.content.size;
						    _self.page.current = res.data.content.number + 1;
						}
                    } else {
                        _self.$Message.error(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            });
        },
        changePage (number) {
            this.page.current = number;
            this.getTableData();
        },
<#list opts as opt >
<#assign optName = opt.name + opt.type?cap_first />
<#if opt.type! == "query">
<#include "segments/method-query.ftl" />
<#elseif opt.type! == "add" >
<#include "segments/method-add.ftl" />
<#elseif opt.type! == "save" >
<#include "segments/method-save.ftl" />
<#elseif opt.type! == "update" >
<#include "segments/method-update.ftl" />
<#elseif opt.type! == "detail" >
<#include "segments/method-detail.ftl" />
<#elseif opt.type! == "delete" >
<#include "segments/method-delete.ftl" />
<#elseif opt.type! == "export" >
<#include "segments/method-export.ftl" />
<#else>
</#if>
</#list>
        setOpts() {
            let opts = [
<#list opts as opt >
<#if opt.type! == "delete" || opt.type! == "detail" || opt.type! == "save" || opt.type! == "update" >
                {
                    widget: 'Button',
                    attrs: params => {
                        return {
                            props: {
                                type: 'primary',
                                size: 'small'
                            },
                            style: {
                                marginRight: '5px',
<#if opt.permissionTag! != "" >
                                display: this.$store.getters.hasPermission('${opt.permissionTag!}') ? 'inline' : 'none',
<#else>
                                display: 'inline',
</#if>
                            },
                            on: {
                                click: () => {
                                    this.go${opt.name?cap_first}${opt.type?cap_first}(params.row.id);
                                }
                            }
                        };
                    },
                    label: '<#if opt.type! == "save" >修改<#else>${opt.label!}</#if>'
                },
</#if>
</#list>
            ];
            let optCount = opts.filter(opt => opt.attrs().style.display !== 'none').length;
            if (optCount > 0) {
                this.columns.push({
                    title: '操作',
                    key: 'action',
                    fixed: 'right',
                    align: 'center',
                    width: 80 * optCount,
                    render: (h, params) => {
                        return h('div', opts.map(optItem => {
                            return h(optItem.widget, optItem.attrs(params), optItem.label);
                        }));
                    }
                });
            }
        },
    }
};
</script>