<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<s:url value="/manage/system/log/error/list" var="listURL"/>
<s:url value="/manage/system/log/error/detail?backURL=${pagination.encodedCurrentPageURL}" var="detailURL"/>
<s:url value="/manage/system/log/error/edit" var="editURL"/>
<s:url value="/manage/system/log/error/delete" var="delURL"/>
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
<c:set var="showDelete" value="true"/>
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
                            <c:set var="searchPath" value="filter[title]"/>
                            <c:set var="hideSearchTools" value="true"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                        </div>
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>
                                <th width="1%" class="nowrap center">
                                    <sform:checkall id="checkall-toggle"/>
                                </th>
                                <th width="20%" class="left">
                                    <sg:thlink name="systemMessage.title" order="a.title" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemMessage.messageLevel" order="a.message_level" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemMessage.messageModule" order="a.message_module" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemMessage.messageLine" order="a.message_line" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="20%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemMessage.messageTime" order="a.message_time" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="1%" class="nowrap hidden-phone">
                                    <sg:thlink name="systemMessage.id" order="a.id" fullOrdering="${fullordering}"/>
                                </th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <c:set var="columnCount" value="8"/>
                                <td colspan="${columnCount}">
                                    <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
                                </td>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach items="${systemMessageList}" varStatus="status">
                                <c:set var="systemMessage" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td class="center">
                                    <input type="checkbox" id="cb-${systemMessage.id}" name="id"
                                           value="${systemMessage.id}" onclick="Joomla.isChecked(this.checked);" />
                                </td>
                                <td>
                                    <div class="name break-word">
                                        <a href="${detailURL}&id=${systemMessage.id}" title="查看系统错误日志 ${systemMessage.title}">
                                        ${systemMessage.title}</a>
                                    </div>
                                </td>
                                <td class="hidden-phone">${systemMessage.messageLevelDescription}</td>
                                <td class="hidden-phone">${systemMessage.messageModule}</td>
                                <td class="hidden-phone">${systemMessage.messageLine}</td>
                                <td class="hidden-phone">${systemMessage.messageTimeStr}</td>
                                <td class="hidden-phone">${systemMessage.id}</td>
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
                    del: "${delURL}",
                    back: "${pagination.currentPageURL}"
                },
                message: {
                    hide_sidebar: "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar: "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip:"<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="systemMessage.title" />",
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