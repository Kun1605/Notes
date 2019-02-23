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
    <style type="text/css">
        html { display:none }
    </style>
    <%@include file="/WEB-INF/jsp/manage/includes/scriptsOfHead.jsp" %>
    <script type="text/javascript">
        jQuery(function () {
            if (top == self) {
                document.documentElement.style.display = "block";
            } else {
                top.location = self.location;
            }

            // Firefox fix
            jQuery("input[autofocus]").focus();
        });
        window.setInterval(function() {
            var r;
            try {
                r = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
            } catch(e) {
            }
            if (r) {
                r.open("GET","/administrator/index.php",true);
                r.send(null);
            }
        }, 840000);
        jQuery(document).ready(function(){
            jQuery('.hasTooltip').tooltip({"html": true,"container": "body"});
        });
        jQuery(document).ready(function (){
            jQuery('.advancedSelect').chosen({
                "disable_search_threshold" : 10,
                "search_contains" : true,
                "allow_single_deselect" : true,
                "placeholder_text_multiple" : "Select some options",
                "placeholder_text_single" : "Select an option",
                "no_results_text" : "No results match"
            });
        });
    </script>

    <style type="text/css">
        /* Background color */
        /* Responsive Styles */
        @media (max-width: 480px) {
            .view-login .container {
                margin-top: -170px;
            }
            .btn {
                font-size: 13px;
                padding: 4px 10px 4px;
            }
        }
    </style>
</head>

<body class="site com_login view-login layout-default task- itemid- ">
<!-- Container -->
<div class="container">
    <div id="content">
        <!-- Begin Content -->
        <div id="element-box" class="login well">
            <s:theme code="template.path" var="tplPath" />
            <img src="<s:url value="${tplPath}/images/platform.png" />"
                 alt="Grand Website" />
            <hr />
            <div id="system-message-container">
            <c:if test="${commandResult != null}">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <div class="alert ">
                    <h4 class="alert-heading"><s:message code="${commandResult.title}"/></h4>
                    <div class="alert-message"><s:message code="${commandResult.message}"/></div>
                </div>
            </c:if>
            </div>
            <form action="<s:url value="/login" />" method="post"
                  id="form-login" class="form-inline">
                <fieldset class="loginform">
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend input-append">
                                <span class="add-on">
                                    <span class="icon-user hasTooltip" title="Username"></span>
                                    <label for="mod-login-username" class="element-invisible">Username</label>
                                </span>
                                <input name="username" tabindex="1" id="mod-login-username" type="text"
                                       class="input-medium" placeholder="<s:message code="LOGIN_USERNAME"/>" size="15" autofocus="true" />
                                <a href="<s:url value="/manage/findUsername" />" class="btn width-auto hasTooltip"
                                   title="<s:message code="LOGIN_USERNAME.TIP"/>">
                                    <span class="icon-help"></span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend input-append">
                                <span class="add-on">
                                    <span class="icon-lock hasTooltip" title="Password"></span>
                                    <label for="mod-login-password" class="element-invisible">Password</label>
                                </span>
                                <input name="password" tabindex="2" id="mod-login-password"
                                       type="password" class="input-medium" placeholder="<s:message code="LOGIN_PASSWORD"/>" size="15"/>
                                <a href="<s:url value="/manage/findPassword" />" class="btn width-auto hasTooltip"
                                   title="<s:message code="LOGIN_PASSWORD.TIP"/>">
                                    <span class="icon-help"></span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <div class="btn-group">
                                <button tabindex="3" class="btn btn-primary btn-block btn-large">
                                    <span class="icon-lock icon-white"></span>
                                    <s:message code="JTOOLBAR_LOGIN"/></button>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
        <noscript>
            Warning! JavaScript must be enabled for proper operation of the Administrator Backend.
        </noscript>
        <!-- End Content -->
    </div>
</div>
<s:theme code="home.site" var="homeSite" />
<div class="navbar navbar-fixed-bottom hidden-phone">
    <p class="pull-right">&copy; 2017 </p>
    <a class="login-joomla hasTooltip" href="${homeSite}" target="_blank" title="">
        <span class="icon-joomla"></span>
    </a>
    <a href="${homeSite}" target="_blank" class="pull-left">
        <span class="icon-out-2"></span>Go to site home page.
    </a>
</div>

</body>
</html>