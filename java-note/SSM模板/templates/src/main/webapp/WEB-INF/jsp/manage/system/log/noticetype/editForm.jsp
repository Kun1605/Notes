<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/system/log/noticetype/save" var="saveURL"/>
<form:form modelAttribute="noticeType" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${noticeType.id != null ? noticeType.id : ""} 详细信息</legend>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_code-lbl" for="jform_code" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="noticeType.code,noticeType.code.tip"/>">
                    <s:message code="noticeType.code"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="code" id="jform_code" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_description-lbl" for="jform_description" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="noticeType.description,noticeType.description.tip"/>">
                    <s:message code="noticeType.description"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="description" id="jform_description" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_id-lbl" for="jform_id" class="hasTooltip"
                       title="<sg:message code="TIP_TITLE" ref="noticeType.id,noticeType.id.tip"/>">
                    <s:message code="noticeType.id"/></label>
            </div>
            <div class="controls">
                <form:input path="id" id="jform_id" class="readonly" readonly="true" /></div>
        </div>
    </fieldset>
    <input type="hidden" name="task" value="" />
</form:form>