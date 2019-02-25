/*
 * 统一资源平台管理系统 - 网页嵌入脚本
 * 版权所有©2016 www.msymobile.com 保留所有权利
 *
 * 统计数据模块脚本。
 *
 * @category  ajax in web page
 * @package   urp
 * @author    wanghongwei <sungness@gmail.com>
 * @copyright 2016 www.msymobile.com.
 * @link      http://www.msymobile.com/
 */
define(["./module"], function(baseModule) {
    var statData = Object.create(baseModule);
    var old_initList = statData.initList;

    /** 列表工具栏按钮单击检测－状态修改 */
    statData.downloadButtonCheck = function() {
        var self = this;
        var form = jQuery(self.selector.listFormSelector);
        if (form.find("#filter_beginDate").val() == ''
            && form.find("#filter_endDate").val() == '' || form.find("#filter_month").val() == '') {
            alert(self.message.date_range_tip);
            return false;
        } else {
            self.downloadFrame = null;
            var url = self.url.download + "?" + form.serialize();
            if (self.downloadFrame) {
                self.downloadFrame.attr('src', url);
            } else {
                self.downloadFrame = jQuery('<iframe>', { id:'downloadFrame', src:url }).hide().appendTo('body');
            }
        }
    };


    /** 列表工具栏当前页下载按钮单击检测－状态修改 */
    statData.downloadPageButtonCheck = function() {
        var self = this;
        var form = jQuery(self.selector.listFormSelector);
        if (form.find(":input[name=boxchecked]").val() == 0) {
            alert(self.message.no_item_selected);
            return false;
        }else {
            self.downloadFrame = null;
            var url = self.url.pagedownload + "?" + form.serialize();
            if (self.downloadFrame) {
                self.downloadFrame.attr('src', url);
            } else {
                self.downloadFrame = jQuery('<iframe>', { id:'downloadFrame', src:url }).hide().appendTo('body');
            }
        }
    };

    statData.initList = function(config) {
        var self = this;
        old_initList.apply(self, arguments);
        /** 下载按钮初始化 */
        jQuery(document).ready(function($){
            $('#toolbar-button-download').click(function() {
                self.downloadButtonCheck();
                return false;
            });
        });
        /** 当前页下载按钮初始化 */
        jQuery(document).ready(function($){
            $('#toolbar-button-pagedownload').click(function() {
                self.downloadPageButtonCheck();
                return false;
            });
        });
    };
    return statData;
});