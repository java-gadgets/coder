<style lang="less">
    @import '../../styles/common.less';
</style>
<template><div>
<#include "common/list-template-opt.ftl" />
<Card>
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
<#include "common/data-opt-form.ftl" />
<#include "common/data-opt-modal.ftl" />
            columnsList:[
<#include "common/data-column-list-item.ftl" />
<#include "common/data-column-list-opt.ftl" />
            ],
            tableData: [],
            page: {
                total: 0,
                size: 10,
                current: 1
            },
<#include "common/data-dict.ftl" />
        }
    },
    mounted () {
        this.init()
    },
    methods: {
<#include "common/method-opt.ftl" />
    }
}
</script>