/*
 * 统一资源平台管理系统 - 网页嵌入脚本
 * 版权所有©2016 www.msymobile.com 保留所有权利
 *
 * 微信菜单管理模块脚本。
 *
 * @category  ajax in web page
 * @package   urp
 * @author    wanghongwei <sungness@gmail.com>
 * @copyright 2016 www.msymobile.com.
 * @link      http://www.msymobile.com/
 */
define(["./module"], function(baseModule) {
    var wechatMenuInfo = Object.create(baseModule);
    var old_initList = wechatMenuInfo.initList;
    var old_initEdit = wechatMenuInfo.initEdit;

    wechatMenuInfo.selector.listSortNumberSelector = "list-sortNumber-change-";
    wechatMenuInfo.selector.typeSelector = "jform_type";
    wechatMenuInfo.selector.fileDivSelector = "upload-media-file";

    /** 列表工具栏按钮单击检测－查看 */
    wechatMenuInfo.showMenuJsonButtonCheck = function() {
        var self = this;
        var form = jQuery(self.selector.listFormSelector);
        form.attr("action", self.url["showMenuJson"]);
        Joomla.submitbutton();
    };

    /** 列表工具栏按钮单击检测－发布 */
    wechatMenuInfo.publishButtonCheck = function() {
        var self = this;
        if (confirm(self.message.confirm_publish)) {
            var form = jQuery(self.selector.listFormSelector);
            form.attr("action", self.url["publish"]);
            Joomla.submitbutton();
        }
    };

    wechatMenuInfo.initList = function(config) {
        var self = this;
        old_initList.apply(self, arguments);
        /** 排序事件绑定 */
        jQuery(document).ready(function($){
            $("[id^=" + self.selector.listSortNumberSelector + "]").change(function() {
                var id = $(this).attr("id").substring(
                    self.selector.listSortNumberSelector.length);
                var sortNumber = $(this).val();
                var form = jQuery(self.selector.listFormSelector);
                form.attr("action", self.url["sort"] + "&id=" + id + "&sortNumber=" + sortNumber);
                Joomla.submitbutton("sort");
            });
            $('#toolbar-button-showMenuJson').click(function() {
                console.log("click showMenuJson");
                self.showMenuJsonButtonCheck();
            });
            $('#toolbar-button-publish').click(function() {
                console.log("click publish");
                self.publishButtonCheck();
            });
        });
    };
    wechatMenuInfo.initEdit = function(config) {
        var self = this;
        old_initEdit.apply(self, arguments);
        /** 修改类型事件绑定 */
        jQuery(document).ready(function($){
            var typeSelectObj = $("[id=" + self.selector.typeSelector + "]");
            var uploadFileDiv =  $("[id=" + self.selector.fileDivSelector + "]");
            if (typeSelectObj.val() == 9) {
                uploadFileDiv.show();
            } else {
                uploadFileDiv.hide();
            }

            typeSelectObj.change(function() {
                var buttonType = $(this).val();
                if (buttonType == 9) {
                    uploadFileDiv.show();
                } else {
                    uploadFileDiv.hide();
                }
            });
        });
    };
    return wechatMenuInfo;
});