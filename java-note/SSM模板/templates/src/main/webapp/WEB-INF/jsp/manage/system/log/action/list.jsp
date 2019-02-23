<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<s:url value="/manage/system/log/action/list" var="listURL"/>
<s:url value="/manage/system/log/action/detail?backURL=${pagination.encodedCurrentPageURL}" var="detailURL"/>
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
                            <c:set var="hideSearchTools" value="true"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                        </div>
                        <div style="overflow-y: auto;">
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>

                                <th width="15%" class="nowrap">
                                    <sg:thlink name="commandLog.name" order="a.name" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.commandName" order="a.command_name" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.moduleName" order="a.module_name" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.requestPath" order="a.request_path" fullOrdering="${fullordering}"/>
                                </th>
                                <%--<th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.parameters" order="a.parameters" fullOrdering="${fullordering}"/>
                                </th>--%>
                                <th width="10%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.resultSuccesss" order="a.result_successs" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.resultMessage" order="a.result_message" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap hidden-phone">
                                    <sg:thlink name="commandLog.actionTime" order="a.action_time" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap center">操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <c:set var="columnCount" value="14"/>
                                <td colspan="${columnCount}">
                                    <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
                                </td>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach items="${commandLogList}" varStatus="status">
                                <c:set var="commandLog" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td class="nowrap">${commandLog.name}</td>
                                <td class="nowrap">${commandLog.commandName}</td>
                                <td class="nowrap hidden-phone">${commandLog.moduleName}</td>
                                <td class="nowrap hidden-phone">${commandLog.requestPath}</td>
                                <%--<td class="nowrap hidden-phone">${commandLog.parameters}</td>--%>
                                <td class="center">
                                    <c:if test="${commandLog.resultSuccesss == 0}">
                                        <span class="icon-unpublish"></span>
                                    </c:if>
                                    <c:if test="${commandLog.resultSuccesss == 1}">
                                        <span class="icon-publish"></span>
                                    </c:if>
                                </td>
                                <td class="left">${commandLog.resultMessage}</td>
                                <td class="nowrap hidden-phone">${commandLog.getActionTimeFullFormat()}</td>
                                <td class="center nowrap">
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'detail')">
                                        <a class="btn btn-micro active hasTooltip" href="${detailURL}&id=${commandLog.id}"
                                           title="查看 ${commandLog.id}">
                                            <span class="icon-eye-open"></span></a>
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
                    back: "${pagination.currentPageURL}"
                },
                message: {
                    hide_sidebar: "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar: "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip:"<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="commandLog.name" />",
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