<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/system/log/notice/save" var="saveURL"/>
<s:url value="/manage/system/log/notice/selectUser" var="selectURL"/>
<form:form modelAttribute="systemNoticeConfig" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>${systemNoticeConfig.userId != null ? systemNoticeConfig.userId : ""} 详细信息</legend>
        <%--<div class="control-group">
            <div class="control-label">
                <label id="jform_userId-lbl" for="jform_userId" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.userId,systemNoticeConfig.userId.tip"/>">
                    <s:message code="systemNoticeConfig.userId"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="userId" id="jform_userId" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>--%>
        <%@ include file="modalSelectUser.jsp" %>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_noticeType-lbl" for="jform_noticeType" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.noticeType,systemNoticeConfig.noticeType.tip"/>">
                    <s:message code="systemNoticeConfig.noticeType"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <s:message code="systemNoticeConfig.noticeType" var="noticeType_option"/>
                <form:select path="noticeType" id="jform_noticeType" class="required" required="required">
                    <form:option value="" label="- ${noticeType_option} -"/>
                    <form:options items="${noticeTypeList}" itemValue="id" itemLabel="description" />
                </form:select>
            </div>
        </div>
        <%--<div class="control-group">
            <div class="control-label">
                <label id="jform_receiveEmail-lbl" for="jform_receiveEmail" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.receiveEmail,systemNoticeConfig.receiveEmail.tip"/>">
                    <s:message code="systemNoticeConfig.receiveEmail"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="receiveEmail" id="jform_receiveEmail" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>--%>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_receiveEmail-lbl" for="jform_receiveEmail" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.receiveEmail,systemNoticeConfig.receiveEmail.tip"/>">
                    <s:message code="systemNoticeConfig.receiveEmail"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <fieldset id="jform_receiveEmail" class="btn-group btn-group-yesno radio">
                    <form:radiobutton path="receiveEmail" id="jform_receiveEmail0" value="1" />
                    <label for="jform_receiveEmail0" ><s:message code="JGLOBAL_YES"/></label>
                    <form:radiobutton path="receiveEmail" id="jform_receiveEmail1" value="0" />
                    <label for="jform_receiveEmail1" ><s:message code="JGLOBAL_NO"/></label>
                </fieldset>
            </div>
        </div>
        <%--<div class="control-group">
            <div class="control-label">
                <label id="jform_receiveWechat-lbl" for="jform_receiveWechat" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.receiveWechat,systemNoticeConfig.receiveWechat.tip"/>">
                    <s:message code="systemNoticeConfig.receiveWechat"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <form:input path="receiveWechat" id="jform_receiveWechat" class="required" size="30"
                            required="required" aria-required="true" />
            </div>
        </div>--%>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_receiveWechat-lbl" for="jform_receiveWechat" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.receiveWechat,systemNoticeConfig.receiveWechat.tip"/>">
                    <s:message code="systemNoticeConfig.receiveWechat"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <fieldset id="jform_receiveWechat" class="btn-group btn-group-yesno radio">
                    <form:radiobutton path="receiveWechat" id="jform_receiveWechat0" value="1" />
                    <label for="jform_receiveWechat0" ><s:message code="JGLOBAL_YES"/></label>
                    <form:radiobutton path="receiveWechat" id="jform_receiveWechat1" value="0" />
                    <label for="jform_receiveWechat1" ><s:message code="JGLOBAL_NO"/></label>
                </fieldset>
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_id-lbl" for="jform_id" class="hasTooltip"
                       title="<sg:message code="TIP_TITLE" ref="systemNoticeConfig.id,systemNoticeConfig.id.tip"/>">
                    <s:message code="systemNoticeConfig.id"/></label>
            </div>
            <div class="controls">
                <form:input path="id" id="jform_id" class="readonly" readonly="true" /></div>
        </div>
    </fieldset>
    <input type="hidden" name="task" value="" />
</form:form>