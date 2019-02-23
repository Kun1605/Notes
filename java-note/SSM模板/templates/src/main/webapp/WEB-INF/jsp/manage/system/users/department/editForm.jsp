<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/system/users/department/save" var="saveURL"/>
<form:form modelAttribute="departmentInfo" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${departmentInfo.departmentName != null ? departmentInfo.departmentName : ""} 详细信息</legend>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_departmentName-lbl" for="jform_departmentName" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="departmentInfo.departmentName,departmentInfo.departmentName.tip"/>">
                    <s:message code="departmentInfo.departmentName"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="departmentName" id="jform_departmentName" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_departmentMemo-lbl" for="jform_departmentMemo" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="departmentInfo.departmentMemo,departmentInfo.departmentMemo.tip"/>">
                    <s:message code="departmentInfo.departmentMemo"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="departmentMemo" id="jform_departmentMemo" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_status-lbl" for="jform_status" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="departmentInfo.status,departmentInfo.status.tip"/>">
                    <s:message code="departmentInfo.status"/><span class="star">&#160;*</span></label>
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
    <input type="hidden" name="task" value="" />
    <input type="hidden" name="backURL" value="${backURL}"/>
</form:form>