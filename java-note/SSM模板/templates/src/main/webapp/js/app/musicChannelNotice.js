/**
 * 音乐渠道通知列表页添加返回按钮
 * Created by zhiming on 2016/9/20.
 */
define(["./module"], function(baseModule) {
    var musicChannelNotice = Object.create(baseModule);
    var old_initList = musicChannelNotice.initList;

    /** 列表页返回按钮 */
    musicChannelNotice.backListButtonCheck = function(param) {
        var self = this;
        self.redirectToURL(self.url[param]);
    };

    musicChannelNotice.initList = function(config) {
        var self = this;
        old_initList.apply(self, arguments);
        //绑定列表中记录创建菜单链接点击事件
        /** 链接及按钮初始化 */
        jQuery(document).ready(function($){
            $('#toolbar-button-backlist').click(function() {
                self.backListButtonCheck('backList');
            });
        });
    };
    return musicChannelNotice;
});