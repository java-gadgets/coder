    {
        path: '/${name}',
        icon: 'lock-combination',
        title: '${label}',
        name: '${name}',
        component: Main,
        children: [
<#list opts as opt>
<#if opt.type! == "query" || ((opt.type! == "add" || opt.type! == "update" || opt.type! == "detail" || opt.type! == "save") && opt.mode! == "page")>
            {
                path: '/${opt.name!}${opt.type?cap_first}', 
                title: '${opt.label!}',
                name: '${opt.name!}_${opt.type!}',
                component: resolve => { require(['./views/${name}/${opt.name!}${opt.type?cap_first}.vue'], resolve); } 
            },
</#if>
</#list>
        ]
    },