        doQuery () {
            this.page.current = 1;
            this.getTableData();
        },
        doQueryClear () {
<#list opt.attrs as attr >
            this.optForm.queryForm.${attr.code!} = '';
</#list>
            this.doQuery();
        },
