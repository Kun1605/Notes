<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<c:set var="backURL" value="${pagination.encodedCurrentPageURL}"/>
<s:url value="/manage/system/users/department/member/list?departmentId=${departmentInfo.id}" var="listURL"/>
<s:url value="/manage/system/users/department/member/edit?backURL=${backURL}" var="editURL"/>
<s:url value="/manage/system/users/department/member/delete?backURL=${backURL}" var="delURL"/>
<s:url value="/manage/system/users/department/list" var="departmentURL"/>
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
</sec:authorize>
<sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
    <c:set var="showDelete" value="true"/>
</sec:authorize>
<c:set var="showBack" value="true"/>
<%@ include file="/WEB-INF/jsp/manage/includes/listSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <form:form modelAttribute="queryFilter" id="adminForm" name="adminForm" action="${listURL}">
                    <div id="j-sidebar-container" class="span2">
                        <div class="sidebar-nav">
                            <ul class="nav nav-list">
                                <li>
                                    <a href="<s:url value="/manage/system/users/department/edit?id=${departmentInfo.id}"/>">部门基本信息</a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="<s:url value="/manage/system/users/department/group/list?departmentId=${departmentInfo.id}"/>">业务组</a>
                                </li>
                                <li class="active">
                                    <a href="<s:url value="/manage/system/users/department/member/list?departmentId=${departmentInfo.id}"/>">部门成员</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div id="j-main-container" class="span10">
                        <legend>${departmentInfo.departmentName} 部门成员列表</legend>
                        <div class="js-stools clearfix">
                            <c:set var="searchPath" value="filter[userName]"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                            <!-- Filters div -->
                            <div class="js-stools-container-filters clearfix">
                            <div class="js-stools-field-filter">
                                <s:message code="departmentUser.userPosition" var="userPosition_option"/>
                                <form:select path="filter[userPosition]" id="filter_userPosition" onchange="this.form.submit();">
                                    <form:option value="" label="- ${userPosition_option} -"/>
                                    <form:options items="${userPositionEnum}" itemValue="value" itemLabel="description" />
                                </form:select>
                            </div>
                            </div>
                        </div>
                        <div style="overflow-y: auto;">
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>
                                <th width="1%" class="nowrap center">
                                    <sform:checkall id="checkall-toggle"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentUser.userId" order="a.user_id" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentUser.userName" order="user_name" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentUser.userPosition" order="a.user_position" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentUser.assignTime" order="a.assign_time" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="1%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentUser.id" order="a.id" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap center">操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <c:set var="columnCount" value="7"/>
                                <td colspan="${columnCount}">
                                    <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
                                </td>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach items="${departmentUserList}" varStatus="status">
                                <c:set var="departmentUser" value="${status.current}"/>
                                <tr class="row${status.index % 2}">
                                    <td class="nowrap center">
                                        <input type="checkbox" id="cb-${departmentUser.id}" name="id"
                                               value="${departmentUser.id}" onclick="Joomla.isChecked(this.checked);" />
                                    </td>
                                    <td class="nowrap hidden-phone">${departmentUser.userId}</td>
                                    <td class="nowrap">${departmentUser.userName}</td>
                                    <td class="nowrap hidden-phone">${departmentUser.userPositionDescription}</td>
                                    <td class="nowrap hidden-phone">${departmentUser.assignTimeStr}</td>
                                    <td class="hidden-phone">${departmentUser.id}</td>
                                    <td class="center nowrap">
                                        <sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
                                            <a class="btn btn-micro active hasTooltip"
                                               href="${editURL}&id=${departmentUser.id}&departmentId=${departmentInfo.id}"
                                               title="编辑 ${departmentUser.id}">
                                                <span class="icon-edit"></span></a>
                                        </sec:authorize>
                                        <sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
                                            <a class="btn btn-micro active hasTooltip"
                                               id="list-delete-${departmentUser.id}"
                                               href="${delURL}&id=${departmentUser.id}&departmentId=${departmentInfo.id}"
                                               title="删除 ${departmentUser.id}">
                                                <span class="icon-trash"></span></a>
                                        </sec:authorize>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        </div>
                        <input type="hidden" name="departmentId" value="${departmentInfo.id}" />
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
                    del: "${delURL}",
                    back: "${departmentURL}"
                },
                message: {
                    hide_sidebar: "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar: "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip:"<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="departmentUser.userName" />",
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