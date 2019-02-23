package com.msymobile.mobile.context.api.exception.enu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *  API错误码枚举类
 * Created by wanghongwei on 01/16/17.
 */
public enum ApiErrorEnum {
    SUCCESS(0, "success", "成功"),
    BUSINESS_NOT_FOUND(1, "business not found", "商家不存在"),
    EXCEEDING_LIMIT(2, "exceeding the limit", "超过校验次数限制"),
    VALIDATE_ERROR(3, "params validate error", "参数校验失败"),
    MOBILE_VALIDATE_ERROR(4, "mobile validate error", "手机号码格式不正确"),
    CHANNEL_NULL(5, "channelCode is null", "渠道号不能为空"),
    CHANNEL_NOT_FOUND(6, "channel not found", "渠道不存在"),
    SERVICE_NOT_FOUND(7, "service not found", "业务不存在"),
    ORDER_NOT_FOUND(8, "order info not found", "订单不存在"),
    AUTHENTICATION_FAILURE(401, "authentication.failure", "身份验证失败"),
    PARAM_ERROR(-100, "param.error", "请求参数错误"),
    ACTION_ERROR(-101,"action.error", "操作失败"),
    SYSTEM_ERROR(-199, "system.error", "系统错误"),
    DATA_NULL(-197, "data is null","传输body为空"),
    UNKNOWN(-1, "unknown", "未知");

    private Integer code;
    private String localCode;
    private String description;

    private ApiErrorEnum(Integer code, String localCode, String description) {
        this.code = code;
        this.localCode = localCode;
        this.description = description;
    }

    /**
     * 根据code值获取对应的枚举值
     * @param code Integer code值
     * @return ClassEnum 枚举值，如果不存在返回 UNKNOWN
     */
    public static ApiErrorEnum valueOfCode(Integer code) {
        if (code != null) {
            for (ApiErrorEnum typeEnum: values()) {
                if (typeEnum.getValue().equals(code)) {
                    return typeEnum;
                }
            }
        }
        return UNKNOWN;
    }

    public Integer getValue() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    /**
     * 根据code 直接获取描述信息
     * @param code Integer 编码
     * @return String 对应枚举的描述，如果不是有效枚举返回“未知”
     */
    public static String getDescription(Integer code){
        return valueOfCode(code).getDescription();
    }

    /**
     * 获取枚举列表，将未知对象去掉，用于列表选项
     * @return List<NurseryGradeEnum> 学校枚举列表
     */
    public static List<ApiErrorEnum> getEnumList() {
        List<ApiErrorEnum> enumList = new ArrayList<>();
        Collections.addAll(enumList, values());
        enumList.remove(UNKNOWN);
        return enumList;
    }

    public String getLocalCode() {
        return localCode;
    }
}
