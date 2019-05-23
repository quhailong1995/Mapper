(function(){
    var
        infoUrl = window.actionPath + '---/${tableClass.variableName}/info?id=',
        editUrl = window.actionPath + '---/${tableClass.variableName}/edit';
                                                                 
    var bssVue = new Vue({
        el: '#bssContent',
        data: {
            data: {}
        },
        methods: {
            init: function(){
                Common.initFormComp();
                                      
            },
            info: function(){
                var pk = Common.getUrlParams().pk;
                if (!Common.existValue(pk)) {
                    return;
                }
                Common.getJsonRemote({
                    url: infoUrl + pk,
                    success: function(result){
                        if (Common.showErrorResultMessage(result)) {
                            bssVue.data = result.data;
                        }
                    }
                })
            },
            edit: function() {
                 //bssVue.data.validityDate = $('#validityDate').val();时间需要特别处理
                Common.postRemote({
                    url: editUrl,
                    data: JSON.stringify(bssVue.data),
                    success: function(result){
                        if (Common.showResultMessage(result)) {
                            setTimeout('Common.goAndReload()', 500);
                        }
                    }
                });
            }
        },
        mounted: function() {
            this.init();
            this.info();
        }
    });
                                                                          
    FormComn.validata(bssVue, {
        rules: {
<#if tableClass.baseFields??>
    <#list tableClass.baseFields as field>
            ${field.fieldName}: {
                required: true
            },
    </#list>
</#if>
        }
    });
      
                                                                                
})();

