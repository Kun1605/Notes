<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<s:url value="/manage/system/log/noticelog/list" var="listURL"/>
<s:url value="/manage/system/log/noticelog/detail?backURL=${pagination.encodedCurrentPageURL}" var="detailURL"/>
<s:url value="/manage/system/log/noticelog/edit?backURL=${pagination.encodedCurrentPageURL}" var="editURL"/>
<s:url value="/manage/system/log/noticelog/delete?backURL=${pagination.encodedCurrentPageURL}" var="delURL"/>
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
                            <c:set var="searchPath" value="filter[username]"/>
                            <c:set var="hideSearchTools" value="true"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                        </div>
                        <div style="overflow-y: auto;">
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>
                                <th width="15%" class="nowrap">
                                    <sg:thlink name="systemNoticeLog.userId" order="a.user_id" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemNoticeLog.noticeType" order="a.notice_type" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemNoticeLog.sendMode" order="a.send_mode" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap" style="text-overflow: ellipsis;overflow: hidden">
                                    <sg:thlink name="systemNoticeLog.sendContent" order="a.send_content" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemNoticeLog.noticeTime" order="a.notice_time" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap center">操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <c:set var="columnCount" value="6"/>
                                <td colspan="${columnCount}">
                                    <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
                                </td>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach items="${systemNoticeLogList}" varStatus="status">
                                <c:set var="systemNoticeLog" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td>
                                    <div class="name break-word">
                                        <a href="${editURL}?id=${systemNoticeLog.id}" title="编辑系统通知记录 ${systemNoticeLog.userId}">
                                        ${systemNoticeLog.username}</a>
                                    </div>
                                </td>
                                <td class="nowrap hidden-phone">${systemNoticeLog.getNoticeTypeDescription()}</td>
                                <td class="nowrap hidden-phone">${systemNoticeLog.getSendModeDescription()}</td>
                                <td class="nowrap" style="text-overflow: ellipsis;overflow: hidden;max-width: 400px">${systemNoticeLog.sendContent}</td>
                                <td class="nowrap hidden-phone">${systemNoticeLog.getNoticeTimeFormat()}</td>
                                <td class="center nowrap">
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'detail')">
                                        <a class="btn btn-micro active hasTooltip" href="${detailURL}&id=${systemNoticeLog.id}"
                                           title="查看 ${systemNoticeLog.id}">
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
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="systemNoticeLog.userId" />",
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