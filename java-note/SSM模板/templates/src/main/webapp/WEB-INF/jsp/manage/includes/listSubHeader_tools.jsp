<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<c:if test="${showNew}">
    <div class="btn-wrapper" id="toolbar-new">
        <button id="toolbar-button-new" class="btn btn-small btn-success">
            <span class="icon-new icon-white"></span>
            <s:message code="JTOOLBAR_NEW"/></button>
    </div>
</c:if>
<c:if test="${showEdit}">
    <div class="btn-wrapper" id="toolbar-edit">
        <button id="toolbar-button-edit" class="btn btn-small">
            <span class="icon-edit"></span>
            <s:message code="JTOOLBAR_EDIT"/></button>
    </div>
</c:if>
<c:if test="${showBlock}">
    <div class="btn-wrapper" id="toolbar-unpublish">
        <button id="toolbar-button-block" class="btn btn-small">
            <span class="icon-unpublish"></span>
            <s:message code="USERS_TOOLBAR_BLOCK"/></button>
    </div>
</c:if>
<c:if test="${showUnblock}">
    <div class="btn-wrapper" id="toolbar-unblock">
        <button id="toolbar-button-unblock" class="btn btn-small">
            <span class="icon-unblock"></span>
            <s:message code="USERS_TOOLBAR_UNBLOCK"/></button>
    </div>
</c:if>
<c:if test="${showDelete}">
    <div class="btn-wrapper" id="toolbar-delete">
        <button id="toolbar-button-del" class="btn btn-small">
            <span class="icon-delete"></span>
            <s:message code="JTOOLBAR_DELETE"/></button>
    </div>
</c:if>
<c:if test="${showBatch}">
    <div class="btn-wrapper" id="toolbar-batch">
        <button data-toggle="modal" id="toolbar-button-batch" class="btn btn-small">
            <span class="icon-checkbox-partial" title="Batch"></span>
            <s:message code="JTOOLBAR_BATCH"/></button>
    </div>
</c:if>
<c:if test="${showBack}">
    <div class="btn-wrapper" id="toolbar-cancel">
        <button id="toolbar-button-back" class="btn btn-small">
            <span class="icon-back"></span>
            <s:message code="JTOOLBAR_BACK"/>
        </button>
    </div>
</c:if>
