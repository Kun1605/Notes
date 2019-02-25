package com.msymobile.mobile.context.validator;

import com.msymobile.mobile.context.model.ApiLog;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


/**
* ApiLog 对象验证器
* Created by huangshuoying on 7/30/18.
*/
@Component
public class ApiLogValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return ApiLog.class.isAssignableFrom(aClass);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "businessUid", "apiLog.businessUid.error", "Business Uid is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "path", "apiLog.path.error", "Path is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "actionTime", "apiLog.actionTime.error", "Action Time is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors, "resCode", "apiLog.resCode.error", "Res Code is required.");
    }
}