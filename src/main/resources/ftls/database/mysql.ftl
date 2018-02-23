<#list funcs as func >
CREATE TABLE `${code}`.`${c2u(func.code)}` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
<#list func.attrs as attr >
  `${c2u(attr.code!)}` <#if attr.datatype! == "string" >VARCHAR<#elseif attr.datatype! == "int" >INT<#elseif attr.datatype! == "double" >DECIMAL<#else>VARCHAR</#if>(${attr.length!0}<#if attr.precise?exists && attr.precise gt 0 >, ${attr.precise}</#if>),
</#list>
  `created_at` DATETIME,
  `updated_at` DATETIME,
  PRIMARY KEY (`id`),
  INDEX `fk_oid` (`oid` ASC));
</#list>