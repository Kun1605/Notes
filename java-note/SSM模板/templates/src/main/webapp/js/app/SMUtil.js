/*
 * Sungness综合管理系统 - 网页嵌入脚本（公用）
 * 版权所有©2013 Sungness.com 保留所有权利
 *		Sungness管理系统公用脚本，包括删除确认、批量操作、url跳转、封装等功能
 * @category  ajax in web page
 * @package   sysmanage
 * @author    wanghongwei <sungness@163.com>
 * @copyright 2013 sungness.com.
 * @link      http://www.sungness.com/
 */
var SMUtil = { //Sungness Manage Utils
	//URL跳转
	forwardURL: function(url) {
		self.location.href = url;
	},

	//封装URL
	buildURL: function(url, param) {
		return url + "?" + decodeURIComponent($.param(param));
	},

	//清除指定id的值
	bindClear: function(clickId, clearIds, includeSelf) {
		$('#' + clickId).dblclick(function() {
			$.each(clearIds, function (i, n) {
				$('#' + n).val("");
			});
			if (includeSelf) {
				$(this).val("");
			}
			return false;
		});
	},

	//选择列表中所有复选框
	checkAll: function(allBox, boxName) {
		$("input[name=" + boxName + "]").each(function() {
			$(this).prop("checked", allBox.prop("checked"));
		});
	},

	//判断是否有选中的站点
	haveSelected: function(boxName) {
		return $("input[name=" + boxName + "]:checked").length > 0;
	},

	//提取所有选中的id，封装成字符串返回
	getCheckedIds: function(idList) {
		var idStr = "";
		idList.each(function (i, n) {
			idStr += $(this).attr("value");
			if (i < idList.length - 1) {
				idStr += ",";
			}
		});
		return idStr;
	},

	//批量删除
	batchDelete: function(boxName, delFunc) {
		if (!SMUtil.haveSelected(boxName)) {
			window.alert("请选择要批量删除的记录!");
			return false;
		} else {
			var idList = $("input[name=" + boxName + "]:checked");
			var idStr = SMUtil.getCheckedIds(idList);
			if(window.confirm("确认要删除序号为 " + idStr + " 的记录？")) {
				delFunc(idStr);
			}
		}
	},

	//删除单个记录
	delRecord: function(id, url) {
		if(window.confirm("确认要删除序号为 " + id + " 的记录？")) {
			SMUtil.forwardURL(url);
		}
	},

	//ajax方式批量删除记录，并刷新当前页
	ajaxBatchDelete: function(boxName, deleteURL, refreshURL) {
		if (!SMUtil.haveSelected(boxName)) {
			window.alert("请选择要批量删除的记录!");
			return false;
		} else {
			var idList = $("input[name=" + boxName + "]:checked");
			var idStr = SMUtil.getCheckedIds(idList);
			if(window.confirm("确认要删除序号为 " + idStr + " 的记录？")) {
				SMUtil.deleteAction(boxName, idStr, deleteURL, refreshURL);
			}
		}
	},

	//ajax方式删除单个记录，并刷新当前页
	ajaxDeleteSingle: function(pname, ids, deleteURL, refreshURL) {
		if(window.confirm("确认要删除序号为 " + ids + " 的记录？")) {
			SMUtil.deleteAction(pname, ids, deleteURL, refreshURL);
		}
	},

	deleteAction: function(pname, ids, deleteURL, refreshURL) {
		var param = {};
		param[pname] = ids;
		$.ajax({
			type: "POST",
			url: deleteURL,
			dataType: "json",
			data: param
		}).done(function(jsonData) {
            SMUtil.alert(jsonData, refreshURL);
		}).fail(function(jqXHR, textStatus, error) {
			alert("删除记录失败：" + textStatus + ", " + error);
		});
	},

	//输出错误提示
	alert: function(data, forwardURL) {
		var self = this;
		if (data.success == true) {
			alert(data.message);
			if (forwardURL) {
				SMUtil.forwardURL(forwardURL);
			}
		} else {
			alert(self.printError(data));
		}
	},
	printError: function(data) {
		var cause = "";
		$.each(data.errors, function(index, error) {
			if (cause.length > 0) {
				cause += ",\n－－";
			}
			cause += error.defaultMessage;
		});
		return (data.message + "：\n" + cause);
	},

	resetSidebarHeight: function() {
		$("aside#sidebar").css("height", $(document).height() - 93);
		$("section#main").css("min-height", $(document).height() - 93);
	}
};
