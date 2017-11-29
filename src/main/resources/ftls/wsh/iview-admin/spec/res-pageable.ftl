                        if (res.data.content.data.length == 0 && _self.page.current > 1 ) {
                            _self.page.current = _self.page.current - 1;
                            _self.getTableData();
                        } else {
                            _self.tableData = res.data.content.data;
                            _self.page.total = res.data.content.total;
                            _self.page.size = res.data.content.per_page;
                            _self.page.current = res.data.content.current_page;
						}
