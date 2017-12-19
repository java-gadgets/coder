            optList: [
<#list funcs as func >
<#if func.permissionTag! != "" >
                {
                    menuAccessCode: '${func.permissionTag!}',
                    opts: [
<#list func.opts as opt >
<#if opt.permissionTag! != "" >
                        {
                            title: '${opt.label!}',
                            accessCode: '${opt.permissionTag!}'
                        },
</#if>
</#list>
                    ],
                },
</#if>
</#list>
            ],
