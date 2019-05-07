(function(){
    var infoUrl = window.actionPath + '---/${tableClass.variableName}/info?id=';
                                                                 
    var bssVue = new Vue({
        el: '#bssContent',
        data: {
            data: {}
        },
        methods: {
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
            }
        },
        mounted: function() {
            this.info();
        }
    });
                                                                                
})();

