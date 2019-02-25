<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/system/users/department/group/saveMembers" var="saveURL"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@ include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/> - ${commandInfo.module.value} - ${commandInfo.value}</title>
    <link href="<s:url value="/media/multiselect/css/multiselect.css" />" rel="stylesheet" type="text/css"/>
    <link href="<s:url value="/media/multiselect/css/multiselect-ext.css" />" rel="stylesheet" type="text/css"/>
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
<c:set var="showCancel" value="true"/>
<c:set var="isEdit" value="${groupInfo.id != null}"/>
<%@ include file="/WEB-INF/jsp/manage/includes/editSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <form:form commandName="groupInfo" id="edit-form" method="post" name="adminForm"
                           action="${saveURL}" class="form-validate form-horizontal">
                    <fieldset>
                        <legend>${groupInfo.groupName != null ? groupInfo.groupName : ""} 成员设置</legend>
                        <div class="span3 div-multiselect">
                            <select name="nonmembers" id="search" class="form-control" size="8" multiple="multiple">
                                <c:forEach items="${ungroupUserList}" varStatus="status">
                                <c:set var="user" value="${status.current}"/>
                                    <option value="${user.userId}" data-position="${status.index}">${user.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="span2 div-multiselect">
                            <button id="search_rightAll" class="btn btn-small button-multiselect">
                                <span class="icon-rightarrow"></span>
                                <span class="icon-rightarrow"></span></button>
                            <br/>
                            <button id="search_rightSelected" class="btn btn-small button-multiselect">
                                <span class="icon-rightarrow"></span></button>
                            <br/>
                            <button id="search_leftSelected" class="btn btn-small button-multiselect">
                                <span class="icon-leftarrow"></span></button>
                            <br/>
                            <button id="search_leftAll" class="btn btn-small button-multiselect">
                                <span class="icon-leftarrow"></span>
                                <span class="icon-leftarrow"></span></button>
                            <br/>
                        </div>
                        <div class="span3 div-multiselect">
                            <select name="userIdList" id="search_to" class="form-control" size="8" multiple="multiple">
                                <c:forEach items="${groupUserList}" varStatus="status">
                                    <c:set var="user" value="${status.current}"/>
                                    <option value="${user.userId}" data-position="${status.index}">${user.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </fieldset>
                    <input type="hidden" name="task" value="" />
                    <input type="hidden" name="groupId" value="${groupInfo.id}" />
                </form:form>
            </div>
        </div>
        <!-- End Content -->
    </section>
</div>
<!-- Begin Status Module -->
<%@ include file="/WEB-INF/jsp/manage/includes/footer.jsp" %>
<!-- End Status Module -->
<script src="<s:url value="/bootstrap/js/bootstrap.min.js" />" type="text/javascript"></script>
<script src="<s:url value="/media/multiselect/lib/prettify.min.js" />" type="text/javascript"></script>
<script src="<s:url value="/media/multiselect/js/multiselect.min.js" />" type="text/javascript"></script>
<script src="<s:url value="/js/require.js" />"></script>
<script type="text/javascript">
    var __ctx='<%= request.getContextPath() %>';
    require([ __ctx + '/js/config.js'], function() {
        require(['app/module'], function(module) {
            var config = {
                url: {
                    list: "${backURL}",
                    back: "${backURL}"
                }
            };
            module.initEdit(config);

            jQuery(document).ready(function($){
                $('#search').multiselect({
                    search: {
                        left: '<input type="text" name="q" class="form-control" placeholder="按名称查找..." />',
                        right: '<input type="text" name="q" class="form-control" placeholder="按名称查找..." />',
                    }
                });
            });
        });
    });
</script>
</body>
</html>