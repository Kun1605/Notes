<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/privilege/user/list" var="listURL"/>
<s:url value="/manage/privilege/user/companyAuthorize?backURL=${pagination.encodedCurrentPageURL}" var="companyAuthorizeURL"/>
<s:url value="/manage/privilege/user/businessAuthorize?backURL=${pagination.encodedCurrentPageURL}" var="businessAuthorizeURL"/>
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
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <form:form commandName="queryFilter" id="adminForm" name="adminForm" action="${listURL}">
                    <%@ include file="/WEB-INF/jsp/manage/includes/sidebarContainer.jsp" %>
                    <div id="j-main-container" class="span10">
                        <div class="js-stools clearfix">
                            <c:set var="searchPath" value="filter[name]"/>
                            <%@ include file="/WEB-INF/jsp/manage/includes/filter/searchTools.jsp" %>
                            <!-- Filters div -->
                            <div class="js-stools-container-filters clearfix">
                                <div class="js-stools-field-filter">
                                    <s:message code="manageUser.status" var="status_option"/>
                                    <s:message code="JGLOBAL_STATUS_0" var="status_0"/>
                                    <s:message code="JGLOBAL_STATUS_1" var="status_1"/>
                                    <form:select path="filter[status]" id="filter_status" onchange="this.form.submit();">
                                        <form:option value="" label="- ${status_option} -"/>
                                        <form:option value="0" label="${status_0}"/>
                                        <form:option value="1" label="${status_1}"/>
                                    </form:select>
                                </div>
                                <div class="js-stools-field-filter">
                                    <s:message code="manageUser.roles" var="roles_option"/>
                                    <form:select path="filter[roleIdSet]" id="filter_role_id" onchange="this.form.submit();">
                                        <form:option value="" label="- ${roles_option} -"/>
                                        <form:options items="${manageRoleList}" itemValue="id" itemLabel="name"/>
                                    </form:select>
                                </div>
                                <div class="js-stools-field-filter">
                                    <s:message code="manageUser.lastVisitDate" var="range_option"/>
                                    <form:select path="filter[range]" id="filter_range" onchange="this.form.submit();">
                                        <form:option value="" label="- ${range_option} -"/>
                                        <form:options items="${rangeEnum}" itemValue="code" itemLabel="description"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <div style="overflow-y: auto;">
                        <table class="table table-striped" id="userList">
                            <thead>
                            <tr>
                                <c:set var="fullordering" value="${queryFilter.filter.fullordering}"/>
                                <c:set var="columnCount" value="6"/>
                                <th width="1%" class="center">
                                    <sform:checkall id="checkall-toggle"/>
                                </th>
                                <th class="nowrap left">
                                    <sg:thlink name="manageUser.name" order="a.name" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="10%" class="nowrap">
                                    <sg:thlink name="manageUser.username" order="a.username" fullOrdering="${fullordering}"/>
                                </th>
                                <sec:authorize access="hasPermission(#commandInfo.module, 'companyAuthorize')">
                                    <th width="10%" class="nowrap center">公司授权</th>
                                    <c:set var="columnCount" value="${columnCount=columnCount+1}"/>
                                </sec:authorize>
                                <sec:authorize access="hasPermission(#commandInfo.module, 'businessAuthorize')">
                                    <th width="10%" class="nowrap center">业务授权</th>
                                    <c:set var="columnCount" value="${columnCount=columnCount+1}"/>
                                </sec:authorize>
                                <th width="5%" class="nowrap center">
                                    <sg:thlink name="manageUser.status" order="a.status" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="5%" class="nowrap center hidden-phone">
                                    <sg:thlink name="manageUser.phone" order="a.phone" fullOrdering="${fullordering}"/>
                                </th>
                                <th width="15%" class="nowrap hidden-phone">
                                    <sg:thlink name="manageUser.email" order="a.email" fullOrdering="${fullordering}"/>
                                </th>
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
                            <c:forEach items="${manageUserList}" varStatus="status">
                                <c:set var="user" value="${status.current}"/>
                            <tr class="row${status.index % 2}">
                                <td class="center nowrap">
                                    <input type="checkbox" id="cb0" name="id" value="${user.id}" onclick="Joomla.isChecked(this.checked);" /></td>
                                <td>
                                    <div class="nowrap name">${user.name}</div>
                                </td>
                                <td>${user.username}</td>
                                <sec:authorize access="hasPermission(#commandInfo.module, 'companyAuthorize')">
                                <td class="center">
                                    <a class="btn btn-micro active hasTooltip" href="${companyAuthorizeURL}&id=${user.id}"
                                       title="为 用户 ${user.name} 授权可用公司">
                                        <span class="icon-briefcase"></span></a>
                                </td>
                                </sec:authorize>
                                <sec:authorize access="hasPermission(#commandInfo.module, 'businessAuthorize')">
                                    <td class="center">
                                        <a class="btn btn-micro active hasTooltip" href="${businessAuthorizeURL}&id=${user.id}"
                                           title="为 用户 ${user.name} 授权可用业务">
                                            <span class="icon-cube"></span></a>
                                    </td>
                                </sec:authorize>
                                <td class="center">
                                    <%--<a class="btn btn-micro disabled jgrid hasTooltip" title=""><span class="icon-publish"></span></a>--%>
                                    <c:if test="${user.status == 0}">
                                        <span class="icon-unpublish"></span>
                                    </c:if>
                                    <c:if test="${user.status == 1}">
                                        <span class="icon-publish"></span>
                                    </c:if>
                                </td>
                                <td class="center hidden-phone">${user.phone}</td>
                                <td class="hidden-phone break-word">${user.email}</td>
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
        require(['app/manageUser'], function(manageUser) {
            var config = {
                url: {
                    list: "${listURL}",
                    back: "${pagination.getCurrentPageURL()}"
                },
                message: {
                    hide_sidebar : "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar : "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip: "<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="manageUser.name" />",
                    no_item_selected: "<s:message code="JGLOBAL_NO_ITEM_SELECTED"/>",
                    confirm_delete: "<s:message code="JGLOBAL_CONFIRM_DELETE"/>",
                    confirm_create_qrcode: "确认要为选中的用户创建关注用二维码？"
                },
                joomla: {
                    filtersHidden: ${!queryFilter.hasFilter()}
                }
            };
            manageUser.initList(config);
        });
    });
</script>
</body>
</html>