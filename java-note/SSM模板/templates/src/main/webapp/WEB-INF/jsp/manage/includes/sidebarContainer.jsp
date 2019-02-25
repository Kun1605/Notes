<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div id="j-sidebar-container" class="span2">
    <div id="j-toggle-sidebar-wrapper">
        <div id="j-toggle-button-wrapper" class="j-toggle-button-wrapper">
            <div id="j-toggle-sidebar-button"
                 class="j-toggle-sidebar-button hidden-phone hasTooltip"
                 title="<s:message code="JTOGGLE_HIDE_SIDEBAR" />" type="button"
                 onclick="toggleSidebar(false); return false;">
                <span id="j-toggle-sidebar-icon" class="icon-arrow-left-2"></span>
            </div>
        </div>
        <div id="sidebar" class="sidebar">
            <div class="sidebar-nav">
                <ul id="submenu" class="nav nav-list">
                    <c:if test="${commandInfo.module != null && commandInfo.module.menu != null}">
                        <c:forEach items="${commandInfo.module.menu.moduleList}" var="moduleInfo">
                            <c:if test="${!moduleInfo.hideInMenu}">
                                <sec:authorize access="hasPermission(#moduleInfo, '')">
                    <li class="${moduleInfo.inletUri.equals(commandInfo.path) ? "active" : ""}">
                        <a href="<s:url value="${moduleInfo.inletUri}" />">${moduleInfo.value}</a>
                    </li>
                                </sec:authorize>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        </div>
        <div id="j-toggle-sidebar"></div>
    </div>
</div>