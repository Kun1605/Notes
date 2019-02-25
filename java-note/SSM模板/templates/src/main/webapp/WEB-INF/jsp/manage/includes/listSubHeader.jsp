<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<a class="btn btn-subhead" data-toggle="collapse"
   data-target=".subhead-collapse"><s:message code="JTOOLBAR"/><span class="icon-wrench"></span></a>
<div class="subhead-collapse collapse">
    <div class="subhead">
        <div class="container-fluid">
            <div id="container-collapse" class="container-collapse"></div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="btn-toolbar" id="toolbar">
                    <%@ include file="listSubHeader_tools.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>