<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<s:theme code="template.path" var="tplPath" />
<header class="header">
    <div class="container-logo">
        <%--<img src="<s:url value="${tplPath}/images/logo.png" />"--%>
             <%--class="logo" alt="<s:message code="system.name"/>" />--%>
    </div>
    <div class="container-title">
        <h1 class="page-title">
            <span class="icon-users user"></span>
            ${commandInfo.module.value}：${commandInfo.value}</h1>
    </div>
</header>