<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<s:url value="/manage/system/users/role/list" var="listURL"/>
<c:set var="backURL" value="${pagination.encodedCurrentPageURL}"/>
<s:url value="/manage/system/users/role/detail?backURL=${backURL}" var="detailURL"/>
<s:url value="/manage/system/users/role/edit?backURL=${backURL}" var="editURL"/>
<s:url value="/manage/system/users/role/updateStatus?backURL=${backURL}" var="updateStatusURL"/>
<s:url value="/manage/system/users/role/delete?backURL=${backURL}" var="delURL"/>
<s:url value="/manage/system/users/role/authorize?backURL=${backURL}" var="authorizeURL"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@ include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/> - ${commandInfo.module.value} - ${commandInfo.value}</title>
    <%@ include file="/WEB-INF/jsp/manage/includes/linksOfListHead.jsp" %>
    <%@ include file="/WEB-INF/jsp/manage/includes/scriptsOfHead.jsp" %>
    <script src="<s:url value="/media/jui/js/jquery.searchtools.min.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/system/js/multiselect.js" />" type="text/javascript"></script>
</head>
<body class="admin com_users view-users layout- task- itemid-">
<!-- Top Navigation -->
<%@ include file="/WEB-INF/jsp/manage/includes/topNavigation.jsp" %>
<!-- Header -->
<%@ include file="/WEB-INF/jsp/manage/includes/header.jsp" %>
<!-- Subheader -->
<sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
<c:set var="showNew" value="true"/>
<c:set var="showEdit" value="true"/>
<c:set var="showBlock" value="true"/>
<c:set var="showUnblock" value="true"/>
</sec:authorize>
<sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
<c:set var="showDelete" value="true"/>
</sec:authorize>
<%@ include file="/WEB-INF/jsp/manage/includes/listSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <form:form modelAttribute="queryFilter" id="adminForm" name="adminForm" action="${listURL}">
                    <%@ include file="/WEB-INF/jsp/manage/includes/sidebarContainer.jsp" %>
                    <div id="j-main-container" class="span10">
                        <div class="js-stools clearfix">
                            <c:set var="searchPath" value="filter[name]"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                            <!-- Filters div -->
                            <div class="js-stools-container-filters clearfix">
                                <div class="js-stools-field-filter">
                                    <s:message code="manageRole.status" var="status_option"/>
                                    <s:message code="JGLOBAL_STATUS_0" var="status_0"/>
                                    <s:message code="JGLOBAL_STATUS_1" var="status_1"/>
                                    <form:select path="filter[status]" id="filter_status" onchange="this.form.submit();">
                                        <form:option value="" label="- ${status_option} -"/>
                                        <form:option value="0" label="${status_0}"/>
                                        <form:option value="1" label="${status_1}"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>
                                <c:set var="columnCount" value="7"/>
                                <th width="1%" class="center">
                                    <sform:checkall id="checkall-toggle"/>
                                </th>
                                <th class="nowrap left">
                                    <sg:thlink name="manageRole.name" order="a.name" fullOrdering="${fullordering}"/>
                                </th>
                                <th class="nowrap">
                                    <s:message code="manageRole.manager"/>
                                </th>
                                <sec:authorize access="hasPermission(#commandInfo.module, 'authorize')">
                                <th width="10%" class="nowrap center">模块授权</th>
                                <c:set var="columnCount" value="${columnCount=columnCount+1}"/>
                                </sec:authorize>
                                <th width="5%" class="nowrap center">
                                    <sg:thlink name="manageRole.status" order="a.status" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap center hidden-phone"><s:message code="manageRole.userCount"/></th>
                                <th width="15%" class="nowrap hidden-phone"><s:message code="manageRole.memo"/></th>
                                <th width="15%" class="nowrap center">操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <td colspan="${columnCount}">
                                    <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
                                </td>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach items="${manageRoleList}" varStatus="status">
                                <c:set var="role" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td class="center">
                                    <input type="checkbox" id="cb0" name="id" value="${role.id}" onclick="Joomla.isChecked(this.checked);" /></td>
                                <td>
                                    <div class="name">${role.name}</div>
                                </td>
                                <td>
                                    <div class="name">${role.managerDescription}</div>
                                </td>
                                <sec:authorize access="hasPermission(#commandInfo.module, 'authorize')">
                                <td class="center">
                                    <a class="btn btn-micro active hasTooltip" href="${authorizeURL}&id=${role.id}"
                                       title="为 角色 ${role.name} 授权可用模块">
                                        <span class="icon-cog"></span></a>
                                </td>
                                </sec:authorize>
                                <td class="center">
                                    <span class="icon-${role.status == 1 ? "publish" : "unpublish"}"></span>
                                </td>
                                <td class="center hidden-phone"><span class="badge">${role.userCount}</span></td>
                                <td class="hidden-phone">${role.memo}</td>
                                <td class="center nowrap">
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'detail')">
                                        <a class="btn btn-micro active hasTooltip" href="${detailURL}&id=${role.id}"
                                           title="查看角色 ${role.name}">
                                            <span class="icon-eye-open"></span></a>
                                    </sec:authorize>
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
                                        <a class="btn btn-micro active hasTooltip" href="${editURL}&id=${role.id}"
                                           title="编辑角色 ${role.name}">
                                            <span class="icon-edit"></span></a>
                                    </sec:authorize>
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
                                        <a class="btn btn-micro active hasTooltip" id="list-delete-${role.id}"
                                           href="${delURL}&id=${role.id}" title="删除角色 ${role.name}">
                                            <span class="icon-trash"></span></a>
                                    </sec:authorize>
                                </td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <input type="hidden" name="task" value="" />
                        <input type="hidden" name="boxchecked" value="0" />
                    </div>
                </form:form>
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
    require(['<s:url value="/js/config.js" />'], function() {
        require(['app/module'], function(module) {
            var config = {
                url: {
                    list: "${listURL}",
                    add: "${editURL}",
                    edit: "${editURL}",
                    block: "${updateStatusURL}",
                    unblock: "${updateStatusURL}",
                    del: "${delURL}",
                    back: "${pagination.getCurrentPageURL()}"
                },
                message: {
                    hide_sidebar: "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar: "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip:"<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="manageRole.name" />",
                    no_item_selected: "<s:message code="JGLOBAL_NO_ITEM_SELECTED"/>",
                    confirm_delete: "<s:message code="JGLOBAL_CONFIRM_DELETE"/>"
                },
                joomla: {
                    filtersHidden: ${!queryFilter.hasFilter()}
                }
            };
            module.initList(config);
        });
    });
</script>
</body>
</html>