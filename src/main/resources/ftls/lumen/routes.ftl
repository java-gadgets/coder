<?php

<#list funcs as func >
$app->group(['prefix' => '/${func.code}', 'namespace' => 'App\Http\Controllers'], function () use ($app) {

<#list func.opts as opt >
    $app->${opt.exeMethod!}('/${opt.type!}', '${code?cap_first}Controller@${code!}${opt.type?cap_first}');
    
</#list>
});

</#list>