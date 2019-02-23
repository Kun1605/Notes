<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<div id="system-message-container">
<c:if test="${commandResult != null}">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <div class="alert alert-${commandResult.success ? "success" : "error"}">
        <h4 class="alert-heading"><s:message code="${commandResult.title}"/></h4>
        <c:choose>
            <c:when test="${commandResult.success}">
        <div class="alert-message"><s:message code="${commandResult.message}" text="${commandResult.message}"/></div>
            </c:when>
            <c:otherwise>
                <c:if test="${commandResult.message != null}">
                    <s:message code="${commandResult.message}"/>
                </c:if>
                <c:forEach items="${commandResult.errors}" var="objectError">
        <div class="alert-message">
            <s:message code="${objectError.code}"
                       text="${objectError.defaultMessage}"/>
        </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</c:if>
</div>