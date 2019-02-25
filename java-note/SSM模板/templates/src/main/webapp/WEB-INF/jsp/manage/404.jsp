<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/></title>
    <%@include file="/WEB-INF/jsp/manage/includes/linksOfHead.jsp" %>
    <%@include file="/WEB-INF/jsp/manage/includes/scriptsOfBaseHead.jsp" %>
    <script type="text/javascript">
        jQuery(document).ready(function(){
            jQuery('.hasTooltip').tooltip({"html": true,"container": "body"});
        });
        window.platformStickyToolbar = 1;
        window.platformOffsetTop = 30;
    </script>
</head>
<body class="admin com_cpanel view- layout- task- itemid-">
<!-- Top Navigation -->
<%@include file="/WEB-INF/jsp/manage/includes/topNavigation.jsp" %>
<!-- Header -->
<%@ include file="/WEB-INF/jsp/manage/includes/commonHeader.jsp" %>
<div style="margin-bottom: 20px"></div>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <div class="row-fluid">
                    <%@ include file="/WEB-INF/jsp/manage/includes/leftNavigation.jsp" %>
                    <div class="span9">
                        <div id="system-message-container">
                            <div class="alert alert-error">
                                <h4 class="alert-heading">404</h4>
                                <div class="alert-message">
                                    The requested page can't be found.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Content -->
    </section>
</div>
<!-- Begin Status Module -->
<%@include file="/WEB-INF/jsp/manage/includes/footer.jsp" %>
<!-- End Status Module -->
</body>
</html>