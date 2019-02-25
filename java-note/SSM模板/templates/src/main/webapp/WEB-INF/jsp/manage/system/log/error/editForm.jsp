<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/system/log/error/save" var="saveURL"/>
<form:form modelAttribute="systemMessage" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${systemMessage.title != null ? systemMessage.title : ""} 详细信息</legend>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_title-lbl" for="jform_title" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.title,systemMessage.title.tip"/>">
                    <s:message code="systemMessage.title"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="title" id="jform_title" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_message-lbl" for="jform_message" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.message,systemMessage.message.tip"/>">
                    <s:message code="systemMessage.message"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="message" id="jform_message" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_messageLevel-lbl" for="jform_messageLevel" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.messageLevel,systemMessage.messageLevel.tip"/>">
                    <s:message code="systemMessage.messageLevel"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="messageLevel" id="jform_messageLevel" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_messageModule-lbl" for="jform_messageModule" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.messageModule,systemMessage.messageModule.tip"/>">
                    <s:message code="systemMessage.messageModule"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="messageModule" id="jform_messageModule" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_messageLine-lbl" for="jform_messageLine" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.messageLine,systemMessage.messageLine.tip"/>">
                    <s:message code="systemMessage.messageLine"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="messageLine" id="jform_messageLine" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_messageTime-lbl" for="jform_messageTime" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.messageTime,systemMessage.messageTime.tip"/>">
                    <s:message code="systemMessage.messageTime"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="messageTime" id="jform_messageTime" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_id-lbl" for="jform_id" class="hasTooltip"
                       title="<sg:message code="TIP_TITLE" ref="systemMessage.id,systemMessage.id.tip"/>">
                    <s:message code="systemMessage.id"/></label>
            </div>
            <div class="controls">
                <form:input path="id" id="jform_id" class="readonly" readonly="true" /></div>
        </div>
    </fieldset>
    <input type="hidden" name="task" value="" />
</form:form>