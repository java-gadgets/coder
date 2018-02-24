CREATE TABLE `${project.code}`.`${c2u(code)}` (
<#include "common-columns.ftl" />
<#list attrs as attr >
<#include "columns.ftl" />
</#list>
<#list attrs as attr >
<#include "indexes.ftl" />
</#list>
  PRIMARY KEY (`id`))<#if remark! != "" > COMMENT '${remark!}'</#if>;
