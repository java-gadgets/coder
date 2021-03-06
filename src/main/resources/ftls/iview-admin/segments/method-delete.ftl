        go${optName?cap_first} (row) {
            let _self = this;
            this.$Modal.confirm({
                title: '${opt.name!}',
                content: '确定要${opt.name!}？',
                loading: true,
                onOk: () => {
                    let _modal = this.$Modal;
                    util.ajax.post('${opt.exeUrl!}?id=' + row.id).then(res => {
                        if (res.status === 200) {
                            if (res.data.<#include "../spec/" + project.custom + "/res-success.ftl" />) {
                                _self.getTableData();
                                _self.$Message.info(res.data.message);
                            } else {
                                _self.$Message.error(res.data.message);
                            }
                        }
                        _modal.remove();
                    }).catch(err => {
                        _modal.remove();
                        console.log(err);
                    });
                }
            });
        },
