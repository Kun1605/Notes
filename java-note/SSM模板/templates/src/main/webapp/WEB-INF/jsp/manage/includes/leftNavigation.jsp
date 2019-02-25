<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="span3">
    <div class="cpanel-links">
        <div class="sidebar-nav quick-icons">
            <div class="j-links-groups">
                <c:if test="${moduleTree != null}">
                    <c:forEach items="${moduleTree.rootMenuList}" var="menuInfo">
                        <sec:authorize access="hasPermission(#menuInfo, '')">
                            <h2 class="nav-header">${menuInfo.value}</h2>
                            <ul class="j-links-group nav nav-list">
                                <c:forEach items="${menuInfo.subMenuList}" var="subMenu">
                                    <c:forEach items="${subMenu.moduleList}" var="moduleInfo">
                                        <c:if test="${!moduleInfo.hideInMenu}">
                                            <sec:authorize access="hasPermission(#moduleInfo, '')">
                                                <li>
                                                    <a href="<s:url value="${moduleInfo.inletUri}"/>">
                                                        <span class="icon-${moduleInfo.icon}"></span>
                                                        <span class="j-links-link">${moduleInfo.value}</span>
                                                    </a>
                                                </li>
                                            </sec:authorize>
                                        </c:if>
                                    </c:forEach>
                                    <li class="divider"><span></span></li>
                                </c:forEach>
                                <c:forEach items="${menuInfo.moduleList}" var="moduleInfo">
                                    <c:if test="${!moduleInfo.hideInMenu}">
                                        <sec:authorize access="hasPermission(#moduleInfo, '')">
                                            <li>
                                                <a href="<s:url value="${moduleInfo.inletUri}"/>">
                                                    <span class="icon-${moduleInfo.icon}"></span>
                                                    <span class="j-links-link">${moduleInfo.value}</span>
                                                </a>
                                            </li>
                                        </sec:authorize>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </sec:authorize>
                    </c:forEach>
                    <c:if test="${moduleTree.rootModuleList.size() > 0}">
                        <h2 class="nav-header">--------</h2>
                        <ul class="j-links-group nav nav-list">
                            <c:forEach items="${moduleTree.rootModuleList}" var="moduleInfo">
                                <c:if test="${!moduleInfo.hideInMenu}">
                                    <sec:authorize access="hasPermission(#moduleInfo, '')">
                                        <li>
                                            <a href="<s:url value="${moduleInfo.inletUri}"/>">
                                                <span class="icon-${moduleInfo.icon}"></span>
                                                <span class="j-links-link">${moduleInfo.value}</span>
                                            </a>
                                        </li>
                                    </sec:authorize>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
</div>