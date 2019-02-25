package com.msymobile.mobile.context.api.exception;


import com.msymobile.mobile.context.api.exception.enu.ApiErrorEnum;

/**
 * API处理过成功抛出的异常封装类，统一将service层的异常封装成 ApiException，
 * 便于ApiResult处理。
 * 注：客户端如果配置了本地化策略，则可以使用localCode匹配的信息进行提示，否则可使用
 * message直接提示用户，可根据code编号判断是成功还是失败。
 * Created by wanghongwei on 14/02/2017.
 */
public class ApiException extends Exception {
    /** 错误编号，对应ApiErrorEnum中的code */
    private Integer code;

    /** 本地化错误编码 */
    private String localCode;

    /**
     * Constructs a ApiException with specify code, localCode and
     * message. A detail message is a String that describes this
     * particular exception.
     */
    public ApiException(Integer code, String localCode, String message) {
        super(message);
        this.code = code;
        this.localCode = localCode;
    }

    /**
     * Constructs a ApiException with a ApiErrorEnum
     * message. A detail message is a String that describes this
     * particular exception.
     */
    public ApiException(ApiErrorEnum apiErrorEnum) {
        super(apiErrorEnum.getDescription());
        this.code = apiErrorEnum.getValue();
        this.localCode = apiErrorEnum.getLocalCode();
    }

    /**
     * Constructs a ApiException with no detail
     * message. A detail message is a String that describes this
     * particular exception.
     */
    public ApiException() {
        super();
    }

    /**
     * Constructs a ApiException with the specified
     * detail message. A detail message is a String that describes
     * this particular exception, which may, for example, specify which
     * algorithm is not available.
     *
     * @param msg the detail message.
     */
    public ApiException(String msg) {
        super(msg);
    }

    /**
     * Creates a <code>ApiException</code> with the specified
     * detail message and cause.
     *
     * @param message the detail message (which is saved for later retrieval
     *        by the {@link #getMessage()} method).
     * @param cause the cause (which is saved for later retrieval by the
     *        {@link #getCause()} method).  (A <tt>null</tt> value is permitted,
     *        and indicates that the cause is nonexistent or unknown.)
     */
    public ApiException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Creates a <code>ApiException</code> with the specified cause
     * and a detail message of <tt>(cause==null ? null : cause.toString())</tt>
     * (which typically contains the class and detail message of
     * <tt>cause</tt>).
     *
     * @param cause the cause (which is saved for later retrieval by the
     *        {@link #getCause()} method).  (A <tt>null</tt> value is permitted,
     *        and indicates that the cause is nonexistent or unknown.)
     */
    public ApiException(Throwable cause) {
        super(cause);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getLocalCode() {
        return localCode;
    }

    public void setLocalCode(String localCode) {
        this.localCode = localCode;
    }
}
