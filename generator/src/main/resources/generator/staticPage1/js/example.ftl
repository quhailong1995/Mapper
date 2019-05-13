(function(){
    /**
     * 全局变量
     */
    var _this = this,
        pageUrl = window.actionPath + '--/${tableClass.variableName}/page',
        delUrl = window.actionPath + '--/${tableClass.variableName}/update',
        exportUrl = window.actionPath + '--/${tableClass.variableName}/export',
        formHtmlUrl = window.actionPath + 'view/--/vipCategory/${tableClass.variableName}-form.html',
        infoHtmlUrl = window.actionPath + 'view/--/vipCategory/${tableClass.variableName}-info.html',
        $bssTable = $('#bssTable');

    /**
     * vue初始化
     */
    var bssVue = new Vue({
        el: '#bssContent',
        data: {
            params:{}
        },
        methods:{
            init: function(){
                Common.initDatepicker();
            },
            info: function(pk){
                window.location.href = infoHtmlUrl + '?pk=' + pk;
            },
            add: function(){
                window.location.href = formHtmlUrl;
            },
            upd: function(){
                if (TableComn.checkSelectedDataLengthEqOne(_table)) {
                    var selectedData = TableComn.getSelectedData(_table)[0];
                    window.location.href = formHtmlUrl + '?pk=' + selectedData.id;
                }
            },
            del: function(){
                if (TableComn.checkSelectedDataLengthEqMulti(_table)) {
                    var pks = TableComn.getSelectedDataByField(_table, 'id').join(',');
                    var jsonData = {'ids': pks,'editFlag':1};
                    Common.openConfirm({
                        message: '确定删除？',
                        confirmFunc: function(){
                            // 发送删除请求
                            Common.postRemote({
                                url: delUrl,
                                data: JSON.stringify(jsonData),
                                success: function(result){
                                    Common.showResultMessage(result);
                                    bssVue.reload();
                                }
                            });
                        }
                    });
                }
            },
            expt: function(){
                var data = TableComn.getQueryData($bssTable, new Query(), bssVue.params, data);
                window.open(exportUrl + '?query=' + encodeURI(data.query));
            },
            search: function () {
                _table.draw( false );
            },
            reload: function (event) {
                bssVue.params = {};
                _table.draw( true );
            }
        },
        mounted: function() {
            this.init();
        }
    });

    /**
     * dataTable初始化
     */
    var _table = $bssTable.dataTable($.extend(true, {}, TableConfig.dataTables.defaultOption, {
        fixedHeader: TableConfig.dataTables.headerFixed,
        columns: [
            TableConfig.dataTables.column.checkbox,
        <#if tableClass.baseFields??>
            <#list tableClass.allFields as field>
            {data: "${field.fieldName}", width: "100px"},
            </#list>
        </#if>
            {data: "type", width: "40" ,render : function(data, type, row, meta) {
            return data==1?"企业":data==2?"个人":data==3?"企业/个人":"";}},
            {data: "hasFree", width: "20", render: TableConfig.dataTables.render.whether},
            {data: null, defaultContent: "", orderable: false, width: "60px",
            render : function(data, type, row, meta) {
                return '<div class="btn-group">'
                    + '<a class="btn btn-xs btn-info js-info" data-pk=' + data.id + '>详情</a>'
                    + '</div>';
                }
            }
        ],
        ajax: function(data, callback, settings) {//ajax配置为function,手动调用异步查询
            //手动控制遮罩
            Common.showStandby($('.js-standby'));

            Common.getJsonRemote({
                url: pageUrl,
                data: TableComn.getQueryData2($bssTable,  $("#searchForm").serializeArray(), data),
                success: function(result){
                    Common.showErrorResultMessage(result);
                    callback(TableComn.getReturnData(result, data));
                }
            })
        },
        "createdRow": function (row, data, index) {
        },
        "drawCallback": function(settings) {
            $bssTable.find('.group-checkable').prop('checked', false);
            $('.js-info').on('click', function(){
                bssVue.info($(this).data('pk'));
            });
        }
    })).api();//此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象

    /**
     * dataTable全选框, 全选和全不选事件
     */
    TableComn.groupCheckableChange($bssTable);

    /**
     * dataTable复选框
     */
    TableComn.checkableChange($bssTable);

})();

