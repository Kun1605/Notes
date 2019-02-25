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
                        <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                        <div class="row-fluid">
                            <div class="alert alert-info">
                                <h4>MP－－管理平台</h4>
                                <p>1、用户管理。</p>
                                <p>2、角色管理。</p>
                                <p>3、部门管理。</p>
                                <p>4、业务组管理。</p>
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