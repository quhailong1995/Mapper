<!--#include file="/view/tpl/header-beg.shtml"-->
<!--#include file="/view/tpl/header-end.shtml"-->
<!--#include file="/view/tpl/content-beg.shtml"-->

<div class="wrapper-sm">
    <div class="row wrapper" id="bssContent">

        <div class="portlet box green">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-pencil-square-o"></i>${tableClass.shortClassName}编辑
                </div>
                <div class="tools">
                    <a href="javascript:;" class="collapse" data-original-title="" title="收拢/展开"> </a>
                    <a href="javascript:;" class="reload" data-original-title="" title="刷新" @click="info"> </a>
                </div>
            </div>
            <div class="portlet-body form">
                <!-- BEGIN FORM-->
                <form class="form-horizontal" id="editForm">
                    <div class="form-body">
                        <div class="alert alert-danger display-hide">
                            <button class="close" data-close="alert"></button> 表单有一些错误，请检查下面
                        </div>
                        <div class="alert alert-success display-hide">
                            <button class="close" data-close="alert"></button> 表单验证成功!
                        </div>
                <#if tableClass.baseFields??>
                    <#list tableClass.allFields as field>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">${field.remarks}<span class="required"> * </span></label>
                                    <div class="col-md-9">
                                        <div class="show-error" >
                                            <input type="text" class="form-control" placeholder="${field.remarks}" name="${field.fieldName}" v-model="data.${field.fieldName}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">分类<span class="required"> * </span></label>
                                    <div class="col-md-9">
                                        <div class="show-error" >
                                            <select class="form-control" placeholder="分类" name="catCd" v-model="data.catCd">
                                                <option v-for="item in catCodes" v-bind:value="item.cd">
                                                    {{ item.nm }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">是否<span class="required"> * </span></label>
                                    <div class="col-md-9">
                                        <div class="show-error" >
                                            <select class="form-control" placeholder="是否" id="hasBig" name="hasBig" v-model="data.hasBig" @change="isBigChg(data.hasBig)">
                                                <option value="1">是</option>
                                                <option value="0">否</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <button type="submit" class="btn green">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
<script src="<!--#echo var='actionPath' -->js/view/----/${tableClass.variableName}/${tableClass.variableName}-form.js" type="text/javascript"></script>
<!--#include file="/view/tpl/content-end.shtml"-->
                                                                              
