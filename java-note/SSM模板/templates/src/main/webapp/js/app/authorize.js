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
    var authorize = Object.create(baseModule);
    authorize.initAuthorize = function(config) {
        var self = this;
        self.treeObj = config.treeObj;
        self.init(config);
        /** 链接及按钮初始化 */
        jQuery(document).ready(function($){
            $("[id^=" + self.selector.toolbarButtonPrefix + "]").click(function() {
                var task = $(this).attr("id").substring(
                    self.selector.toolbarButtonPrefix.length);
                var form = document.getElementById('authorize-form');
                if (task == 'cancel') {
                    form.action = self.url.back != '' ? self.url.back : self.url.list;
                    Joomla.submitform(task, form);
                } else {
                    var nodes = self.treeObj.getCheckedNodes(true);
                    var idStr = "";
                    nodes.forEach(function(node) {
                        if (node.id != "0") {
                            idStr += node.id + ",";
                        }
                    });
                    form.privilege.value = idStr;
                    Joomla.submitform(task, form);
                }
            });
        });
    };
    return authorize;
});