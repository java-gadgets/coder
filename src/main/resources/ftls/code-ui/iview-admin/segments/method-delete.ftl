        go${optName?cap_first} () {
            let _self = this;
            this.$Modal.confirm({
                title: '${opt.label}',
                content: '确定要${opt.label}？',
                loading: true,
                onOk: () => {
                    let _modal = this.$Modal;
                    util.ajax.post('${opt.exeUrl!}?id=' + id).then(res => {
                        if (res.status === 200) {
                            if (res.data.code === "0") {
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