<!--#include file="/view/tpl/header-beg.shtml"-->
<!--#include file="/view/tpl/header-end.shtml"-->
<!--#include file="/view/tpl/content-beg.shtml"-->

<div class="wrapper-sm">
    <div class="row wrapper" id="bssContent">

        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption">
                    <i class="icon-equalizer font-green-haze"></i>
                    <span class="caption-subject font-green-haze bold uppercase">VIP分类管理详情</span>
                </div>
                <div class="tools">
                    <a href="javascript:;" class="collapse" data-original-title="" title="收拢/展开"> </a>
                    <a href="javascript:;" class="reload" data-original-title="" title="刷新" @click="info"> </a>
                </div>
            </div>
            <div class="portlet-body form">
                <!-- BEGIN FORM-->
                <form class="form-horizontal" role="form">
                    <div class="form-body">
                    <#if tableClass.baseFields??>
                         <#list tableClass.allFields as field>
                             <div class="row">
                                 <div class="col-md-6">
                                     <div class="form-group">
                                         <label class="control-label col-md-3">>${field.remarks}:</label>
                                         <div class="col-md-9">
                                             <div class="show-error" >
                                                 <p class="form-control-static"> {{ data.${field.fieldName} }} </p>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </#list>
                    </#if>
                    </div>
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <a type="button" class="btn default"  href="javascript:history.go(-1)" >返回</a>
                                    </div>
                                </div>
                                <div class="col-md-6"> </div>
                            </div>
                        </div>
                </form>
                <!-- END FORM-->
            </div>
        </div>

    </div>
</div>

<!--#include file="/view/tpl/script-beg.shtml"-->
<!--#include file="/view/tpl/script-end.shtml"-->
<script src="<!--#echo var='actionPath' -->js/view/----/${tableClass.variableName}/${tableClass.variableName}-info.js" type="text/javascript"></script>
<!--#include file="/view/tpl/content-end.shtml"-->
                                                                              
