<#if attr.dbIdxFlag == 1 >
  INDEX `idx_${c2u(attr.code!)}` (`${c2u(attr.code!)}` ASC),
</#if>