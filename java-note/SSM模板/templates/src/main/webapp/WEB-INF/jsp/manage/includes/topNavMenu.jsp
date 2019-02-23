<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page  trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="hasPermission(#menuInfo, '')">
    <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">${menuInfo.value}<span class="caret"></span></a>
        <ul class="dropdown-menu">
            <c:forEach items="${menuInfo.moduleList}" var="moduleInfo">
                <c:set var="moduleInfo" value="${moduleInfo}" scope="request"/>
                <c:import url="/WEB-INF/jsp/manage/includes/topNavModule.jsp" />
            </c:forEach>
            <li class="divider"><span></span></li>
            <c:forEach items="${menuInfo.subMenuList}" var="subMenu">
                <c:set var="menuInfo" value="${subMenu}" scope="request"/>
                <c:import url="/WEB-INF/jsp/manage/includes/subNavMenu.jsp" />
            </c:forEach>
        </ul>
    </li>
</sec:authorize>