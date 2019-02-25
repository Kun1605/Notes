package com.msymobile.mobile.context.model;

import com.msymobile.mobile.context.api.exception.enu.ApiErrorEnum;
import com.sungness.core.util.DateUtil;

import java.io.Serializable;

/**
* api请求日志 Bean
*
* Created by huangshuoying on 7/30/18.
*/
public class ApiLog implements Serializable {

    /** 记录id */
    private Long id;
    /** 商户id */
    private String businessUid;
    /** 请求路径 */
    private String path;
    /** 请求时间 */
    private Long actionTime;
    /** 返回结果code */
    private Integer resCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBusinessUid() {
        return businessUid;
    }

    public void setBusinessUid(String businessUid) {
        this.businessUid = businessUid;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Long getActionTime() {
        return actionTime;
    }

    public void setActionTime(Long actionTime) {
        this.actionTime = actionTime;
    }

    public Integer getResCode() {
        return resCode;
    }

    public void setResCode(Integer resCode) {
        this.resCode = resCode;
    }

    public String getResCodeDescription(){
        return ApiErrorEnum.getDescription(resCode);
    }

    public String getFullFormatActionTime(){
        return DateUtil.fullFormat(actionTime);
    }

}