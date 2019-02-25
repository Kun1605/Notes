package com.msymobile.mobile.context.api.response;


import com.msymobile.mobile.context.api.exception.ApiException;
import com.msymobile.mobile.context.api.exception.enu.ApiErrorEnum;

/**
 * API接口返回结果范型类
 * Created by wanghongwei on 16/01/2017.
 */
public class ApiResult<E> {
    /** 结果状态，0-成功，其他为失败 */
    private int code;
    /** 本地化错误代码 */
    private String localCode;
    /** 错误描述 */
    private String msg;
    /** 返回结果对象 */
    private E result;
    /** 是否需要加密，默认加密 */
    private boolean secret;


    private String uid;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public ApiResult() {
        this.secret = true;
    }

    public ApiResult(boolean secret) {
        this.secret = secret;
    }

    /**
     * 设置错误信息，将ApiErrorEnum枚举设置到相应字段中
     * @param apiErrorEnum ApiErrorEnum 错误枚举对象
     */
    public void setError(ApiErrorEnum apiErrorEnum) {
        this.code = apiErrorEnum.getValue();
        this.localCode = apiErrorEnum.getLocalCode();
        this.msg = apiErrorEnum.getDescription();
    }

    /**
     * 设置错误信息，将ApiException设置到相应字段中
     * @param e ApiException API处理异常对象
     */
    public void setError(ApiException e) {
        if (e.getCode() != null && e.getCode() != 0) {
            this.code = e.getCode();
        } else {
            this.code = ApiErrorEnum.SYSTEM_ERROR.getValue();
        }
        this.localCode = e.getLocalCode();
        this.msg = e.getMessage();
    }

    public E getResult() {
        return result;
    }

    public void setResult(E result) {
        this.result = result;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getLocalCode() {
        return localCode;
    }

    public void setLocalCode(String localCode) {
        this.localCode = localCode;
    }

    public boolean isSecret() {
        return secret;
    }

    public void setSecret(boolean secret) {
        this.secret = secret;
    }
}
