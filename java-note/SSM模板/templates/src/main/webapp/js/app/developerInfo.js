/*
 * 统一资源平台管理系统 - 网页嵌入脚本
 * 版权所有©2016 www.msymobile.com 保留所有权利
 *
 * 开发者账号管理模块脚本。
 *
 * @category  ajax in web page
 * @package   urp
 * @author    wanghongwei <sungness@gmail.com>
 * @copyright 2016 www.msymobile.com.
 * @link      http://www.msymobile.com/
 */
define(["./module"], function(baseModule) {
    var developerInfo = Object.create(baseModule);
    var old_initList = developerInfo.initList;

    /** 列表工具栏按钮单击检测－状态修改 */
    developerInfo.updateStatusButtonCheck = function(param) {
        var self = this;
        var form = jQuery(self.selector.listFormSelector);
        if (form.find(":input[name=boxchecked]").val() == 0) {
            alert(self.message.no_item_selected);
        } else {
            if (confirm(self.message.confirm_update_status) ) {
                form.attr("action", self.url["updateStatus"]);
                Joomla.submitbutton(param);
            }
        }
    };

    /** 列表工具栏按钮单击检测－加入队列 */
    developerInfo.addToQueueButtonCheck = function(param) {
        var self = this;
        var form = jQuery(self.selector.listFormSelector);
        if (form.find(":input[name=boxchecked]").val() == 0) {
            alert(self.message.no_item_selected);
        } else {
            if (confirm(self.message.confirm_add_to_queue) ) {
                form.attr("action", self.url["addToQueue"]);
                Joomla.submitbutton(param);
            }
        }
    };

    developerInfo.initList = function(config) {
        var self = this;
        old_initList.apply(self, arguments);
        //绑定列表中记录创建菜单链接点击事件
        /** 链接及按钮初始化 */
        jQuery(document).ready(function($){
            $('#toolbar-button-login').click(function() {
                var form = jQuery(self.selector.listFormSelector);
                if (form.find(":input[name=boxchecked]").val() == 0) {
                    alert(self.message.no_item_selected);
                } else {
                    form.attr("action", self.url["login"]);
                    Joomla.submitbutton("login");
                }
            });
            $('#toolbar-button-pause').click(function() {
                self.updateStatusButtonCheck('pause');
            });
            $('#toolbar-button-enable').click(function() {
                self.updateStatusButtonCheck('enable');
            });
            $('#toolbar-button-reset').click(function() {
                self.updateStatusButtonCheck('reset');
            });
            $('#toolbar-button-toAnnounceQueue').click(function() {
                self.addToQueueButtonCheck('announce');
            });
            $('#toolbar-button-toAppQueue').click(function() {
                self.addToQueueButtonCheck('app');
            });
            $('#toolbar-button-toDataQueue').click(function() {
                self.addToQueueButtonCheck('data');
            });
        });
    };
    return developerInfo;
});