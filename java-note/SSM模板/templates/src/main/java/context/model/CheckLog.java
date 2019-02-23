package com.msymobile.mobile.context.model;

import com.msymobile.mobile.context.model.enu.ResultEnum;
import com.sungness.core.util.DateUtil;

import java.io.Serializable;

/**
* 校验信息记录 Bean
*
* Created by HuangDongChang on 7/21/18.
*/
public class CheckLog implements Serializable {

    /** 记录id */
    private Long id;
    /** 渠道编号 */
    private String channelCode;
    /** 订单id */
    private String oid;
    /** 商户id */
    private String businessUid;
    /** 商家请求内容 */
    private String businessRequest;
    /** 第三方返回内容 */
    private String thirdResponse;
    /** 商家返回結果 */
    private String businessResult;
    /** 请求结果 */
    private Integer status;
    /** 创建时间 */
    private Long createTime;

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

    public String getBusinessRequest() {
        return businessRequest;
    }

    public void setBusinessRequest(String businessRequest) {
        this.businessRequest = businessRequest;
    }

    public String getThirdResponse() {
        return thirdResponse;
    }

    public void setThirdResponse(String thirdResponse) {
        this.thirdResponse = thirdResponse;
    }

    public String getBusinessResult() {
        return businessResult;
    }

    public void setBusinessResult(String businessResult) {
        this.businessResult = businessResult;
    }

    public Long getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Long createTime) {
        this.createTime = createTime;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getFormatCreateTime(){
        return DateUtil.fullFormat(createTime);
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStatusEnum(){
        return ResultEnum.getDescription(status);
    }
}