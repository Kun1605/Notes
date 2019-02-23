<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="pagination pagination-toolbar">
    <c:if test="${pagination.totalPage > 0}">
    <ul class="pagination-list">
        <c:choose>
            <c:when test="${pagination.isFirstPage()}">
        <li class="disabled"><a><span class="icon-first"></span></a></li>
        <li class="disabled"><a><span class="icon-previous"></span></a></li>
            </c:when>
            <c:otherwise>
        <li>
            <a class="hasTooltip" title="Start" href="#" id="start-pagination-1">
                <span class="icon-first"></span></a>
        </li>
        <li>
            <a class="hasTooltip" title="Previous" href="#" id="previous-pagination-${pagination.previousPage}">
                <span class="icon-previous"></span></a>
        </li>
            </c:otherwise>
        </c:choose>
        <c:forEach items="${pagination.pageList}" var="pageNumber">
            <c:choose>
                <c:when test="${pagination.isCurrentPage(pageNumber)}">
        <li class="active hidden-phone"><a>${pageNumber}</a></li>
                </c:when>
                <c:otherwise>
        <li class="hidden-phone">
            <a href="#" id="pagination-number-${pageNumber}">${pageNumber}</a>
        </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${pagination.isLastPage()}">
        <li class="disabled"><a><span class="icon-next"></span></a></li>
        <li class="disabled"><a><span class="icon-last"></span></a></li>
            </c:when>
            <c:otherwise>
        <li>
            <a class="hasTooltip" title="Next" href="#" id="next-pagination-${pagination.nextPage}">
                <span class="icon-next"></span></a>
        </li>
        <li>
            <a class="hasTooltip" title="End" href="#" id="end-pagination-${pagination.getLastPage()}">
                <span class="icon-last"></span></a>
        </li>
            </c:otherwise>
        </c:choose>
    </ul>
    </c:if>
    <form:hidden path="pagination.pageNumber"/>
    <form:hidden path="pagination.oldPageSize"/>
</div>