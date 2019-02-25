<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/privilege/role/list" var="listURL"/>
<s:url value="/manage/privilege/role/saveBusinessPrivilege" var="saveURL"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@ include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/> - ${commandInfo.module.value} - ${commandInfo.value}</title>
    <%@ include file="/WEB-INF/jsp/manage/includes/linksOfEditHead.jsp" %>
    <%@ include file="/WEB-INF/jsp/manage/includes/scriptsOfEditHead.jsp" %>
    <script src="<s:url value="/media/system/js/helpsite.js" />" type="text/javascript"></script>
    <link href="<s:url value="/media/ztree/css/zTreeStyle/zTreeStyle.css" />" rel="stylesheet" type="text/css">
    <script src="<s:url value="/media/ztree/js/jquery.ztree.all.js" />" type="text/javascript"></script>
    <style>
        .ztree * {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 13px;
            color: #333;
        }
    </style>
</head>
<body class="admin com_users view-user layout-edit task- itemid-">
<!-- Top Navigation -->
<%@ include file="/WEB-INF/jsp/manage/includes/topNavigationDisabled.jsp" %>
<!-- Header -->
<%@ include file="/WEB-INF/jsp/manage/includes/header.jsp" %>
<!-- Subheader -->
<c:set var="showApply" value="true"/>
<c:set var="showSave" value="true"/>
<c:set var="showCancel" value="true"/>
<c:set var="isEdit" value="${manageRole.id != null}"/>
<%@ include file="/WEB-INF/jsp/manage/includes/editSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <div class="row-fluid">
                    <!-- Begin Content -->
                    <form id="authorize-form" method="post" name="authorizeForm"
                          action="${saveURL}">
                        <div class="span12">
                            <legend>为角色 ${manageRole.name} 授权可用业务</legend>
                            <ul id="contentTree" class="ztree"></ul>
                        </div>
                        <input type="hidden" name="task" value="" />
                        <input type="hidden" name="id" value="${manageRole.id}" />
                        <input type="hidden" name="privilege" value="${privilege}" />
                        <input type="hidden" name="backURL" value="${backURL}"/>
                    </form>
                    <!-- End Content -->
                </div>
            </div>
        </div>
        <!-- End Content -->
    </section>
</div>
<!-- Begin Status Module -->
<%@ include file="/WEB-INF/jsp/manage/includes/footer.jsp" %>
<!-- End Status Module -->
<script src="<s:url value="/js/require.js" />"></script>
<script type="text/javascript">
    var __ctx='<%= request.getContextPath() %>';
    require([ __ctx + '/js/config.js'], function() {
        require(['app/authorize'], function(authorize) {
            var setting = {
                check: {
                    enable: true,
                    chkboxType: { "Y":"ps", "N":"ps"}
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                }
            };

            var zNodes = ${privilegeTree};

            jQuery(document).ready(function($) {
                $.fn.zTree.init($("#contentTree"), setting, zNodes);
                var config = {
                    url: {
                        list: "${listURL}",
                        back: "${backURL}"
                    },
                    treeObj: $.fn.zTree.getZTreeObj("contentTree")
                };
                authorize.initAuthorize(config);
                if (zNodes.length <= 0) {
                    $("#contentTree").text("请先为角色分配公司权限!");
                }
            });
        });
    });
</script>
</body>
</html>