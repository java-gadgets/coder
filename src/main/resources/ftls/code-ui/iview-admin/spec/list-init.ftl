    activated () {
<#if relaAttr! != "" >
        this.optForm.${relaAttr} = this.$route.params.id
</#if>
        this.page.current = 1;
        this.getTableData();
    },
    mounted () {
        this.init();
    },
