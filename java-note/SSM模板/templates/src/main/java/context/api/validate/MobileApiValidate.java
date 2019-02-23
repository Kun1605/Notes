package com.msymobile.mobile.context.api.validate;

import com.msymobile.mobile.context.api.exception.ApiException;
import com.msymobile.mobile.context.api.exception.enu.ApiErrorEnum;
import com.msymobile.mobile.context.model.BusinessInfo;
import com.msymobile.mobile.context.model.enu.ServiceCodeEnum;
import com.msymobile.mobile.context.service.BusinessInfoService;
import com.sungness.core.service.ServiceProcessException;
import com.sungness.core.util.GsonUtils;
import com.sungness.core.util.tools.IntegerTools;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by huanghsuoying on 2018/7/24.
 */
@Component
public class MobileApiValidate {


    @Autowired
    private BusinessInfoService businessInfoService;

    public Map<String,String> validateParams(BusinessInfo businessInfo,String jsonData) throws ApiException, ServiceProcessException {
        if (StringUtils.isBlank(jsonData)){
            throw new ApiException(
                    ApiErrorEnum.VALIDATE_ERROR);
        }
        if (StringUtils.isBlank(businessInfo.getUid())){
            throw new ApiException(
                    ApiErrorEnum.BUSINESS_NOT_FOUND);
        }
        validateNumber(businessInfo);
        String mobiles = GsonUtils.toStrStrMap(jsonData).get("mobile");

        validateChannelCode(GsonUtils.toStrStrMap(jsonData).get("channelCode"));

        if (StringUtils.isBlank(mobileValidate(mobiles).get("validMobile"))){
            throw new ApiException(
                    ApiErrorEnum.MOBILE_VALIDATE_ERROR);
        }


        if (mobiles.split(",").length > 50){
            throw new ApiException(
                    ApiErrorEnum.PARAM_ERROR);
        }
        return mobileValidate(mobiles);
    }

    public void validateRegisterParams(String jsonData,
                                       String channelCode,
                                       String mobile,
                                       Integer serviceCode) throws ApiException {
        if (StringUtils.isBlank(jsonData)){
            throw new ApiException(
                    ApiErrorEnum.VALIDATE_ERROR);
        }
        validateChannelCode(channelCode);
        validateServiceCode(serviceCode);
        validateMobile(mobile);
    }

    public void validateChannelCode(String channelCode) throws ApiException {
        if (StringUtils.isBlank(channelCode)){
            throw new ApiException(
                    ApiErrorEnum.CHANNEL_NULL);
        }
    }

    public void validateServiceCode(Integer serviceCode) throws ApiException {
        if (IntegerTools.lessEqualZero(serviceCode)
                || ServiceCodeEnum.valueOf(serviceCode) == ServiceCodeEnum.UNKNOWN){
            throw new ApiException(
                    ApiErrorEnum.SERVICE_NOT_FOUND);
        }
    }

    public void validateMobile(String mobile) throws ApiException {
        String regex = "^1\\d{10}$";
        if(!isValid(mobile,regex)){
            throw new ApiException(
                    ApiErrorEnum.MOBILE_VALIDATE_ERROR);
        }
    }

    public void validateOrderId(String orderId) throws ApiException {
        if (StringUtils.isBlank(orderId)){
            throw new ApiException(
                    ApiErrorEnum.ORDER_NOT_FOUND);
        }
    }

    /**
     * 验证次数限制
     * @throws ApiException 验证无效时抛出的异常对象
     */
    public void validateNumber(BusinessInfo businessInfo) throws ApiException, ServiceProcessException {
        Integer validateAmountLimit = businessInfo.getValidateAmountLimit();
        if (validateAmountLimit == 0){
            //次数为0，不能检测
            throw new ApiException(
                    ApiErrorEnum.EXCEEDING_LIMIT);
        }
        if (!IntegerTools.lessEqualZero(validateAmountLimit)){
            //限次数,每调用一次就减一
            -- validateAmountLimit;
            businessInfo.setValidateAmountLimit(validateAmountLimit);
        }
        businessInfoService.update(businessInfo);
    }

    /**
     * 校验手机号码格式
     * @param mobiles 号码列表
     */
    public static Map<String,String> mobileValidate(String mobiles){

        String regex = "^1\\d{10}$";

        StringBuilder validMobile = new StringBuilder();
        StringBuilder notValidMobile = new StringBuilder();
        Map<String,String> result = new HashMap<>();
        if (mobiles.contains(",")){
            String[] mobile = mobiles.split(",");
            for (int i = 0; i < mobile.length; i++) {
                if (isValid(mobile[i],regex)) {
                    validMobile.append(mobile[i]).append(",");
                }else{
                    notValidMobile.append(mobile[i]).append(",");
                }
            }
        }else{
            if (isValid(mobiles,regex)) {
                validMobile.append(mobiles).append(",");
            }else{
                notValidMobile.append(mobiles).append(",");
            }
        }

        if (!IntegerTools.lessEqualZero(validMobile.length())) {
            result.put("validMobile", validMobile.substring(0, validMobile.length() - 1));
        }
        if (!IntegerTools.lessEqualZero(notValidMobile.length())) {
            result.put("notValidMobile", notValidMobile.substring(0, notValidMobile.length() - 1));
        }
        return result;
    }

    public static Boolean isValid(String mobile,String regex){

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(mobile);
        if (matcher.matches()){
            return true;
        }else{
            return false;
        }
    }

}
