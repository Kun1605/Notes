<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<s:url value="/manage/system/log/notice/list" var="listURL"/>
<s:url value="/manage/system/log/notice/detail?backURL=${pagination.encodedCurrentPageURL}" var="detailURL"/>
<s:url value="/manage/system/log/notice/edit?backURL=${pagination.encodedCurrentPageURL}" var="editURL"/>
<s:url value="/manage/system/log/notice/delete?backURL=${pagination.encodedCurrentPageURL}" var="delURL"/>
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
    <c:set var="showBatch" value="true"/>
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
                            <c:set var="searchPath" value="filter[userId]"/>
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
                                <th width="15%" class="left">
                                    <sg:thlink name="systemNoticeConfig.userId" order="a.user_id" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap">
                                    <sg:thlink name="manageUser.email" order="a.email" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap">
                                    <sg:thlink name="manageUser.phone" order="a.phone" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap">
                                    <sg:thlink name="systemNoticeConfig.noticeType" order="a.notice_type" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap">
                                    <sg:thlink name="systemNoticeConfig.receiveEmail" order="a.receive_email" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap">
                                    <sg:thlink name="systemNoticeConfig.receiveWechat" order="a.receive_wechat" fullOrdering="${fullordering}"/>
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
                            <c:forEach items="${systemNoticeConfigList}" varStatus="status">
                                <c:set var="systemNoticeConfig" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td class="nowrap center">
                                    <input type="checkbox" id="cb-${systemNoticeConfig.id}" name="id"
                                           value="${systemNoticeConfig.id}" onclick="Joomla.isChecked(this.checked);" />
                                </td>
                                <td>
                                    <div class="name break-word">
                                        <a href="${editURL}?id=${systemNoticeConfig.id}" title="编辑系统通知配置 ${systemNoticeConfig.username}">
                                        ${systemNoticeConfig.username}</a>
                                    </div>
                                </td>
                                <td class="nowrap">${systemNoticeConfig.email}</td>
                                <td class="nowrap">${systemNoticeConfig.phone}</td>
                                <td class="nowrap hidden-phone">${systemNoticeConfig.noticeTypeDescription}</td>
                                <td class="center">
                                    <c:if test="${systemNoticeConfig.receiveEmail == 0}">
                                        <span class="icon-unpublish"></span>
                                    </c:if>
                                    <c:if test="${systemNoticeConfig.receiveEmail == 1}">
                                        <span class="icon-publish"></span>
                                    </c:if>
                                </td>
                                <td class="center">
                                    <c:if test="${systemNoticeConfig.receiveWechat == 0}">
                                        <span class="icon-unpublish"></span>
                                    </c:if>
                                    <c:if test="${systemNoticeConfig.receiveWechat == 1}">
                                        <span class="icon-publish"></span>
                                    </c:if>
                                </td>
                                <td class="center nowrap">
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'detail')">
                                        <a class="btn btn-micro active hasTooltip" href="${detailURL}&id=${systemNoticeConfig.id}"
                                           title="查看 ${systemNoticeConfig.id}">
                                            <span class="icon-eye-open"></span></a>
                                    </sec:authorize>
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
                                        <a class="btn btn-micro active hasTooltip" href="${editURL}&id=${systemNoticeConfig.id}"
                                           title="编辑 ${systemNoticeConfig.id}">
                                            <span class="icon-edit"></span></a>
                                    </sec:authorize>
                                    <sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
                                        <a class="btn btn-micro active hasTooltip" id="list-delete-${systemNoticeConfig.id}"
                                           href="${delURL}&id=${systemNoticeConfig.id}" title="删除 ${systemNoticeConfig.id}">
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
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="systemNoticeConfig.userId" />",
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