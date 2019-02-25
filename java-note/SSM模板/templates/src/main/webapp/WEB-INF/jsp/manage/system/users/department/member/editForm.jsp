<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<s:url value="/manage/system/users/department/member/save" var="saveURL"/>
<form:form modelAttribute="departmentUser" id="edit-form" method="post" name="adminForm"
           action="${saveURL}" class="form-validate form-horizontal">
    <fieldset>
        <legend>成员详细信息</legend>
        <%@ include file="modalSelectUser.jsp" %>
        <div class="control-group">
            <div class="control-label">
                <label id="jform_userPosition-lbl" for="jform_userPosition" class="hasTooltip required"
                       title="<sg:message code="TIP_TITLE" ref="departmentUser.userPosition,departmentUser.userPosition.tip"/>">
                    <s:message code="departmentUser.userPosition"/><span class="star">&#160;*</span></label>
            </div>
            <div class="controls">
                <s:message code="departmentUser.userPosition" var="userPosition_option"/>
                <form:select path="userPosition" id="jform_userPosition" class="required" required="required">
                    <form:option value="" label="- ${userPosition_option} -"/>
                    <form:options items="${userPositionEnum}" itemValue="value" itemLabel="description" />
                </form:select>
            </div>
        </div>
    </fieldset>
    <form:hidden path="id"/>
    <form:hidden path="departmentId"/>
    <input type="hidden" name="task" value="" />
    <input type="hidden" name="backURL" value="${backURL}"/>
</form:form>