<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/system/users/user/save" var="saveURL"/>
<form:form modelAttribute="manageUser" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <c:if test="${manageUser.name != null}"><h4>${manageUser.name}</h4></c:if>
    <fieldset>
        <s:message code="manageUser.id" var="labelId"/>
        <s:message code="manageUser.id.tip" var="tipId"/>
        <s:message code="manageUser.name" var="labelName"/>
        <s:message code="manageUser.name.tip" var="tipName"/>
        <s:message code="manageUser.username" var="labelUsername"/>
        <s:message code="manageUser.username.tip" var="tipUsername"/>
        <s:message code="manageUser.password" var="labelPassword"/>
        <s:message code="manageUser.password.tip" var="tipPassword"/>
        <s:message code="manageUser.confirm" var="labelConfirm"/>
        <s:message code="manageUser.confirm.tip" var="tipConfirm"/>
        <s:message code="manageUser.status" var="labelStatus"/>
        <s:message code="manageUser.status.tip" var="tipStatus"/>
        <s:message code="manageUser.phone" var="labelPhone"/>
        <s:message code="manageUser.phone.tip" var="tipPhone"/>
        <s:message code="manageUser.email" var="labelEmail"/>
        <s:message code="manageUser.email.tip" var="tipEmail"/>
        <s:message code="manageUser.memo" var="labelMemo"/>
        <s:message code="manageUser.memo.tip" var="tipMemo"/>
        <s:message code="manageUser.lastVisitDate" var="labelLastVisitDate"/>
        <s:message code="manageUser.lastVisitDate.tip" var="tipLastVisitDate"/>
        <s:message code="manageUser.createDate" var="labelCreateDate"/>
        <s:message code="manageUser.createDate.tip" var="tipCreateDate"/>
        <s:message code="manageUser.sendEmail" var="labelSendEmail"/>
        <s:message code="manageUser.sendEmail.tip" var="tipSendEmail"/>
        <ul class="nav nav-tabs" id="myTabTabs">
            <li class="active"><a href="#details" data-toggle="tab">用户详细信息</a></li>
            <li class=""><a href="#groups" data-toggle="tab">为用户分配角色</a></li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <div id="details" class="tab-pane active">
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
                        <label id="jform_username-lbl" for="jform_username" class="hasTooltip required"
                               title="<s:message code="TIP_TITLE" arguments="${labelUsername},${tipUsername}"/>">
                            ${labelUsername}<span class="star">&#160;*</span></label>
                    </div>
                    <div class="controls">
                        <form:input path="username" id="jform_username" class="validate-email required" size="30"
                                    required="required" aria-required="true" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="control-label">
                        <label id="jform_password-lbl" for="jform_password" class="hasTooltip"
                               title="<s:message code="TIP_TITLE" arguments="${labelPassword},${tipPassword}"/>">
                            ${labelPassword}
                        </label>
                    </div>
                    <div class="controls">
                        <form:password path="password" id="jform_password" autocomplete="off"
                                    class="validate-password" size="30" maxlength="99" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="control-label">
                        <label id="jform_confirm-lbl" for="jform_confirm" class="hasTooltip"
                               title="<s:message code="TIP_TITLE" arguments="${labelConfirm},${tipConfirm}"/>">
                            ${labelConfirm}</label>
                    </div>
                    <div class="controls">
                        <form:password path="confirm" id="jform_confirm" autocomplete="off"
                                       class="validate-password" size="30" maxlength="99" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="control-label">
                        <label id="jform_phone-lbl" for="jform_phone" class="hasTooltip required"
                               title="<s:message code="TIP_TITLE" arguments="${labelPhone},${tipPhone}"/>">
                                ${labelPhone}<span class="star">&#160;*</span></label>
                    </div>
                    <div class="controls">
                        <form:input path="phone" class="required" id="jform_phone" size="30"
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
            </div>
            <div id="groups" class="tab-pane">
                <c:forEach items="${manageRoleList}" var="role">
                <div class="control-group">
                    <div class="controls">
                        <label class="checkbox" for="role_${role.id}">
                            <input type="checkbox" name="roleIdSet" value="${role.id}" id="role_${role.id}"
                                   <c:if test="${manageUser.contains(role.id)}">checked</c:if> />
                            ${role.name} -- (状态:${role.statusDescription}, 描述:${role.memo})
                        </label>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </fieldset>
    <form:hidden path="id"/>
    <input type="hidden" name="task" value="" />
    <input type="hidden" name="backURL" value="${backURL}"/>
</form:form>