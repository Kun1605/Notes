/*
 * 统一资源平台管理系统 - 网页嵌入脚本
 * 版权所有©2016 www.msymobile.com 保留所有权利
 *
 * URP用户管理模块脚本。
 *
 * @category  ajax in web page
 * @package   urp
 * @author    wanghongwei <sungness@gmail.com>
 * @copyright 2016 www.msymobile.com.
 * @link      http://www.msymobile.com/
 */
define(["./module"], function(baseModule) {
    var manageUser = Object.create(baseModule);
    var old_initList = manageUser.initList;

    /** 列表工具栏按钮单击检测－创建二维码 */
    manageUser.createQrcodeButtonCheck = function(param) {
        var self = this;
        var form = jQuery(self.selector.listFormSelector);
        if (form.find(":input[name=boxchecked]").val() == 0) {
            alert(self.message.no_item_selected);
        } else {
            if (confirm(self.message.confirm_create_qrcode) ) {
                form.attr("action", self.url["createQrcode"]);
                Joomla.submitbutton(param);
            }
        }
    };

    manageUser.initList = function(config) {
        var self = this;
        old_initList.apply(self, arguments);
        /** 链接及按钮初始化 */
        jQuery(document).ready(function($){
            $('#toolbar-button-createQrcode').click(function() {
                self.createQrcodeButtonCheck('createQrcode');
            });
        });
    };
    return manageUser;
});