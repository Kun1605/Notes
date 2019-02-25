<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:if test="${!moduleInfo.hideInMenu}">
<sec:authorize access="hasPermission(#moduleInfo, '')">
<c:choose>
    <c:when test="${moduleInfo.haveSubMenuCommand()}">
        <li class="dropdown-submenu">
            <a class="dropdown-toggle menu-user" data-toggle="dropdown"
               href="<s:url value="${moduleInfo.inletUri}"/>">${moduleInfo.value}</a>
            <ul id="menu-com-${moduleInfo.moduleKey}" class="dropdown-menu menu-component">
                <c:forEach items="${moduleInfo.commandList}" var="commandInfo">
                    <c:if test="${commandInfo.isShowInMenu()}">
                        <sec:authorize access="hasPermission(#commandInfo, '')">
                <li><a class="menu-newarticle" href="<s:url value="${commandInfo.path}"/>">${commandInfo.alias}</a></li>
                        </sec:authorize>
                    </c:if>
                </c:forEach>
            </ul>
        </li>
    </c:when>
    <c:otherwise>
        <li><a class="menu-clear" href="<s:url value="${moduleInfo.inletUri}" />">${moduleInfo.value}</a></li>
    </c:otherwise>
</c:choose>
</sec:authorize>
</c:if>