package com.msymobile.mobile.context.model.enu.options;

import org.apache.commons.lang3.StringUtils;

/**
* api请求日志 列表排序枚举类
*
* Created by huangshuoying on 7/30/18.
*/
public enum ApiLogOrderingEnum {
    ID_ASC(1, "a.id ASC", "apiLog.id.asc", "记录id 升序"),
    ID_DESC(2, "a.id DESC", "apiLog.id.desc", "记录id 降序"),
    BUSINESS_UID_ASC(3, "a.business_uid ASC", "apiLog.business_uid.asc", "商户id 升序"),
    BUSINESS_UID_DESC(4, "a.business_uid DESC", "apiLog.business_uid.desc", "商户id 降序"),
    PATH_ASC(5, "a.path ASC", "apiLog.path.asc", "请求路径 升序"),
    PATH_DESC(6, "a.path DESC", "apiLog.path.desc", "请求路径 降序"),
    ACTION_TIME_ASC(7, "a.action_time ASC", "apiLog.action_time.asc", "请求时间 升序"),
    ACTION_TIME_DESC(8, "a.action_time DESC", "apiLog.action_time.desc", "请求时间 降序"),
    RES_CODE_ASC(9, "a.res_code ASC", "apiLog.res_code.asc", "返回结果code 升序"),
    RES_CODE_DESC(10, "a.res_code DESC", "apiLog.res_code.desc", "返回结果code 降序");

    /** id */
    private Integer id;
    /** option选项值 */
    private String value;
    /** 本地化标识 */
    private String textCode;
    /** 描述 */
    private String description;

    ApiLogOrderingEnum(
            Integer id, String value, String textCode, String description) {
        this.id = id;
        this.value = value;
        this.textCode = textCode;
        this.description = description;
    }

    /**
    * 根据id值获取对应的枚举值
    * @param id String id值
    * @return ApiLogOrderingEnum 枚举值，如果不存在返回 null
    */
    public static ApiLogOrderingEnum valueOf(Integer id) {
        if (id != null) {
            for (ApiLogOrderingEnum orderingEnum: values()) {
                if (orderingEnum.getId().intValue() == id.intValue()) {
                    return orderingEnum;
                }
            }
        }
        return null;
    }

    /**
    * 根据value获取对应的枚举值
    * @param value String 值字符串
    * @return ApiLogOrderingEnum 排序枚举值，如果不存在，返回 null
    */
    public static ApiLogOrderingEnum enumOfValue(String value) {
        if (StringUtils.isNotBlank(value)) {
            for (ApiLogOrderingEnum orderingEnum: values()) {
                if (orderingEnum.getValue().equals(value)) {
                    return orderingEnum;
                }
            }
        }
        return null;
    }

    public Integer getId() {
        return id;
    }

    public String getValue() {
        return value;
    }

    public String getTextCode() {
        return textCode;
    }

    public String getDescription() {
        return description;
    }

    /**
     * 根据id 直接获取描述信息
     * @param id Integer 数字编号
     * @return String 对应枚举的描述，如果不是有效枚举返回null
     */
    public static String getDescription(Integer id) {
        ApiLogOrderingEnum orderingEnum = valueOf(id);
        return orderingEnum != null ? orderingEnum.getDescription() : null;
    }

    /**
     * 根据value 直接获取描述信息
     * @param value String 值字符串
     * @return String 对应枚举的描述，如果不是有效枚举返回null
     */
    public static String getDescriptionOfValue(String value) {
        ApiLogOrderingEnum orderingEnum = enumOfValue(value);
        return orderingEnum != null ? orderingEnum.getDescription() : null;
    }

    /**
     * 返回默认枚举值
     * @return ApiLogOrderingEnum 默认枚举值
     */
    public static ApiLogOrderingEnum getDefaultEnum() {
        return ID_ASC;
    }
}