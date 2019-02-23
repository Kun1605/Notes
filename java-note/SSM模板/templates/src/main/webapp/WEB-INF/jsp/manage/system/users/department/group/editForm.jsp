<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/system/users/department/group/save" var="saveURL"/>
<form:form modelAttribute="groupInfo" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${groupInfo.groupName != null ? groupInfo.groupName : ""} 详细信息</legend>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_groupName-lbl" for="jform_groupName" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="groupInfo.groupName,groupInfo.groupName.tip"/>">
                    <s:message code="groupInfo.groupName"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="groupName" id="jform_groupName" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_groupMemo-lbl" for="jform_groupMemo" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="groupInfo.groupMemo,groupInfo.groupMemo.tip"/>">
                    <s:message code="groupInfo.groupMemo"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="groupMemo" id="jform_groupMemo" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_status-lbl" for="jform_status" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="groupInfo.status,groupInfo.status.tip"/>">
                    <s:message code="groupInfo.status"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <fieldset id="jform_status" class="btn-group btn-group-yesno radio">
                    <form:radiobutton path="status" id="jform_status1" value="1"/>
                    <label for="jform_status1" ><s:message code="JGLOBAL_STATUS_1"/></label>
                    <form:radiobutton path="status" id="jform_status0" value="0"/>
                    <label for="jform_status0" ><s:message code="JGLOBAL_STATUS_0"/></label>
                </fieldset>
            </div>
        </div>
    </fieldset>
    <form:hidden path="id"/>
    <form:hidden path="departmentId"/>
    <input type="hidden" name="task" value="" />
</form:form>