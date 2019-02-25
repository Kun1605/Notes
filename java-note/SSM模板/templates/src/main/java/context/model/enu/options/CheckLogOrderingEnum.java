package com.msymobile.mobile.context.model.enu.options;

import org.apache.commons.lang3.StringUtils;

/**
* 校验信息记录 列表排序枚举类
*
* Created by HuangDongChang on 7/21/18.
*/
public enum CheckLogOrderingEnum {
    ID_ASC(1, "a.id ASC", "checkLog.id.asc", "记录id 升序"),
    ID_DESC(2, "a.id DESC", "checkLog.id.desc", "记录id 降序"),
    BUSINESS_UID_ASC(3, "a.business_uid ASC", "checkLog.business_uid.asc", "商户id 升序"),
    BUSINESS_UID_DESC(4, "a.business_uid DESC", "checkLog.business_uid.desc", "商户id 降序"),
    BUSINESS_REQUEST_ASC(5, "a.business_request ASC", "checkLog.business_request.asc", "商家请求内容 升序"),
    BUSINESS_REQUEST_DESC(6, "a.business_request DESC", "checkLog.business_request.desc", "商家请求内容 降序"),
    THIRD_RESPONSE_ASC(7, "a.third_response ASC", "checkLog.third_response.asc", "第三方返回内容 升序"),
    THIRD_RESPONSE_DESC(8, "a.third_response DESC", "checkLog.third_response.desc", "第三方返回内容 降序"),
    CREATE_TIME_ASC(11, "a.create_time ASC", "checkLog.create_time.asc", "创建时间 升序"),
    CREATE_TIME_DESC(12, "a.create_time DESC", "checkLog.create_time.desc", "创建时间 降序");

    /** id */
    private Integer id;
    /** option选项值 */
    private String value;
    /** 本地化标识 */
    private String textCode;
    /** 描述 */
    private String description;

    CheckLogOrderingEnum(
            Integer id, String value, String textCode, String description) {
        this.id = id;
        this.value = value;
        this.textCode = textCode;
        this.description = description;
    }

    /**
    * 根据id值获取对应的枚举值
    * @param id String id值
    * @return CheckLogOrderingEnum 枚举值，如果不存在返回 null
    */
    public static CheckLogOrderingEnum valueOf(Integer id) {
        if (id != null) {
            for (CheckLogOrderingEnum orderingEnum: values()) {
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
    * @return CheckLogOrderingEnum 排序枚举值，如果不存在，返回 null
    */
    public static CheckLogOrderingEnum enumOfValue(String value) {
        if (StringUtils.isNotBlank(value)) {
            for (CheckLogOrderingEnum orderingEnum: values()) {
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
        CheckLogOrderingEnum orderingEnum = valueOf(id);
        return orderingEnum != null ? orderingEnum.getDescription() : null;
    }

    /**
     * 根据value 直接获取描述信息
     * @param value String 值字符串
     * @return String 对应枚举的描述，如果不是有效枚举返回null
     */
    public static String getDescriptionOfValue(String value) {
        CheckLogOrderingEnum orderingEnum = enumOfValue(value);
        return orderingEnum != null ? orderingEnum.getDescription() : null;
    }

    /**
     * 返回默认枚举值
     * @return CheckLogOrderingEnum 默认枚举值
     */
    public static CheckLogOrderingEnum getDefaultEnum() {
        return CREATE_TIME_DESC;
    }
}