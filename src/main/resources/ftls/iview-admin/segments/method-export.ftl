        do${optName?cap_first} () {
            let _self = this;
            util.ajax.post('${opt.exeUrl!}<#if relaAttr! != "" >?${relaAttr}=' + this.optForm.${relaAttr}<#else>'</#if>, this.optForm.queryForm).then(res => {
                if (res.status === 200) {
                    if (res.data.<#include "../spec/res-success.ftl" />) {
                        window.open(res.data.content);
                    } else {
                        _self.$Message.error(res.data.message);
                    }
                }
            }).catch(err => {
                console.log(err);
            });
        },
