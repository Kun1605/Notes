<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a href="#" class="btn btn-navbar collapsed"
               data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="admin-logo disabled" ><span class="icon-joomla"></span></a>
            <a class="brand hidden-desktop hidden-tablet" href="<s:url value="/manage/index" />"
               title="<s:message code="system.name"/>" target="_blank">
                <s:message code="system.name"/><span class="icon-out-2 small"></span>
            </a>
            <div class="nav-collapse collapse">
                <ul id="menu" class="nav disabled ">
                    <c:if test="${moduleTree != null}">
                        <c:forEach items="${moduleTree.rootMenuList}" var="menuInfo">
                            <li class="disabled"><a class="" >${menuInfo.value}</a></li>
                        </c:forEach>
                    </c:if>
                </ul>
                <ul class="nav nav-user pull-right">
                    <li class="dropdown">
                        <a class=" disabled" data-toggle="" >
                            <span class="icon-cog"></span>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu"></ul>
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