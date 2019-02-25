<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/api_log/save" var="saveURL"/>
<form:form commandName="apiLog" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${apiLog.id != null ? apiLog.id : ""} 详细信息</legend>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_businessUid-lbl" for="jform_businessUid" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="apiLog.businessUid,apiLog.businessUid.tip"/>">
                    <s:message code="apiLog.businessUid"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="businessUid" id="jform_businessUid" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_path-lbl" for="jform_path" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="apiLog.path,apiLog.path.tip"/>">
                    <s:message code="apiLog.path"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="path" id="jform_path" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_actionTime-lbl" for="jform_actionTime" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="apiLog.actionTime,apiLog.actionTime.tip"/>">
                    <s:message code="apiLog.actionTime"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="actionTime" id="jform_actionTime" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_resCode-lbl" for="jform_resCode" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="apiLog.resCode,apiLog.resCode.tip"/>">
                    <s:message code="apiLog.resCode"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="resCode" id="jform_resCode" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_id-lbl" for="jform_id" class="hasTooltip"
                       title="<sg:message code="TIP_TITLE" ref="apiLog.id,apiLog.id.tip"/>">
                    <s:message code="apiLog.id"/></label>
            </div>
            <div class="controls">
                <form:input path="id" id="jform_id" class="readonly" readonly="true" /></div>
        </div>
    </fieldset>
    <input type="hidden" name="task" value="" />
</form:form>