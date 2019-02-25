<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<a class="btn btn-subhead" data-toggle="collapse"
   data-target=".subhead-collapse"><s:message code="JTOOLBAR"/><span class="icon-wrench"></span></a>
<div class="subhead-collapse collapse">
    <div class="subhead">
        <div class="container-fluid">
            <div id="container-collapse" class="container-collapse"></div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="btn-toolbar" id="toolbar">
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
                    <c:if test="${showDelete}">
                        <div class="btn-wrapper" id="toolbar-delete">
                            <button id="toolbar-button-del" class="btn btn-small">
                                <span class="icon-delete"></span>
                                <s:message code="JTOOLBAR_DELETE"/></button>
                        </div>
                    </c:if>
                    <c:if test="${showDownload}">
                        <div class="btn-wrapper" id="toolbar-download">
                            <button id="toolbar-button-download" class="btn btn-small">
                                <span class="icon-download"></span>
                                <s:message code="JTOOLBAR_DOWNLOAD"/></button>
                        </div>
                    </c:if>
                    <c:if test="${showCancel}">
                        <div class="btn-wrapper" id="toolbar-cancel">
                            <button id="toolbar-button-cancel" class="btn btn-small">
                                <span class="icon-cancel"></span>
                                <s:message code="JTOOLBAR_CLOSE"/>
                            </button>
                        </div>
                    </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>