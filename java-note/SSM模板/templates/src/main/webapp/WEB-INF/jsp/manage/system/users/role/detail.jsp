<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sg" uri="http://www.sungness.com/tags" %>
<%@ taglib prefix="sform" uri="http://www.sungness.com/tags/form" %>
<sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
    <s:url value="/manage/system/users/role/edit" var="addURL"/>
    <s:url value="/manage/system/users/role/edit?id=${manageRole.id}" var="editURL"/>
</sec:authorize>
<sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
<s:url value="/manage/system/users/managerole/delete?id=${manageRole.id}" var="delURL"/>
</sec:authorize>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn" dir="ltr" >
<head>
    <%@ include file="/WEB-INF/jsp/manage/includes/meta.jsp" %>
    <title><s:message code="system.name"/> - ${commandInfo.module.value} - ${commandInfo.value}</title>
    <%@ include file="/WEB-INF/jsp/manage/includes/linksOfListHead.jsp" %>
    <%@ include file="/WEB-INF/jsp/manage/includes/scriptsOfHead.jsp" %>
    <script src="<s:url value="/media/jui/js/jquery.searchtools.min.js" />" type="text/javascript"></script>
    <script src="<s:url value="/media/system/js/multiselect.js" />" type="text/javascript"></script>
</head>
<body class="admin com_admin view-sysinfo layout- task- itemid-">
<!-- Top Navigation -->
<%@ include file="/WEB-INF/jsp/manage/includes/topNavigation.jsp" %>
<!-- Header -->
<%@ include file="/WEB-INF/jsp/manage/includes/header.jsp" %>
<!-- Subheader -->
<sec:authorize access="hasPermission(#commandInfo.module, 'edit')">
    <c:set var="showNew" value="true"/>
    <c:set var="showEdit" value="true"/>
</sec:authorize>
<sec:authorize access="hasPermission(#commandInfo.module, 'delete')">
    <c:set var="showDelete" value="true"/>
</sec:authorize>
<c:set var="showCancel" value="true"/>
<%@ include file="/WEB-INF/jsp/manage/includes/detailSubHeader.jsp" %>
<!-- container-fluid -->
<div class="container-fluid container-main">
    <section id="content">
        <!-- Begin Content -->
        <div class="row-fluid">
            <div class="span12">
                <%@ include file="/WEB-INF/jsp/manage/includes/systemMessage.jsp" %>
                <div class="row-fluid">
                    <!-- Begin Content -->
                    <div class="span12">
                        <fieldset class="adminform">
                            <legend>角色 详细信息</legend>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th width="25%">条目</th>
                                        <th>内容</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <td colspan="2">&#160;</td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <tr>
                                        <td><strong><s:message code="manageRole.name"/></strong></td>
                                        <td>
                                            ${manageRole.name}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong><s:message code="manageRole.manager"/></strong></td>
                                        <td>
                                            ${manageRole.managerDescription}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong><s:message code="manageRole.memo"/></strong></td>
                                        <td>
                                            ${manageRole.memo}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong><s:message code="manageRole.status"/></strong></td>
                                        <td>
                                            ${manageRole.statusDescription}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong><s:message code="manageRole.id"/></strong></td>
                                        <td>
                                            ${manageRole.id}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                    </div>
                    <!-- End Content -->
                </div>
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
    require(['<s:url value="/js/config.js" />'], function() {
        require(['app/module'], function(module) {
            var config = {
                url: {
                    add: "${addURL}",
                    edit: "${editURL}",
                    del: "${delURL}",
                    back: "${backURL}"
                },
                message: {
                    confirm_delete: "<s:message code="JGLOBAL_CONFIRM_DELETE"/>"
                }
            };
            module.initDetail(config);
        });
    });
</script>
</body>
</html>