<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<div class="control-group">
    <div class="control-label">
        <label id="jform_userId-lbl" for="jform_userName" class="hasTooltip required"
               title="<sg:message code="TIP_TITLE" ref="departmentUser.userId,departmentUser.userId.tip"/>">
            <s:message code="departmentUser.userId"/><span class="star">&#160;*</span></label>
    </div>
    <div class="controls">
        <div class="field-user-wrapper"
             data-url="<s:url value="/manage/system/users/department/member/selectUser?filter[departmentId]=${departmentUser.departmentId}"/>"
             data-modal=".modal"
             data-modal-width="100%"
             data-modal-height="400px"
             data-input=".field-user-input"
             data-input-name=".field-user-input-name"
             data-button-select=".button-select">
            <div class="input-append">
                <sg:message code="departmentUser.userId.tip" var="userTip"/>
                <form:input path="userName" id="jform_userName" value=""
                       placeholder="${userTip}" readonly="true"
                       class="field-user-input-name required" required="required" aria-required="true"/>
                <a class="btn btn-primary button-select" title="选择部门成员">
                    <span class="icon-briefcase"></span></a>
                <div id="userModal_jform_userName" tabindex="-1" class="modal hide fade">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">×</button>
                        <h3>选择部门成员</h3>
                    </div>
                    <div class="modal-body"></div>
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal"><s:message code="JTOOLBAR_CANCEL"/></button>
                    </div>
                </div>
            </div>
            <form:hidden path="userId" id="jform_userId" class="field-user-input "
                   data-onchange=""/>
        </div>
    </div>
</div>
