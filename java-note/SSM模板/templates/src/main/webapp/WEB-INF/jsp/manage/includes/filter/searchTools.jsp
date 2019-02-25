<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<div class="clearfix">
    <div class="js-stools-container-bar">
        <s:message code="JSEARCH_FILTER" var="searchFilter"/>
        <label for="filter_search" class="element-invisible">${searchFilter}</label>
        <div class="btn-wrapper input-append">
            <form:input path="${searchPath}" id="filter_search"
                        cssClass="js-stools-search-string" placeholder="${searchFilter}"/>
            <button type="submit" class="btn hasTooltip" title="<s:message code="JSEARCH_FILTER_SUBMIT"/>">
                <span class="icon-search"></span>
            </button>
        </div>
        <c:if test="${!hideSearchTools}">
        <div class="btn-wrapper ">
            <button type="button" class="btn hasTooltip js-stools-btn-filter"
                    title="<s:message code="JSEARCH_TOOLS_DESC"/>">
                <s:message code="JSEARCH_TOOLS"/><span class="caret"></span>
            </button>
        </div>
        </c:if>
        <div class="btn-wrapper">
            <button type="button" class="btn hasTooltip js-stools-btn-clear"
                    title="<s:message code="JSEARCH_FILTER_CLEAR"/>">
                <s:message code="JSEARCH_FILTER_CLEAR"/></button>
        </div>
        <c:if test="${showBatchPhone}">
            <div class="btn-wrapper" id="toolbar-produce">
                <button id="toolbar-button-produce" class="btn hasTooltip"
                        type="button" title="<s:message code="JTOOLBAR_BATCH"/>">
                    <s:message code="JTOOLBAR_BATCH"/></button>
            </div>
        </c:if>
        <c:if test="${showDownload}">
        <div class="btn-wrapper" id="toolbar-download">
            <button id="toolbar-button-download" class="btn hasTooltip"
                    title="<s:message code="JTOOLBAR_DOWNLOAD"/>">
                <span class="icon-download"></span>
                <s:message code="JTOOLBAR_DOWNLOAD"/></button>
        </div>
        </c:if>
        <c:if test="${showUpload}">
        <div class="btn-wrapper" id="toolbar-upload">
            <button id="toolbar-button-upload" class="btn hasTooltip"
                    title="<s:message code="JTOOLBAR_UPLOAD"/>">
                <span class="icon-upload"></span>
                <s:message code="JTOOLBAR_UPLOAD"/></button>
        </div>
        </c:if>
        <c:if test="${showPageDownload}">
            <div class="btn-wrapper" id="toolbar-pagedownload">
                <button id="toolbar-button-pagedownload" class="btn hasTooltip"
                        title="<s:message code="JTOOLBAR_PAGEDOWNLOAD"/>">
                    <span class="icon-download"></span>
                    <s:message code="JTOOLBAR_PAGEDOWNLOAD"/></button>
            </div>
        </c:if>
    </div>
    <div class="js-stools-container-list hidden-phone hidden-tablet">
        <div class="ordering-select hidden-phone">
            <div class="js-stools-field-list">
                <form:select path="filter[fullordering]" id="list_fullordering" onchange="this.form.submit();">
                    <option value=""><s:message code="JSEARCH_TOOLS_ORDERING"/></option>
                    <form:options items="${orderingEnum}" itemValue="value" itemLabel="description" />
                </form:select>
            </div>
            <div class="js-stools-field-list">
                <form:select path="pagination.pageSize" id="list_limit" cssClass="input-mini" onchange="this.form.submit();">
                    <form:options items="${limitEnum}" itemValue="id" itemLabel="description"/>
                </form:select>
            </div>
        </div>
    </div>
</div>