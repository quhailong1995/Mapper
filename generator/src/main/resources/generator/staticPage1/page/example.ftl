<!--#include file="/view/tpl/header-beg.shtml"-->
<!--#include file="/view/tpl/header-end.shtml"-->
<!--#include file="/view/tpl/content-beg.shtml"-->
   <div class="wrapper-sm">
        <div class="row wrapper" id="bssContent">
                                                                            
            <div class="col-sm-8 m-b-xs">
                <form id="searchForm" class="form-inline" role="form" @keyup.enter="search">
                <#if tableClass.baseFields??>
                    <#list tableClass.allFields as field>
                    <div class="form-group m-r-xs">
                        <input class="form-control input-sm" placeholder="${field.remarks}" name="${field.fieldName}" v-model="params.${field.fieldName}">
                    </div>
                    </#list>
                </#if>
                    <div class="form-group m-r-xs"><span>是否审核:</span>
                        <select class="form-control" name="check" v-model="params.check" >
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </div>
                    <a class="btn btn-sm btn-default" @click="search"><i class="fa fa-search"></i>搜索</a>
                    <a class="btn btn-sm btn-default" @click="reload"><i class="fa fa-refresh"></i>刷新</a>
                </form>
            </div>
            <div class="col-sm-4">
                <a class="btn btn-sm btn-primary m-r-md" @click="add"><i class="fa fa-plus"></i>新建</a>
                <a class="btn btn-sm btn-warning m-r-md" @click="upd"><i class="fa fa-pencil-square-o"></i>修改</a>
                <a class="btn btn-sm btn-danger m-r-md"  @click="del"><i class="fa fa-trash-o"></i>删除</a>
            </div>
        </div>
                                                                            
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover table-checkable order-column
                    dataTable table-header-fixed js-standby" id="bssTable">
                <thead>
                    <tr>
                        <th>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="group-checkable" data-set="#bssTable .checkboxes" />
                                <span></span>
                            </label>
                        </th>
                    <#if tableClass.baseFields??>
                        <#list tableClass.allFields as field>
                        <th ui-order-column="${field.fieldName}" <#--style="text-align: center"-->>${field.remarks}</th>
                        </#list>
                    </#if>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
                                                                            
    </div>
<!--#include file="/view/tpl/script-beg.shtml"-->
<!--#include file="/view/tpl/script-end.shtml"-->
<script src="<!--#echo var='actionPath' -->js/--------/${tableClass.variableName}.js" type="text/javascript"></script>
<!--#include file="/view/tpl/content-end.shtml"-->
                                                                              
