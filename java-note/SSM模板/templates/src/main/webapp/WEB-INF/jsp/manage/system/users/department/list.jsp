<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<c:set var="backURL" value="${pagination.encodedCurrentPageURL}"/>
<s:url value="/manage/system/users/department/list" var="listURL"/>
<s:url value="/manage/system/users/department/detail?backURL=${backURL}" var="detailURL"/>
<s:url value="/manage/system/users/department/edit?backURL=${backURL}" var="editURL"/>
<s:url value="/manage/system/users/department/delete?backURL=${backURL}" var="delURL"/>
<s:url value="/manage/system/users/department/group/list" var="groupListURL"/>
<s:url value="/manage/system/users/department/member/list" var="memberListURL"/>
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
                            <c:set var="searchPath" value="filter[departmentName]"/>
                            <c:set var="hideSearchTools" value="true"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                        </div>
                        <div style="overflow-y: auto;">
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>
                                <th width="1%" class="nowrap center">
                                    <sform:checkall id="checkall-toggle"/>
                                </th>
                                <th width="20%" class="left">
                                    <sg:thlink name="departmentInfo.departmentName" order="a.department_name" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentInfo.departmentMemo" order="a.department_memo" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentInfo.status" order="a.status" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap hidden-phone"><s:message code="departmentInfo.groupCount"/></th>
                                <th width="10%" class="nowrap hidden-phone"><s:message code="departmentInfo.memberCount"/></th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentInfo.createTime" order="a.create_time" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="1%" class="nowrap hidden-phone">
                                    <sg:thlink name="departmentInfo.id" order="a.id" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap center">操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <c:set var="columnCount" value="9"/>
                                <td colspan="${columnCount}">
                                    <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
                                </td>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach items="${departmentInfoList}" varStatus="status">
                                <c:set var="departmentInfo" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td class="nowrap center">
                                    <input type="checkbox" id="cb-${departmentInfo.id}" name="id"
                                           value="${departmentInfo.id}" onclick="Joomla.isChecked(this.checked);" />
                                </td>
                                <td class="nowrap">${departmentInfo.departmentName}</td>
                                <td class="nowrap hidden-phone">${departmentInfo.departmentMemo}</td>
                                <td class="nowrap">
                                    <span class="icon-${departmentInfo.status == 1 ? "publish" : "unpublish"}"></span>
                                </td>
                                <td class="nowrap hidden-phone">
                                    <a class="active hasTooltip" href="${groupListURL}?departmentId=${departmentInfo.id}"
                                       title="业务组列表 ${departmentInfo.id}">
                                    <span class="badge">${departmentInfo.groupCount}</span>
                                    </a>
                                </td>
                                <td class="nowrap hidden-phone">
                                    <a class="active hasTooltip" href="${memberListURL}?departmentId=${departmentInfo.id}"
                                       title="成员列表 ${departmentInfo.id}">
                                    <span class="badge">${departmentInfo.memberCount}</span>
                                    </a>
                                </td>
                                <td class="nowrap hidden-phone">${departmentInfo.createTimeStr}</td>
                                <td class="hidden-phone">${departmentInfo.id}</td>
                                <td class="center nowrap">
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'detail')">
                                        <a class="btn btn-micro active hasTooltip" href="${detailURL}&id=${departmentInfo.id}"
                                           title="查看 ${departmentInfo.id}">
                                            <span class="icon-eye-open"></span></a>
                                    </sec:authorize>
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
                                        <a class="btn btn-micro active hasTooltip" href="${editURL}&id=${departmentInfo.id}"
                                           title="编辑 ${departmentInfo.id}">
                                            <span class="icon-edit"></span></a>
                                    </sec:authorize>
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
                                        <a class="btn btn-micro active hasTooltip" id="list-delete-${departmentInfo.id}"
                                           href="${delURL}&id=${departmentInfo.id}" title="删除 ${departmentInfo.id}">
                                            <span class="icon-trash"></span></a>
                                    </sec:authorize>
                                </td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        </div>
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
                    back: "${pagination.currentPageURL}"
                },
                message: {
                    hide_sidebar: "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar: "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip:"<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="departmentInfo.department_name" />",
                    no_item_selected: "<s:message code="JGLOBAL_NO_ITEM_SELECTED"/>",
                    confirm_delete: "<s:message code="JGLOBAL_CONFIRM_DELETE"/>"
                }
            };
            module.initList(config);
        });
    });
</script>
</body>
</html>