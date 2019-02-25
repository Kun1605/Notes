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

                        <c:if test="${showRefresh}">
                            <div class="btn-wrapper" id="toolbar-refresh">
                                <button id="toolbar-button-refresh" class="btn btn-small">
                                    <span class="icon-refresh"></span>
                                    <s:message code="JTOOLBAR_REFRESH_CACHE"/>
                                </button>
                            </div>
                        </c:if>

                        <c:if test="${showPublish}">
                            <div class="btn-wrapper" id="toolbar-publish">
                                <button id="toolbar-button-publish" class="btn btn-small">
                                    <span class="icon-vcard"></span>
                                    <s:message code="JTOOLBAR_PUBLISH"/>
                                </button>
                            </div>
                        </c:if>
                        <c:if test="${showApply}">
                        <div class="btn-wrapper" id="toolbar-apply">
                            <button id="toolbar-button-apply" class="btn btn-small btn-success">
                                <span class="icon-apply icon-white"></span>
                                <s:message code="JTOOLBAR_APPLY"/></button>
                        </div>
                        </c:if>
                        <c:if test="${showSave}">
                        <div class="btn-wrapper" id="toolbar-save">
                            <button id="toolbar-button-save" class="btn btn-small">
                                <span class="icon-save"></span>
                                <s:message code="JTOOLBAR_SAVE"/></button>
                        </div>
                        </c:if>
                        <c:if test="${showSave2new}">
                        <div class="btn-wrapper" id="toolbar-save-new">
                            <button id="toolbar-button-save2new" class="btn btn-small">
                                <span class="icon-save-new"></span>
                                <s:message code="JTOOLBAR_SAVE_AND_NEW"/></button>
                        </div>
                        </c:if>
                        <c:if test="${showPre}">
                            <div class="btn-wrapper" id="toolbar-pre">
                                <button id="toolbar-button-pre" class="btn btn-small">
                                    <span class="icon-leftarrow"></span>
                                    <s:message code="JTOOLBAR_PRE"/></button>
                            </div>
                        </c:if>
                        <c:if test="${showSave2pre}">
                            <div class="btn-wrapper" id="toolbar-save-pre">
                                <button id="toolbar-button-save2pre" class="btn btn-small">
                                    <span class="icon-leftarrow"></span>
                                    <s:message code="JTOOLBAR_SAVE_AND_PRE"/></button>
                            </div>
                        </c:if>
                        <c:if test="${showSave2next}">
                            <div class="btn-wrapper" id="toolbar-save-next">
                                <button id="toolbar-button-save2next" class="btn btn-small">
                                    <span class="icon-rightarrow"></span>
                                    <s:message code="JTOOLBAR_SAVE_AND_NEXT"/></button>
                            </div>
                        </c:if>
                        <c:if test="${showNext}">
                            <div class="btn-wrapper" id="toolbar-next">
                                <button id="toolbar-button-next" class="btn btn-small">
                                    <span class="icon-rightarrow"></span>
                                    <s:message code="JTOOLBAR_NEXT"/></button>
                            </div>
                        </c:if>

                        <c:if test="${showCancel}">
                        <div class="btn-wrapper" id="toolbar-cancel">
                            <button id="toolbar-button-cancel" class="btn btn-small">
                                <span class="icon-cancel"></span>
                                <s:message code="${isEdit ? 'JTOOLBAR_CLOSE' : 'JTOOLBAR_CANCEL'}"/>
                            </button>
                        </div>
                        </c:if>

                        <c:if test="${showDownload}">
                        <div class="btn-wrapper" id="toolbar-download">
                            <button id="toolbar-button-download" class="btn hasTooltip"
                                    title="<s:message code="JTOOLBAR_DOWNLOAD"/>">
                                <span class="icon-download"></span>
                                <s:message code="JTOOLBAR_DOWNLOAD"/></button>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>