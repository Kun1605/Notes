<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<s:url value="/manage/system/users/department/member/selectUser" var="selectURL"/>
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
<body class="contentpane component">
<%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
<form:form commandName="queryFilter" id="adminForm" name="adminForm" action="${selectURL}">
    <fieldset class="filter">
        <div id="filter-bar" class="btn-toolbar">
            <s:message code="JSEARCH_FILTER" var="searchFilter"/>
            <div class="filter-search btn-group pull-left">
                <label for="filter_search" class="element-invisible">${searchFilter}</label>
                <form:input path="filter[name]" id="filter_search" data-placement="bottom"
                            cssClass="hasTooltip" placeholder="${searchFilter}"/>
            </div>
            <div class="btn-group pull-left">
                <button type="submit" class="btn hasTooltip" title="<s:message code="JSEARCH_FILTER_SUBMIT"/>"
                        data-placement="bottom">
                    <span class="icon-search"></span></button>
                <button type="button" class="btn hasTooltip" title="<s:message code="JSEARCH_FILTER_CLEAR"/>"
                        data-placement="bottom" onclick="document.getElementById('filter_search').value='';this.form.submit();">
                    <span class="icon-remove"></span></button>
                <button type="button" class="btn button-select" data-user-value="0" data-user-name="选择一个部门成员"
                        data-user-field="jform_userId">- 没有部门成员 -</button>
            </div>
        </div>
    </fieldset>
    <table class="table table-striped table-condensed">
        <thead>
        <tr>
            <th class="left">
                <sg:thlink name="manageUser.name" order="a.name" fullOrdering="${fullordering}"/>
            </th>
            <th width="25%" class="nowrap">
                <sg:thlink name="manageUser.email" order="a.email" fullOrdering="${fullordering}"/>
            </th>
        </tr>
        </thead>
        <tfoot>
        <tr>
            <c:set var="columnCount" value="3"/>
            <td colspan="${columnCount}">
                <%@ include file="/WEB-INF/jsp/manage/includes/pagination.jsp" %>
            </td>
        </tr>
        </tfoot>
        <tbody>
        <c:forEach items="${manageUserList}" varStatus="status">
            <c:set var="manageUser" value="${status.current}"/>
            <tr class="row${status.index % 2}">
                <td>
                    <a class="pointer button-select" href="#" data-user-value="${manageUser.id}"
                       data-user-name="${manageUser.name}" data-user-field="jform_userName">
                            ${manageUser.name}</a>
                </td>
                <td>${manageUser.email}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div>
        <input type="hidden" name="task" value="" />
        <input type="hidden" name="field" value="jform_userId" />
        <input type="hidden" name="boxchecked" value="0" />
        <form:hidden path="filter[fullordering]" />
        <form:hidden path="filter[departmentId]" />
</form:form>
<!-- End Status Module -->
<script src="<s:url value="/js/require.js" />"></script>
<script type="text/javascript">
    var __ctx='<%= request.getContextPath() %>';
    require(['<s:url value="/js/config.js" />'], function() {
        require(['app/module'], function(module) {
            var config = {
                url: {
                    list: "${listURL}"
                },
                message: {
                    hide_sidebar: "<s:message code="JTOGGLE_HIDE_SIDEBAR" />",
                    show_sidebar: "<s:message code="JTOGGLE_SHOW_SIDEBAR" />",
                    multiple_tip: "<s:message code="JSELECT_MULTIPLE" />",
                    single_tip:"<s:message code="JSELECT_SINGLE" />",
                    no_results_tip: "<s:message code="JSELECT_NO_RESULTS" />",
                    filter_search_tip: "<sg:message code="JSEARCH_TITLE" ref="manageUser.name" />",
                    no_item_selected: "<s:message code="JGLOBAL_NO_ITEM_SELECTED"/>",
                    confirm_delete: "<s:message code="JGLOBAL_CONFIRM_DELETE"/>"
                },
                joomla: {
                    filtersHidden: ${!queryFilter.hasFilter()},
                    showSidebar: false
                }
            };
            module.initList(config);
        });
    });
</script>
</body>
</html>