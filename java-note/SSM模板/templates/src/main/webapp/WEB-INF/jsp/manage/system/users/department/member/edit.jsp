<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<s:url value="/manage/system/users/department/member/list?departmentId=${departmentUser.departmentId}" var="listURL"/>
<s:url value="${backURL}&departmentId=${departmentUser.departmentId}" var="jsBackURL"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@ include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/> - ${commandInfo.module.value} - ${commandInfo.value}</title>
    <%@ include file="/WEB-INF/jsp/manage/includes/linksOfEditHead.jsp" %>
    <link href="<s:url value="/media/system/css/modal.css" />" rel="stylesheet" type="text/css" />
    <%@ include file="/WEB-INF/jsp/manage/includes/scriptsOfEditHead.jsp" %>
    <script src="<s:url value="/media/system/js/helpsite.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/system/js/mootools-core.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/system/js/mootools-more.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/system/js/modal.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/media/js/mediafield-mootools.min.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/editors/tinymce/tinymce.min.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/jui/js/fielduser.min.js" />" type="text/javascript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            $('#userModal_jform_userName').on('show', function() {
                var modalBodyHeight = $(window).height()-147;
                $('.modal-body').css('max-height', modalBodyHeight);
                $('body').addClass('modal-open');
            }).on('hide', function () {
                $('body').removeClass('modal-open');
            });
        });
    </script>
</head>
<body class="admin com_users view-user layout-edit task- itemid-">
<!-- Top Navigation -->
<%@ include file="/WEB-INF/jsp/manage/includes/topNavigationDisabled.jsp" %>
<!-- Header -->
<%@ include file="/WEB-INF/jsp/manage/includes/header.jsp" %>
<!-- Subheader -->
<c:set var="showApply" value="true"/>
<c:set var="showSave" value="true"/>
<c:set var="showSave2new" value="true"/>
<c:set var="showCancel" value="true"/>
<c:set var="isEdit" value="${departmentUser.id != null}"/>
<%@ include file="/WEB-INF/jsp/manage/includes/editSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <%@ include file="editForm.jsp" %>
            </div>
        </div>
        <!-- End Content -->
    </section>
</div>
<!-- Begin Status Module -->
<%@ include file="/WEB-INF/jsp/manage/includes/footer.jsp" %>
<!-- End Status Module -->
<script src="<s:url value="/js/require.js" />"></script>
<script type="text/javascript">
    var __ctx='<%= request.getContextPath() %>';
    require([ __ctx + '/js/config.js'], function() {
        require(['app/module'], function(module) {
            var config = {
                url: {
                    list: "${listURL}",
                    back: "${jsBackURL}"
                }
            };
            module.initEdit(config);
        });
    });
</script>
</body>
</html>