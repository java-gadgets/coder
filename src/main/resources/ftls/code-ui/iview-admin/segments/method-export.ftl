        do${optName?cap_first} () {
            let _self = this;
            util.ajax.post('${opt.exeUrl!}', this.optForm.queryForm).then(res => {
                if (res.status === 200) {
                    if (res.data.code === "0") {
                        window.open(res.data.content);
                    } else {
                        _self.$Message.error(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            });
        },
