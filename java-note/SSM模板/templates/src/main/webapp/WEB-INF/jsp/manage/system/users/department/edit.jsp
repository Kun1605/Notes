<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/system/users/department/list" var="listURL"/>
<s:url value="/manage/system/users/department/group/list?departmentId=${departmentInfo.id}" var="nextURL"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@ include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/> - ${commandInfo.module.value} - ${commandInfo.value}</title>
    <%@ include file="/WEB-INF/jsp/manage/includes/linksOfEditHead.jsp" %>
    <%@ include file="/WEB-INF/jsp/manage/includes/scriptsOfEditHead.jsp" %>
    <script src="<s:url value="/media/system/js/helpsite.js" />" type="text/javascript"></script>
</head>
<body class="admin com_users view-user layout-edit task- itemid-">
<!-- Top Navigation -->
<%@ include file="/WEB-INF/jsp/manage/includes/topNavigationDisabled.jsp" %>
<!-- Header -->
<%@ include file="/WEB-INF/jsp/manage/includes/header.jsp" %>
<!-- Subheader -->
<c:set var="showApply" value="true"/>
<c:set var="showSave" value="true"/>
<c:set var="showSave2new" value="true"/>
<c:set var="showSave2next" value="true"/>
<c:set var="showNext" value="true"/>
<c:set var="showCancel" value="true"/>
<c:set var="isEdit" value="${departmentInfo.id != null}"/>
<%@ include file="/WEB-INF/jsp/manage/includes/editSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <!-- Begin Sidebar -->
            <div id="sidebar" class="span2">
                <div class="sidebar-nav">
                    <ul class="nav nav-list">
                        <li class="active">
                            <a href="<s:url value="/manage/system/users/department/edit?id=${departmentInfo.id}"/>">部门基本信息</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="<s:url value="/manage/system/users/department/group/list?departmentId=${departmentInfo.id}"/>">业务组</a>
                        </li>
                        <li>
                            <a href="<s:url value="/manage/system/users/department/member/list?departmentId=${departmentInfo.id}"/>">部门成员</a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- End Sidebar -->
            <div class="span10">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <%@ include file="editForm.jsp" %>
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
        require(['app/module'], function(module) {
            var config = {
                url: {
                    list: "${listURL}",
                    next: "${nextURL}",
                    back: "${backURL}"
                }
            };
            module.initEdit(config);
        });
    });
</script>
</body>
</html>