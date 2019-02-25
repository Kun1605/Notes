<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<div id="status" class="navbar navbar-fixed-bottom hidden-phone">
    <div class="btn-toolbar">
        <div class="btn-group pull-right">
            <p>
                URP 1.0.0	&nbsp;&mdash;&nbsp;
                &copy; 2016 www.msymobile.com
            </p>
        </div>
        <div class="btn-group viewsite">
            <a href="<s:theme code="home.site"/>" target="_blank">
                <span class="icon-out-2"></span>查看网站</a>
        </div>
        <div class="btn-group divider"></div>
        <div class="btn-group loggedin-users">
            <span class="badge">0</span> Visitors
        </div>
        <div class="btn-group backloggedin-users">
            <span class="badge">1</span> Administrator
        </div>
        <div class="btn-group hasTooltip no-unread-messages" title="0 Messages">
            <a href="<s:url value="/manage/messages" />">
                <span class="icon-envelope"></span>
                <span class="badge">0</span>
            </a>
            <div class="btn-group divider"></div>
        </div>
        <div class="btn-group logout">
            <a href="<s:url value="/manage/logout" />">
                <span class="icon-minus-2"></span>退出</a>
        </div>
    </div>
</div>