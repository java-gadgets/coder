<template><div>
<Card>
	<Form :model="formItem" :label-width="80">
		<Row>
			<#list attrs as attr>
			<Col span="6" style="margin-bottom: -15px;">
				<FormItem label="${attr.label}" prop="${attr.name}">
					<Input type="text" ></Input>
				</FormItem>
			</Col>
			</#list>
		</Row>
		<Row>
			<Col span="7" style="text-align: center; margin-bottom: -15px;">
				<FormItem>
					<Button type="primary" icon="android-search">查询</Button>
					<Button type="error" icon="android-refresh">清空</Button>
					<Button type="success" icon="archive">导出</Button>
				</FormItem>
			</Col>
		</Row>
	</Form>
</Card>
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
export default {
	data () {
        return {
        	formItem: {

        	},
        	columnsList:[
			<#list attrs as attr>
				{
					title: '${attr.label}',
					key: '${attr.name}',
					align: 'center'
				}<#if attr_has_next>,</#if>
			</#list>	
        	],
        	tableData: [
        		{
        			order_no: 1,
        			name: "测试",
        			mobile: 123,
        			money: 111,
        			coin: 100
        		},
        		{
        			order_no: 2,
        			name: "测试2",
        			mobile: 123123,
        			money: 1111,
        			coin: 200
        		},
        	],
        	page: {
        		total: 100,
        		size: 10,
        		current: 1
        	}
        }
    },
    methods: {
		changePage (number) {
			console.log(number)
		},
	}
}
</script>