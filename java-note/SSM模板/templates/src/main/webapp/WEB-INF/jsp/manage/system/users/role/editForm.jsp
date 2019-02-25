<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/system/users/role/save" var="saveURL"/>
<form:form modelAttribute="manageRole" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${manageRole.name != null ? manageRole.name : ""} 角色详细信息</legend>
        <s:message code="manageRole.id" var="labelId"/>
        <s:message code="manageRole.id.tip" var="tipId"/>
        <s:message code="manageRole.name" var="labelName"/>
        <s:message code="manageRole.name.tip" var="tipName"/>
        <s:message code="manageRole.status" var="labelStatus"/>
        <s:message code="manageRole.status.tip" var="tipStatus"/>
        <s:message code="manageRole.manager" var="labelManager"/>
        <s:message code="manageRole.manager.tip" var="tipManager"/>
        <s:message code="manageRole.memo" var="labelMemo"/>
        <s:message code="manageRole.memo.tip" var="tipMemo"/>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_name-lbl" for="jform_name" class="hasTooltip required"
                       title="<s:message code="TIP_TITLE" arguments="${labelName},${tipName}"/>">
                    ${labelName}<span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="name" id="jform_name" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_memo-lbl" for="jform_memo" class="hasTooltip"
                       title="<s:message code="TIP_TITLE" arguments="${labelMemo},${tipMemo}"/>">
                        ${labelMemo}</label>
            </div>
            <div class="controls">
                <form:input path="memo" id="jform_memo" size="30" maxlength="99" /></div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_status-lbl" for="jform_status" class="hasTooltip"
                       title="<s:message code="TIP_TITLE" arguments="${labelStatus},${tipStatus}"/>">
                        ${labelStatus}</label>
            </div>
            <div class="controls">
                <fieldset id="jform_status" class="btn-group btn-group-yesno radio">
                    <form:radiobutton path="status" id="jform_status0" value="1"/>
                    <label for="jform_status0" ><s:message code="JGLOBAL_YES"/></label>
                    <form:radiobutton path="status" id="jform_status1" value="0"/>
                    <label for="jform_status1" ><s:message code="JGLOBAL_NO"/></label>
                </fieldset>
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_manager-lbl" for="jform_manager" class="hasTooltip"
                       title="<s:message code="TIP_TITLE" arguments="${labelManager},${tipManager}"/>">
                        ${labelManager}</label>
            </div>
            <div class="controls">
                <fieldset id="jform_manager" class="btn-group btn-group-yesno radio">
                    <form:radiobutton path="manager" id="jform_manager0" value="1"/>
                    <label for="jform_manager0" ><s:message code="JGLOBAL_YES"/></label>
                    <form:radiobutton path="manager" id="jform_manager1" value="0"/>
                    <label for="jform_manager1" ><s:message code="JGLOBAL_NO"/></label>
                </fieldset>
            </div>
        </div>
    </fieldset>
    <form:hidden path="id"/>
    <input type="hidden" name="task" value="" />
    <input type="hidden" name="backURL" value="${backURL}"/>
</form:form>