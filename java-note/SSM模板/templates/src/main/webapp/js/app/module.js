/*
 * 统一资源平台管理系统 - 网页嵌入脚本
 * 版权所有©2016 www.msymobile.com 保留所有权利
 *
 * 模块处理脚本，包括列表页、编辑页，根据传入的配置完成一些初始化操作，并绑定相应处理方法，
 * 如果模块有特殊需求，可扩展该基础脚本。
 *
 * @category  ajax in web page
 * @package   platform
 * @author    wanghongwei <sungness@gmail.com>
 * @copyright 2016 www.msymobile.com.
 * @link      http://www.msymobile.com/
 */
define(function() {
    return {
        url: {
            list: '',
            edit: '',
            add: '',
            block: '',
            unblock: '',
            del: '',
            pre: '',
            next: '',
            back: '',
            download: '',
            upload: ''
        },

        message: {
            hide_sidebar: "Hide the sidebar",
            show_sidebar: "Show the sidebar",
            multiple_tip: "Select some options",
            single_tip: "Select an option",
            no_results_tip: "No results match",
            filter_search_tip: "Search in ...",
            no_item_selected: "Please first make a selection from the list.",
            confirm_delete: "Are you sure you want to delete? Confirming will permanently delete the selected item(s)!"
        },

        param: {
        },

        selector: {
            listFormSelector: "#adminForm",
            toolbarButtonPrefix: "toolbar-button-",
            listDeleteButtonPrefix: "list-delete-"
        },

        joomla: {
            filtersHidden: true,
            showSidebar: true
        },
        //URL跳转
        redirectToURL: function(url) {
            self.location.href = url;
        },

        /** 列表工具栏按钮单击检测－增加、修改、锁定、解锁 */
        toolbarButtonCheck: function (param) {
            var self = this;
            var form = jQuery(self.selector.listFormSelector);
            if (param != 'add' && form.find(":input[name=boxchecked]").val() == 0) {
                alert(self.message.no_item_selected);
            } else {
                form.attr("action", self.url[param]);
                Joomla.submitbutton(param);
            }
        },

        /** 列表工具栏按钮单击检测－删除 */
        deleteButtonCheck: function (param) {
            var self = this;
            var form = jQuery(self.selector.listFormSelector);
            if (form.find(":input[name=boxchecked]").val() == 0) {
                alert(self.message.no_item_selected);
            } else {
                if (confirm(self.message.confirm_delete) ) {
                    form.attr("action", self.url[param]);
                    Joomla.submitbutton(param);
                }
            }
        },

        /** 列表工具栏按钮单击检测－批量操作 */
        batchButtonCheck: function () {
            var self = this;
            var form = jQuery(self.selector.listFormSelector);
            if (form.find(":input[name=boxchecked]").val() == 0) {
                alert(self.message.no_item_selected);
            } else {
                jQuery('#collapseModal').modal('show');
                return true;
            }
        },

        /** 列表工具栏按钮单击检测－上传 */
        uploadButtonCheck: function (param) {
            var self = this;
            var form = jQuery(self.selector.listFormSelector);
            form.attr("action", self.url[param]);
            Joomla.submitbutton(param);
        },

        /** 绑定翻页事件 */
        bindPagination: function(selectorPrefix) {
            var self = this;
            jQuery("[id^=" + selectorPrefix + "]").click(function() {
                var form = jQuery(self.selector.listFormSelector);
                var pageNumber = form.find(":input[name='pagination.pageNumber']");
                var id = jQuery(this).attr("id").substring(selectorPrefix.length);
                pageNumber.val(id);
                Joomla.submitform();
                return false;
            });
        },

        init: function(config) {
            var self = this;
            window.platformStickyToolbar = 1;
            window.platformOffsetTop = 30;
            jQuery(document).ready(function($) {
                self.url = $.extend({}, self.url, config.url || {});
                self.message = $.extend({}, self.message, config.message || {});
                self.param = $.extend({}, self.param, config.param || {});
                self.selector = $.extend({}, self.selector, config.selector || {});
                self.joomla = $.extend({}, self.joomla, config.joomla || {});
            });

            jQuery(document).ready(function($){
                $('.hasTooltip').tooltip({"html": true,"container": "body"});
            });

            jQuery(document).ready(function ($){
                $('select').chosen({
                    "disable_search_threshold": 10,
                    "search_contains": true,
                    "allow_single_deselect": true,
                    "placeholder_text_multiple": self.message.multiple_tip,
                    "placeholder_text_single": self.message.single_tip,
                    "no_results_text": self.message.no_results_tip
                });
            });
        },

        initList: function(config) {
            var self = this;
            self.init(config);
            /** 左侧边栏显示、收起初始化 */
            jQuery(document).ready(function($) {
                if (window.toggleSidebar && self.joomla.showSidebar) {
                    toggleSidebar(true);
                } else {
                    $("#j-toggle-sidebar-header").css("display", "none");
                    $("#j-toggle-button-wrapper").css("display", "none");
                }
            });
            /** 左侧边栏按钮提示初始化 */
            (function() {
                Joomla.JText.load({
                    "JTOGGLE_HIDE_SIDEBAR" : self.message.hide_sidebar,
                    "JTOGGLE_SHOW_SIDEBAR" : self.message.show_sidebar
                });
            })();

            /** 列表页多选初始化 */
            jQuery(document).ready(function($) {
                Joomla.JMultiSelect('adminForm');
            });

            /** 列表页过滤初始化 */
            (function($){
                $(document).ready(function() {
                    $('#adminForm').searchtools({
                        "filtersHidden":self.joomla.filtersHidden,
                        "defaultLimit":"20",
                        "searchFieldSelector":"#filter_search",
                        "orderFieldSelector":"#list_fullordering",
                        "formSelector":"#adminForm"
                    });
                });
            })(jQuery);

            /** 列表页过滤搜索初始化 */
            jQuery(document).ready(function($){
                $('#filter_search').tooltip({
                    "html": true,
                    "title": self.message.filter_search_tip,
                    "container": "body"
                });
            });

            jQuery(document).ready(function($) {
                $('#collapseModal').on('show', function() {
                    var modalBodyHeight = $(window).height()-147;
                    $('.modal-body').css('max-height', modalBodyHeight);
                    $('body').addClass('modal-open');
                }).on('hide', function () {
                    $('body').removeClass('modal-open');
                });
            });

            /** 链接及按钮初始化 */
            jQuery(document).ready(function($){
                $(self.selector.listFormSelector).attr("action", self.url.list);

                $('#toolbar-button-new').click(function() {
                    self.toolbarButtonCheck('add');
                });
                $('#toolbar-button-edit').click(function() {
                    self.toolbarButtonCheck('edit');
                });
                $('#toolbar-button-block').click(function() {
                    self.toolbarButtonCheck('block');
                });
                $('#toolbar-button-unblock').click(function() {
                    self.toolbarButtonCheck('unblock');
                });
                $('#toolbar-button-del').click(function() {
                    self.deleteButtonCheck('del');
                });
                $('#toolbar-button-batch').click(function() {
                    self.batchButtonCheck();
                });
                $('#toolbar-button-upload').click(function() {
                    self.uploadButtonCheck('upload');
                });
                $('#toolbar-button-back').click(function() {
                    self.redirectToURL(self.url.back);
                });
                $("[id^=" + self.selector.listDeleteButtonPrefix + "]").click(function() {
                    if (confirm(self.message.confirm_delete) ) {
                        return true;
                    } else {
                        return false;
                    }
                });

            });

            /** 翻页初始化 */
            jQuery(document).ready(function($){
                self.bindPagination("start-pagination-");
                self.bindPagination("previous-pagination-");
                self.bindPagination("pagination-number-");
                self.bindPagination("next-pagination-");
                self.bindPagination("end-pagination-");
            });
        },

        initEdit: function (config) {
            var self = this;
            self.init(config);

            (function() {
                Joomla.JText.load({"JLIB_FORM_FIELD_INVALID":"无效字段:&#160"});
            })();

            jQuery(document).ready(function($){
                $("[id^=" + self.selector.toolbarButtonPrefix + "]").click(function() {
                    var task = $(this).attr("id").substring(
                        self.selector.toolbarButtonPrefix.length);
                    var form = document.getElementById('edit-form');
                    if (task == 'cancel') {
                        self.redirectToURL(self.url.back != '' ? self.url.back : self.url.list);
                    } else if (task == 'pre' && form) {
                        form.action = self.url.pre;
                        Joomla.submitform(task, form);
                    } else if (task == 'next' && form) {
                        form.action = self.url.next;
                        Joomla.submitform(task, form);
                    } else if (form && document.formvalidator.isValid(form)) {
                        Joomla.submitform(task, form);
                    }
                });
            });
        },

        initDetail: function(config) {
            var self = this;
            self.init(config);
            /** 链接及按钮初始化 */
            jQuery(document).ready(function($){
                $('#toolbar-button-cancel').click(function() {
                    self.redirectToURL(self.url.back);
                });
                $('#toolbar-button-new').click(function() {
                    self.redirectToURL(self.url.add + "?backURL=" + encodeURIComponent(self.url.back));
                });
                $('#toolbar-button-edit').click(function() {
                    self.redirectToURL(self.url.edit + "&backURL=" + encodeURIComponent(self.url.back));
                });
                $('#toolbar-button-del').click(function() {
                    if (confirm(self.message.confirm_delete) ) {
                        self.redirectToURL(self.url.del + "&backURL=" + encodeURIComponent(self.url.back));
                    }
                });
                $('#toolbar-button-download').click(function() {
                });
            });
        }
    };
});