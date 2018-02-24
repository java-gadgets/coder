<#list funcs as func >
CREATE TABLE `${code}`.`${c2u(func.code)}` (
<#include "common-columns.ftl" />
<#list func.attrs as attr >
<#include "columns.ftl" />
</#list>
<#list func.attrs as attr >
<#include "indexes.ftl" />
</#list>
  PRIMARY KEY (`id`))<#if func.remark! != "" > COMMENT '${func.remark!}'</#if>;

</#list>