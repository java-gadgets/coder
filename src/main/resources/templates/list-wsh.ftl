<template><div>
<Card>
    <Form :model="queryForm" :label-width="80">
        <Row>
<#list attrs as attr>
<#if attr.name != "id">
            <Col span="6" style="margin-bottom: -15px;">
                <FormItem label="${attr.label}" prop="${attr.name}">
<#if attr.type! == "datetime">
                    <DatePicker :value="queryForm.${attr.name}" format="yyyy/MM/dd" type="daterange" placement="bottom-end" placeholder="请选择${attr.label}" style="width: 200px"></DatePicker>
<#elseif attr.type! == "enum">
                    <Select v-model="queryForm.${attr.name}" clearable placeholder="请选择${attr.name}" style="width:174px">
                        <Option v-for="item in dict.${attr.name}" :value="item.value" :key="item.value">{{ item.label }}</Option>
                    </Select>
<#else>
                    <Input type="text" v-model="queryForm.${attr.name}"></Input>
</#if>
                </FormItem>
            </Col>
</#if>
</#list>
        </Row>
        <Row>
            <Col span="7" style="text-align: center; margin-bottom: -15px;">
                <FormItem>
                    <Button type="primary" icon="android-search" @click="doQuery">查询</Button>
                    <Button type="error" icon="android-refresh" @click="doClear">清空</Button>
                    <Button type="success" icon="archive" @click="doExport">导出</Button>
                </FormItem>
            </Col>
        </Row>
    </Form>
</Card>
<Modal width="700" v-model="saveModal.show" loading @on-ok="doSave" :title="saveModal.title">
        <Form :model="saveForm" :label-width="80" >
        <Row>
<#list attrs as attr>
<#if attr.name != "id">
            <Col span="10" style="margin-bottom: -15px;">
                <FormItem label="${attr.label}" prop="${attr.name}">
                    <Input type="text" v-model="saveForm.${attr.name}" placeholder="请输入${attr.label}"></Input>
                </FormItem>
            </Col>
</#if>
</#list>
        </Row>
        </Form>
</Modal>
<Card>
<Button type="primary" icon="plus" style="margin-bottom: 5px; margin-top: -10px; text-align:right;" @click="showModalAdd">添加</Button>
    <Table :columns="columnsList" :data="tableData" border></Table>
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
            saveModal: {
                show: false,
                title: ''
            },
            queryForm: {
<#list attrs as attr>
<#if attr.name != "id">
                ${attr.name}: <#if attr.type! == "datetime">[]<#else>''</#if><#if attr_has_next>,</#if>
</#if>
</#list>
            },
            saveForm: {
<#list attrs as attr>
                ${attr.name}: ''<#if attr_has_next>,</#if>
</#list>
            },
            columnsList:[
<#list attrs as attr>
                {
                    title: '${attr.label}',
                    key: '${attr.name}',
                    width: 150,
                    align: 'center'
                },
</#list>
                {
                    title: '操作',
                    key: 'action',
                    fixed: 'right',
                    width: 200,
                    render: (h, params) => {
                        return h('div', [
                            h('Button', {
                                props: {
                                    type: 'primary',
                                    icon: 'document',
                                    size: 'small'
                                },
                                style: {
                                    marginRight: '5px'
                                },
                                on: {
                                    click: () => {
                                        let argu = { order_id: params.row.order_id }
                                           //util.openNewPage(this, 'order_info', argu);
                                        this.$router.push({
                                            name: 'order_info',
                                            params: argu
                                        })
                                    }
                                }
                            }, '详情'),
                            h('Button', {
                                props: {
                                    type: 'primary',
                                    icon: 'compose',
                                    size: 'small'
                                },
                                style: {
                                    marginRight: '5px'
                                },
                                on: {
                                    click: () => {
                                        this.showModalUpdate(params.row.id)
                                    }
                                }
                            }, '编辑'),
                            h('Button', {
                                props: {
                                    type: 'primary',
                                    icon: 'ios-trash-outline',
                                    size: 'small'
                                },
                                style: {
                                    marginRight: '5px'
                                },
                                on: {
                                    click: () => {
                                        this.doDelete(params.row.id)
                                    }
                                }
                            }, '删除')
                        ])
                    }
                }
            ],
            tableData: [],
            page: {
                total: 0,
                size: 10,
                current: 1
            },
            dict: {
<#list attrs as attr>
<#if attr.type! == "eumn">
                ${attr.name}: [
                    {
                        label: '请修改字典项1',
                        value: 0
                    },
                    {
                        label: '请修改字典项2',
                        value: 1
                    }
                ],
</#if>
</#list>            
            }
        }
    },
    mounted () {
        this.init()
    },
    methods: {
        init () {
            this.clearPage()
            this.getList()
        },
        doQuery() {
            this.clearPage()
            this.getList()
        },
        doClear () {
<#list attrs as attr>
<#if attr.name != "id">
            this.queryForm.${attr.name} = <#if attr.type! == "datetime">[]<#else>''</#if>
</#if>
</#list>
            this.doQuery()
        },
        doSave () {
            let _self = this;
            util.ajax.post('/${name}/save', this.saveForm).then(res => {
                _self.saveModal.show = false
                _self.$Message.info('操作成功')
                _self.doQuery()
              }).catch(err => {
                _self.saveModal.show = false
              })
        },
        doDelete (id) {
            let _self = this
            this.$Modal.confirm({
                title: '删除',
                content: '确定要删除？',
                loading: true,
                onOk: () => {
                    let _modal = this.$Modal
                    util.ajax.post('/${name}/delete/' + id).then(res => {
                        _modal.remove()
                        if (res.status === 200) {
                            if (res.data.code === "0") {
                                _self.$Message.info('操作成功')
                                _self.getList()
                            }
                        }
                    }).catch(err => {
                        _modal.remove()
                        console.log(err)
                    })
                }
            })
        },
        doExport () {
            let _self = this
            util.ajax.post('/${name}/Export', this.processQueryForm()).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
                        window.open(res.data.content)
                    } else {
                        _self.$Message.error(res.data.message)
                    }
                }
            }).catch(err => {
                console.log(err)
            })
        },
        getList () {
            let _self = this
            util.ajax.get('/${name}?page=' + this.page.current + '&limit=' + this.page.size, {params: this.processQueryForm()}).then(res => {
                if (res.status === 200) {
                    if (res.data.result === 1) {
                        _self.tableData = res.data.content.data
                        _self.page.total = res.data.content.total
                        _self.page.size = res.data.content.per_page
                        _self.page.current = res.data.content.current_page
                    }
                }
            }).catch(err => {
                console.log(err)
            })
        },
        processQueryForm () {
            return this.queryForm
        },
        showModalAdd() {
            this.clearSaveForm()
            this.saveModal.title = '添加${label}'
            this.saveModal.show = true
        },
        showModalUpdate(id) {
            let _self = this
            util.ajax.get('/${name}/detail?id=' + id).then(res => {
                if (res.status === 200) {
                    if (res.data.code === "0") {
                        _self.saveForm = res.data.data
                    }
                }
            }).catch(err => {
                console.log(err)
              })
            this.saveModal.show = true
            this.saveModal.title = '修改${label}'
        },
        clearSaveForm () {
<#list attrs as attr>
            this.saveForm.${attr.name} = ''
</#list>
        },
        clearPage () {
            this.page.size = 10
            this.page.current = 1
        },
        changePage () {
            this.getList()
        }
    }
}
</script>