// /*
//  * Sungness综合管理系统 - 网页嵌入脚本
//  * 版权所有©2013 Sungness.com 保留所有权利
//  *
//  * @category  ajax in web page
//  * @package   sysmanage
//  * @author    wanghongwei <sungness@163.com>
//  * @copyright 2013 sungness.com.
//  * @link      http://www.sungness.com/
//  */
//
// var SM = { // Sungness Manage
// 	C: { // Config
// 		I: { // Init
// 			treeId: 'contentTree',
// 			newCount: 1
// 		},
//
// 		S: { // Selector
// 		}
// 	},
//
// 	ZU: { // Ztree Utils
// 		filter: function(treeId, parentNode, childNodes) {
// 			if (!childNodes) return null;
// 			for (var i=0, l=childNodes.length; i<l; i++) {
// 				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
// 			}
// 			return childNodes;
// 		},
//
// 		removeHoverDom: function(treeId, treeNode) {
// 			$("#addBtn_"+treeNode.id).unbind().remove();
// 		}
// 	},
//
// 	Init: {
// 		InitZtreeSetting: function(uSetting) {
// 			SM.C.I.treeId = uSetting.zTreeId;
// 			var treeSetting = {
// 				async: {
// 					enable: true,
// 					url: uSetting.url,
// 					autoParam: uSetting.autoParam,
// 					otherParam: uSetting.otherParam,
// 					dataFilter: SM.ZU.filter
// 				},
// 				view: {expandSpeed: "",
// 					addHoverDom: uSetting.zTreeAddHoverDom,
// 					removeHoverDom: SM.ZU.removeHoverDom,
// 					selectedMulti: false
// 				},
// 				edit: {
// 					enable: true
// 				},
// 				data: {
// 					simpleData: {
// 						enable: true
// 					}
// 				},
// 				callback: {
// 					beforeRemove: uSetting.zTreeBeforeRemove,
// 					beforeRename: uSetting.zTreeBeforeRename,
// 					beforeDrop: uSetting.zTreeBeforeDrop,
// 					onClick: uSetting.zTreeOnClick
// 				}
// 			};
// 			return treeSetting;
// 		}
// 	}
// };
