package com.msymobile.mobile.context.validator;

import com.msymobile.mobile.context.model.CheckLog;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


/**
* CheckLog 对象验证器
* Created by HuangDongChang on 7/21/18.
*/
@Component
public class CheckLogValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return CheckLog.class.isAssignableFrom(aClass);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "businessUid", "checkLog.businessUid.error", "Business Uid is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "businessRequest", "checkLog.businessRequest.error", "Business Request is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "thirdResponse", "checkLog.thirdResponse.error", "Third Response is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "businessResult", "checkLog.businessResult.error", "Business Result is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "createTime", "checkLog.createTime.error", "Create Time is required.");
    }
}