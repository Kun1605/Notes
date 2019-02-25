package com.msymobile.mobile.manage.controller;

import com.msymobile.mobile.context.model.VacantNumberInfo;
import com.msymobile.mobile.context.model.enu.options.VacantNumberInfoOrderingEnum;
import com.msymobile.mobile.context.service.VacantNumberInfoService;
import com.msymobile.mobile.context.utils.FileUtils;
import com.msymobile.mobile.context.validator.VacantNumberInfoValidator;
import com.sungness.core.service.ServiceProcessException;
import com.sungness.core.util.tools.LongTools;
import com.sungness.framework.web.support.annotation.Command;
import com.sungness.framework.web.support.annotation.Module;
import com.sungness.manage.component.controller.ManageControllerInterface;
import com.sungness.manage.component.enu.system.ListLimitEnum;
import com.sungness.manage.component.enu.system.TaskEnum;
import com.sungness.manage.component.model.CommandResult;
import com.sungness.manage.support.query.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.zip.ZipOutputStream;

/**
 * 空号信息列管理控制器类。
 * Created by huangshuoying on 8/7/18.
 */
@Module(value = VacantNumberInfoController.MODULE_NAME + "管理", order = 6,icon = "cube")
@Controller
@RequestMapping(VacantNumberInfoController.URL_PREFIX)
public class VacantNumberInfoController implements ManageControllerInterface {
    private static final Logger log = LoggerFactory.getLogger(VacantNumberInfoController.class);

    public static final String MODULE_NAME = "空号信息列";
    public static final String URL_PREFIX = "/manage/vacant-number";

    @Autowired
    private VacantNumberInfoService vacantNumberInfoService;

    @Autowired
    private VacantNumberInfoValidator vacantNumberInfoValidator;
    /**
     * 列表页处理方法
     * @param queryFilter QueryFilter 查询条件过滤器
     * @param result BindingResult
     * @param model Model 携带操作结果对象的视图模型对象
     * @param request HttpServletRequest
     * @throws ServletException 业务处理异常
     */
    @Command(value = MODULE_NAME + "列表", isInlet = true, order = 1)
    @RequestMapping(LIST_URL)
    public void list(@ModelAttribute("queryFilter") QueryFilter queryFilter,
                     BindingResult result, Model model,
                     HttpServletRequest request)
            throws ServletException {
        queryFilter.init(request);
        if (VacantNumberInfoOrderingEnum.enumOfValue(queryFilter.getOrdering()) == null) {
            queryFilter.setOrdering(VacantNumberInfoOrderingEnum.getDefaultEnum().getValue());
        }
        try {
            List<VacantNumberInfo> vacantNumberInfoList =
                    vacantNumberInfoService.getList(queryFilter.getPagination(), queryFilter.getRealFilter());
            model.addAttribute("vacantNumberInfoList", vacantNumberInfoList);
        } catch (Exception e) {
            result.reject(e.getClass().getName(), e.getMessage());
            e.printStackTrace();
        }
        if (result.hasErrors()) {
            CommandResult<Integer> commandResult = new CommandResult<>(result.getObjectName());
            commandResult.addAllErrors(result);
            model.addAttribute("commandResult", commandResult);
        }
        model.addAttribute("orderingEnum", VacantNumberInfoOrderingEnum.values());
        model.addAttribute("limitEnum", ListLimitEnum.values());
        queryFilter.setForWeb();
    }

    /**
    * 编辑处理方法，GET方式请求直接返回编辑页
    * @param id Long 记录id
    * @param model Model
    * @param backURL String 返回的url地址
    */
    @Command(value = "查看" + MODULE_NAME, order = 2)
    @RequestMapping(DETAIL_URL)
    public void detail(@RequestParam(required=false) Long id,
                       @RequestParam(required=false) String backURL, Model model) {
        VacantNumberInfo vacantNumberInfo = vacantNumberInfoService.get(id);
        if (vacantNumberInfo.getId() == null) {
            CommandResult<Integer> commandResult = new CommandResult<>("");
            commandResult.setSuccess(false);
            commandResult.setTitle("JGLOBAL_WARN");
            commandResult.setMessage("JGLOBAL_NO_MATCHED");
        }
        model.addAttribute("vacantNumberInfo", vacantNumberInfo);
        model.addAttribute("backURL", backURL);
    }

    /**
     * 编辑处理方法，GET方式请求直接返回编辑页
     * @param id Long 记录id
     * @param model Model
     * @param backURL String 返回的url地址
     */
    @Command(value = "编辑" + MODULE_NAME, showInMenu = true, alias= "增加" + MODULE_NAME, order = 3)
    @RequestMapping(EDIT_URL)
    public void editGet(@RequestParam(required=false) Long id,
                        @RequestParam(required=false) String backURL, Model model) {
        if (!model.containsAttribute("vacantNumberInfo")) {
            model.addAttribute("vacantNumberInfo", vacantNumberInfoService.getSafety(id));
        }
        model.addAttribute("backURL", backURL);
    }

    /**
     * 编辑处理方法，POST方式提交处理表单
     * @param vacantNumberInfo VacantNumberInfo 空号信息列对象
     * @param result BindingResult 表单对象验证结果
     * @return CommandResult<Integer> 操作结果对象
     * @throws ServletException
     */
    @Command("保存" + MODULE_NAME)
    @RequestMapping(value="/save")
    public String save(VacantNumberInfo vacantNumberInfo, BindingResult result,
                       @RequestParam(required=false) String task,
                       @RequestParam(required=false) String backURL,
                       RedirectAttributes model) throws ServletException {
        vacantNumberInfoValidator.validate(vacantNumberInfo, result);
        CommandResult<Integer> commandResult = new CommandResult<>(result.getObjectName());
        if (!result.hasErrors()) {
            try {
                if (LongTools.lessEqualZero(vacantNumberInfo.getId())) {
                    commandResult.setRes(vacantNumberInfoService.insert(vacantNumberInfo));
                    commandResult.setMessage(MODULE_NAME + "信息已添加");
                } else {
                    commandResult.setRes(vacantNumberInfoService.update(vacantNumberInfo));
                    commandResult.setMessage(MODULE_NAME + "信息已保存");
                }
            } catch (ServiceProcessException spe) {
                result.rejectValue(spe.getField(), spe.getErrorCode(), spe.getDefaultMessage());
                spe.printStackTrace();
            } catch (Exception e) {
                result.reject(e.getClass().getName(), e.getMessage());
                e.printStackTrace();
            }
        }

        commandResult.addAllErrors(result);
        StringBuilder redirectStb = new StringBuilder("redirect:");
        redirectStb.append(URL_PREFIX);
        if (commandResult.isSuccess()) {
            switch (TaskEnum.valueOfCode(task)) {
                case SAVE://保存 & 关闭-返回列表页
                    redirectStb.append(LIST_URL);
                    break;
                case SAVE2NEW://保存 & 新增-返回空白编辑页
                    redirectStb.append(EDIT_URL);
                    break;
                default://保存-返回当前记录编辑页，apply 及其他
                    model.addFlashAttribute("vacantNumberInfo", vacantNumberInfo);
                    redirectStb.append(EDIT_URL);
                    redirectStb.append("?id=").append(vacantNumberInfo.getId());
                    break;
            }
        } else {
            model.addFlashAttribute("vacantNumberInfo", vacantNumberInfo);
            redirectStb.append(EDIT_URL);
            if (LongTools.greaterThanZero(vacantNumberInfo.getId())) {
                redirectStb.append("?id=").append(vacantNumberInfo.getId());
            }
        }
        model.addFlashAttribute("commandResult", commandResult);
        return redirectStb.toString();
    }

    /**
     * 删除记录
     * @param id String 记录id字符串，多个id以逗号分隔
     * @return CommandResult<Integer> 操作结果对象
     */
    @Command("删除" + MODULE_NAME)
    @RequestMapping("/delete")
    public String delete(@RequestParam(required=true) String id,
                         @RequestParam(required=false) String backURL,
                         RedirectAttributes model) {
        CommandResult<Integer> commandResult = new CommandResult<>("");
        try {
            int res = vacantNumberInfoService.batchDelete(LongTools.parseList(id));
            if (res > 0) {
                commandResult.setSuccess(true);
                commandResult.setMessage("选中的记录已成功删除。");
                commandResult.setRes(res);
            } else {
                commandResult.reject("JGLOBAL_NO_MATCHED", "没有匹配的记录");
            }
        } catch (ServiceProcessException spe) {
            spe.printStackTrace();
            commandResult.reject(spe.getErrorCode(), spe.getDefaultMessage());
        } catch (Exception e) {
            e.printStackTrace();
            commandResult.reject(e.getClass().getName(), e.getMessage());
        }
        model.addFlashAttribute("commandResult", commandResult);
        if (StringUtils.isNotBlank(backURL)) {
            return "redirect:" + backURL;
        } else {
            return String.format("redirect:%s%s", URL_PREFIX, LIST_URL);
        }
    }

    /**
     * 跳转到批量生成号码页面
     */
    @Command("批量生成" + MODULE_NAME)
    @RequestMapping("/batch")
    public void batch() {
        log.debug("batch");
    }

    /**
     * 将生成的号码文件压缩zip下载
     * @param phonePrefix 手机号码段号
     * @param filePhoneNum  单个文件的号码个数
     */
    @Command(MODULE_NAME + "下载")
    @RequestMapping("/download")
    public void download(@RequestParam String phonePrefix
                        ,@RequestParam int filePhoneNum
                        ,HttpServletResponse response) throws IOException {
        String fileName = phonePrefix + "phones.zip";
        List<File> files = FileUtils.download(phonePrefix, filePhoneNum);
        response.setHeader("X-Frame-Options", "SAMEORIGIN");
        response.setHeader(
                "Content-Disposition",
                String.format("attachment; filename=\"%s\"", URLEncoder.encode(fileName, "UTF-8")));
        ZipOutputStream out = new ZipOutputStream(response.getOutputStream());
        FileUtils.zipFiles(files, out);
        out.close();
    }

    /**
     * 跳转到上传文件页面
     */
    @Command("导入" + MODULE_NAME)
    @RequestMapping("/upload")
    public void upload(@RequestParam(required=false) String backURL, Model model) {
        model.addAttribute("backURL", backURL);
    }

    @Command("保存" + MODULE_NAME)
    @RequestMapping("/uploadSave")
    public String uploadSave(MultipartFile file,
                       @RequestParam(required=false) String task,
                       @RequestParam(required=false) String backURL,
                       RedirectAttributes model) {
        CommandResult<Integer> commandResult = new CommandResult<>("");
        if(file.isEmpty()){
            commandResult.addError(new ObjectError("警告","未选择文件！"));
            commandResult.setSuccess(false);
        }
        if (!commandResult.hasErrors()) {
            try {
                vacantNumberInfoService.parseFile(file);
                commandResult.setSuccess(true);
                commandResult.setMessage("目录文件上传成功");
            } catch (Exception e) {
                commandResult.setMessage("解析信息文件上传失败，请检查文件格式或联系管理员");
                commandResult.reject(e.getClass().getName(), e.getMessage());
                e.printStackTrace();
            }
        }
        StringBuilder redirectStb = new StringBuilder("redirect:");
        if (commandResult.isSuccess()) {
            switch (TaskEnum.valueOfCode(task)) {
                case SAVE://保存 & 关闭-返回列表页
                    redirectStb.append(URL_PREFIX+LIST_URL);
                    break;
                case SAVE2NEW://保存 & 新增-返回空白编辑页
                    model.addFlashAttribute("backURL", backURL);
                    redirectStb.append(URL_PREFIX + UPLOAD_URL);
                    break;
                default://保存-返回当前记录编辑页，apply 及其他
                    model.addFlashAttribute("backURL", backURL);
                    redirectStb.append(URL_PREFIX + UPLOAD_URL);
                    break;
            }
        } else {
            model.addFlashAttribute("backURL", backURL);
            redirectStb.append(URL_PREFIX + UPLOAD_URL);
        }
        model.addFlashAttribute("commandResult", commandResult);
        return redirectStb.toString();
    }
}
