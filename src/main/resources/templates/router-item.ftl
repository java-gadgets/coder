    {
        path: '/${name}',
        icon: 'lock-combination',
        title: '${label}',
        name: '${name}',
        component: Main,
        children: [
            {
                path: 'list', 
                title: '${label}',
                name: '${name}_index',
                component: resolve => { require(['./views/${name}/${name}.vue'], resolve); } 
            },
        ]
    },