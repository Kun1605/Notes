// /*
//  * Sungness信息源管理系统 - 网页嵌入脚本
//  * 版权所有©2013 Sungness.com 保留所有权利
//  *
//  * @category  ajax in web page
//  * @package   infosource
//  * @author    wanghongwei <sungness@163.com>
//  * @copyright 2013 sungness.com.
//  * @link      http://www.sungness.com/
//  */
// var WebsiteClass = {
// 	C: { // Config
// 		I: { // Init
// 			zTreeId: 'contentTree',
// 			curWebsiteTypeId: ''
// 		},
//
// 		S: { // Selector
// 			ZtreeContentDivId: 'ztreeContentDivId',
// 			WebsiteTypeId: 'websiteTypeId',
// 			AddChildFormId: 'addChildFormId',
// 			EditFormId: 'editFormId',
// 			WebsiteClassListURL: '/menu/websiteClassList',
// 			WebsiteClassAddURL: '/menu/websiteClassAdd',
// 			WebsiteClassEditURL: '/menu/websiteClassEdit',
// 			WebsiteClassDeleteURL: '/menu/websiteClassDelete'
// 		}
// 	},
//
// 	U: {
// 		printInvalidAlert: function(invalidAlertMap) {
// 			if (!invalidAlertMap) return "";
// 			var alertText = "";
// 			for (var i=0; i< invalidAlertMap.length; i++) {
// 				alertText += "\n－－" + invalidAlertMap[i][1];
// 			}
// 		},
//
// 		treeOnClick: function(treeId, treeNode) {
// 			window.event.cancelBubble = true;
// 			var formObj = $('#' + WebsiteClass.C.S.EditFormId);
// 			formObj.find("legend").text("修改分类－" + treeNode.name);
// 			var parentNode = treeNode.getParentNode();
// 			if (parentNode == null) {
// 				formObj.find("input[name=parentId]").val("0");
// 			} else {
// 				formObj.find("input[name=parentId]").val(parentNode.dataBean.websiteClassId);
// 			}
// 			formObj.find("input[name=websiteClassId]").val(treeNode.dataBean.websiteClassId);
// 			formObj.find("input[name=websiteClassName]").val(treeNode.dataBean.websiteClassName);
// 			formObj.find("textarea[name=websiteClassRef]").val(treeNode.dataBean.websiteClassRef);
// 			var childFormObj = $('#' + WebsiteClass.C.S.AddChildFormId);
// 			childFormObj.find("input[name=parentId]").val(treeNode.dataBean.websiteClassId);
// 			childFormObj.css("display", "");
// 		},
//
// 		cancelAllSelectedNode: function() {
// 			window.event.cancelBubble=true;
// 			var treeObj = $.fn.zTree.getZTreeObj("contentTree");
// 			treeObj.cancelEditName();
// 			treeObj.cancelSelectedNode();
// 			var formObj = $('#' + WebsiteClass.C.S.EditFormId);
// 			formObj.attr("action", WebsiteClass.C.S.WebsiteClassAddURL);
// 			formObj.find("legend").text("添加根分类");
// 			formObj.find("input[name=parentId]").val("0");
// 			formObj.find("input[name=websiteClassId]").val("");
// 			formObj.find("input[name=websiteClassName]").val("");
// 			formObj.find("textarea[name=websiteClassRef]").val("");
// 			var childFormObj = $('#' + WebsiteClass.C.S.AddChildFormId);
// 			childFormObj.find("input[name=parentId]").val("");
// 			childFormObj.find("input[name=websiteClassName]").val("");
// 			childFormObj.find("textarea[name=websiteClassRef]").val("");
// 			childFormObj.css("display", "none");
// 		},
//
// 		submitNode: function(nodeForm) {
// 			var dataBean = {
// 				parentId: nodeForm.find("input[name=parentId]").val(),
// 				websiteClassId: nodeForm.find("input[name=websiteClassId]").val(),
// 				websiteClassName: nodeForm.find("input[name=websiteClassName]").val(),
// 				websiteClassRef: nodeForm.find("textarea[name=websiteClassRef]").val(),
// 				websiteTypeId: WebsiteClass.C.I.curWebsiteTypeId
// 			};
// 			if (!isNaN(parseInt(dataBean.websiteClassId)) && dataBean.websiteClassId > 0) {
// 				//修改
// 				$.getJSON(
// 					WebsiteClass.C.S.WebsiteClassEditURL,
// 					{
// 						parentId: dataBean.parentId,
// 						websiteClassId: dataBean.websiteClassId,
// 						websiteClassName: dataBean.websiteClassName,
// 						websiteClassRef: dataBean.websiteClassRef,
// 						websiteTypeId: dataBean.websiteTypeId
// 					},
// 					function(jsonData){
// 						if (jsonData.success == true) {
// 							var zTree = $.fn.zTree.getZTreeObj(WebsiteClass.C.I.zTreeId);
// 							var oldNode = zTree.getNodeByParam("id", dataBean.websiteClassId, null);
// 							oldNode.name = dataBean.websiteClassName;
// 							oldNode.dataBean = dataBean;
// 							zTree.updateNode(oldNode);
// 							alert("修改分类成功。");
// 						} else {
// 							alert("修改分类失败，"
// 									+ jsonData.errorMessage
// 									+ WebsiteClass.U.printInvalidAlert(jsonData.invalidAlertMap));
// 						}
// 					}
// 				);
// 			} else {
// 				//添加根节点
// 				$.getJSON(
// 					WebsiteClass.C.S.WebsiteClassAddURL,
// 					{
// 						parentId: dataBean.parentId,
// 						websiteClassName: dataBean.websiteClassName,
// 						websiteClassRef: dataBean.websiteClassRef,
// 						websiteTypeId: dataBean.websiteTypeId
// 					},
// 					function(jsonData){
// 						if (jsonData.success == true) {
// 							dataBean.websiteClassId = jsonData.res;
// 							var newNode = {
// 								id: jsonData.res,
// 								pId: dataBean.parentId,
// 								name: dataBean.websiteClassName,
// 								dataBean: dataBean
// 							};
// 							var zTree = $.fn.zTree.getZTreeObj(WebsiteClass.C.I.zTreeId);
// 							zTree.addNodes(null, newNode);
// 							nodeForm.find("input[name=websiteClassName]").val("");
// 							nodeForm.find("textarea[name=websiteClassRef]").val("");
// 							alert("添加根分类成功。");
// 						} else {
// 							alert("添加根分类失败，"
// 									+ jsonData.errorMessage
// 									+ WebsiteClass.U.printInvalidAlert(jsonData.invalidAlertMap));
// 						}
// 					}
// 				);
// 			}
// 		},
//
// 		submitChildNode: function(nodeForm) {
// 			var dataBean = {
// 				parentId: nodeForm.find("input[name=parentId]").val(),
// 				websiteClassName: nodeForm.find("input[name=websiteClassName]").val(),
// 				websiteClassRef: nodeForm.find("textarea[name=websiteClassRef]").val(),
// 				websiteTypeId: WebsiteClass.C.I.curWebsiteTypeId
// 			};
//
// 			$.getJSON(
// 				WebsiteClass.C.S.WebsiteClassAddURL,
// 				{
// 					parentId: dataBean.parentId,
// 					websiteClassName: dataBean.websiteClassName,
// 					websiteClassRef: dataBean.websiteClassRef
// 				},
// 				function(jsonData){
// 					if (jsonData.success == true) {
// 						dataBean.websiteClassId = jsonData.res;
// 						var newNode = {
// 							id: jsonData.res,
// 							pId: dataBean.parentId,
// 							name: dataBean.websiteClassName,
// 							dataBean: dataBean
// 						};
// 						var zTree = $.fn.zTree.getZTreeObj(WebsiteClass.C.I.zTreeId);
// 						var parentNode = zTree.getNodeByParam("id", dataBean.parentId, null);
// 						zTree.addNodes(parentNode, newNode);
// 						nodeForm.find("input[name=websiteClassName]").val("");
// 						nodeForm.find("textarea[name=websiteClassRef]").val("");
// 						alert("添加子分类成功。");
// 					} else {
// 						alert("添加子分类失败，"
// 								+ jsonData.errorMessage
// 								+ WebsiteClass.U.printInvalidAlert(jsonData.invalidAlertMap));
// 					}
// 				}
// 			);
// 		},
//
// 		deleteChildNode: function(websiteClassId) {
// 			var delSuccess = false;
//
// 			$.ajax({
// 				type: "GET",
// 				url: WebsiteClass.C.S.WebsiteClassDeleteURL,
// 				dataType: "json",
// 				async: false,
// 				data: {
// 					websiteClassId: websiteClassId
// 				},
// 				success: function(jsonData){
// 					delSuccess = jsonData.success;
// 					if (jsonData.success != true) {
// 						alert("删除分类节点失败，"
// 								+ jsonData.errorMessage
// 								+ WebsiteClass.U.printInvalidAlert(jsonData.invalidAlertMap));
// 					}
// 				}
// 			});
// 			return delSuccess;
// 		},
//
// 		updateNode: function(dataBean) {
// 			var updateSuccess = false;
// 			//修改
// 			$.ajax({
// 				type: "POST",
// 				url: WebsiteClass.C.S.WebsiteClassEditURL,
// 				dataType: "json",
// 				async: false,
// 				data: {
// 					parentId: dataBean.parentId,
// 					websiteClassId: dataBean.websiteClassId,
// 					websiteClassName: dataBean.websiteClassName,
// 					websiteClassRef: dataBean.websiteClassRef,
// 					websiteTypeId: dataBean.websiteTypeId
// 				},
// 				success: function(jsonData){
// 					updateSuccess = jsonData.success;
// 					if (jsonData.success != true) {
// 						alert("修改分类节点失败，"
// 								+ jsonData.errorMessage
// 								+ WebsiteClass.U.printInvalidAlert(jsonData.invalidAlertMap));
// 					}
// 				}
// 			});
// 			return updateSuccess;
// 		},
//
// 		moveNode: function(ids, parentId) {
// 			var moveRes = false;
// 			//修改
// 			$.ajax({
// 				type: "POST",
// 				url: WebsiteClass.C.S.WebsiteClassEditURL,
// 				dataType: "json",
// 				async: false,
// 				data: {
// 					editType: "move",
// 					parentId: parentId,
// 					websiteClassIdList: ids
// 				},
// 				success: function(jsonData){
// 					moveRes = jsonData.success;
// 					if (jsonData.success != true) {
// 						alert("移动分类节点失败，"
// 								+ jsonData.errorMessage
// 								+ WebsiteClass.U.printInvalidAlert(jsonData.invalidAlertMap));
// 					}
// 				}
// 			});
// 			return moveRes;
// 		}
// 	},
//
// 	Init: {
// 		InitConfig: function(config) {
// 			WebsiteClass.C.I.curWebsiteTypeId = config.curWebsiteTypeId;
// 		},
//
// 		FormInit: function() {
// 			$('#' + WebsiteClass.C.S.WebsiteTypeId).val(WebsiteClass.C.I.curWebsiteTypeId);
// 			$('#' + WebsiteClass.C.S.QueryFormId).attr("action", WebsiteClass.C.S.WebsiteClassListURL);
// 			$('#' + WebsiteClass.C.S.WebsiteTypeId).change(function() {
// 				$('#' + WebsiteClass.C.S.QueryFormId).submit();
// 			});
// 			$('#' + WebsiteClass.C.S.ZtreeContentDivId).click(function() {
// 				WebsiteClass.U.cancelAllSelectedNode();
// 				return false;
// 			});
// 			$('#' + WebsiteClass.C.S.EditFormId).attr("action", WebsiteClass.C.S.WebsiteClassEditURL);
// 			$('#' + WebsiteClass.C.S.AddChildFormId).css("display", "none");
//
// 			$('#' + WebsiteClass.C.S.EditFormId).submit(function() {
// 				WebsiteClass.U.submitNode($(this));
// 				return false;
// 			});
//
// 			$('#' + WebsiteClass.C.S.AddChildFormId).submit(function() {
// 				WebsiteClass.U.submitChildNode($(this));
// 				return false;
// 			});
// 		},
//
// 		getSetting: function() {
// 			return {
// 				zTreeId: WebsiteClass.C.I.zTreeId,
// 				url: WebsiteClass.C.S.WebsiteClassListURL,
// 				autoParam: ["id=parentId"],
// 				otherParam: {
// 					"viewType": "json",
// 					"websiteTypeId": WebsiteClass.C.I.curWebsiteTypeId
// 				},
//
// 				zTreeAddHoverDom: function(treeId, treeNode) {
// 					var sObj = $("#" + treeNode.tId + "_span");
// 					if ($("#addBtn_"+treeNode.id).length>0) return;
// 					var addStr = "<span class='button add' id='addBtn_" + treeNode.id
// 						+ "' title='add node' onfocus='this.blur();'></span>";
// 					sObj.append(addStr);
// 					var btn = $("#addBtn_"+treeNode.id);
// 					if (btn) btn.bind("click", function() {
// 						WebsiteClass.U.treeOnClick(treeId, treeNode);
// 						$.fn.zTree.getZTreeObj(treeId).selectNode(treeNode);
// 						$('#' + WebsiteClass.C.S.AddChildFormId).find("input[name=websiteClassName]").focus();
// 					});
// 				},
//
// 				zTreeOnClick: function(event, treeId, treeNode) {
// 					WebsiteClass.U.treeOnClick(treeId, treeNode);
// 				},
//
// 				zTreeBeforeRemove: function(treeId, treeNode) {
// 					var zTree = $.fn.zTree.getZTreeObj(treeId);
// 					zTree.selectNode(treeNode);
// 					if (treeNode.isParent) {
// 						alert("该节点下有子节点，不能删除！");
// 						zTree.expandNode(treeNode, true);
// 						return false;
// 					}
// 					if (confirm("确认删除 节点 -- " + treeNode.name + " 吗？")
// 						&& WebsiteClass.U.deleteChildNode(treeNode.id)) {
// 						return true;
// 					}
// 					return false;
// 				},
//
// 				zTreeBeforeRename: function(treeId, treeNode, newName) {
// 					var zTree = $.fn.zTree.getZTreeObj(treeId);
// 					if (newName.length == 0) {
// 						alert("节点名称不能为空.");
// 						zTree.editName(treeNode);
// 						return false;
// 					}
// 					dataBean = treeNode.dataBean;
// 					if (newName == dataBean.websiteClassName) {
// 						zTree.editName(treeNode);
// 						return false;
// 					}
// 					dataBean.websiteClassName = newName;
// 					var updateRes = WebsiteClass.U.updateNode(dataBean);
// 					if (!updateRes) {
// 						zTree.editName(treeNode);
// 					}
// 					return updateRes;
// 				},
//
// 				zTreeBeforeDrop: function(treeId, treeNodes, targetNode, moveType) {
// 					var parentId = 0;
// 					if (targetNode != null) {
// 						if (moveType == "inner") {
// 							//子节点
// 							parentId = targetNode.id;
// 						} else {
// 							//同级节点
// 							if (targetNode.parentTId) {
// 								parentId = targetNode.getParentNode().id;
// 							}
// 						}
// 					}
// 					var ids = "";
// 					for (var i = 0; i < treeNodes.length; i++) {
// 						ids += treeNodes[i].id + ",";
// 					}
// 					return WebsiteClass.U.moveNode(ids, parentId);
// 				}
// 			};
// 		}
// 	}
// };
//
