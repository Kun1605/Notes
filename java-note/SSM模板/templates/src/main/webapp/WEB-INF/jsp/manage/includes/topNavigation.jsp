<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a href="#" class="btn btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="admin-logo " href="<s:url value="/manage/index" />">
                <span class="icon-joomla"></span></a>
            <a class="brand hidden-desktop hidden-tablet" href="<s:url value="/manage/index" />"
               title="<s:message code="system.name"/>" target="_blank">
                <s:message code="system.name"/><span class="icon-out-2 small"></span>
            </a>
            <div class="nav-collapse collapse">
                <ul id="menu" class="nav ">
                    <c:if test="${moduleTree != null}">
                        <c:forEach items="${moduleTree.rootMenuList}" var="menuInfo">
                            <c:set var="menuInfo" value="${menuInfo}" scope="request"/>
                            <c:import url="/WEB-INF/jsp/manage/includes/topNavMenu.jsp" />
                        </c:forEach>
                        <c:forEach items="${moduleTree.rootModuleList}" var="moduleInfo">
                            <c:set var="moduleInfo" value="${moduleInfo}" scope="request"/>
                            <c:import url="/WEB-INF/jsp/manage/includes/topNavModule.jsp"/>
                        </c:forEach>
                    </c:if>
                    <%--<li class="dropdown">--%>
                        <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#">帮助<span class="caret"></span></a>--%>
                        <%--<ul class="dropdown-menu"></ul>--%>
                    <%--</li>--%>
                </ul>
                <ul class="nav nav-user pull-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="icon-cog"></span>
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <span>
                                    <span class="icon-user"></span>
                                    <strong>${loginUser.name}</strong>
                                </span>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="<s:url value="/manage/password" />">修改密码</a>
                            </li>
                            <li class="divider"></li>
                            <li class="">
                                <a href="<s:url value="/manage/logout" />">退出</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <a class="brand visible-desktop visible-tablet"
                   href="<s:url value="/manage/index" />"
                   title="<s:message code="system.name"/>" target="_blank">
                    <s:message code="system.name"/><span class="icon-out-2 small"></span>
                </a>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>
</nav>
