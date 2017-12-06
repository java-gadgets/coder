    <Card :bordered="false" dis-hover>
        <Row>
            <Col span="3">&nbsp;</Col>
<#if attrs?size == 0 >
            </Col>
        </Row>
<#else>
<#list opt.attrs as attr >
            <Col span="10">${attr.label!}：{{ <#if attr.type! == "select" || attr.type! == "radio" >this.dict.${attr.name!}.filter(item => detailData.${attr.name!} == item.value).map(item => item.label)[0]<#else>detailData.${attr.name!}</#if> }}</Col>
<#if attr_has_next>
<#if (attr_index + 1) % 2 == 0 >
            <Col span="1">&nbsp;</Col>
            </Col>
</#if>
<#else>
            </Col>
        </Row>
</#if>
</#list>
</#if>
        <Spin size="large" fix v-if="optModal.${optName!}.loading">
            <Icon type="load-c" size=18 class="spin-icon-loading"></Icon>
            <div>加载中</div>
        </Spin>
    </Card>