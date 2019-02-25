package com.msymobile.mobile.context.service;

import com.msymobile.mobile.context.dao.ApiLogMapper;
import com.msymobile.mobile.context.model.ApiLog;
import com.sungness.core.dao.GenericMapper;
import com.sungness.core.service.LongPKBaseService;
import com.sungness.core.service.ServiceProcessException;
import com.sungness.core.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
* api请求日志 业务处理类
*
* Created by huangshuoying on 7/30/18.
*/
@Service
public class ApiLogService
        extends LongPKBaseService<ApiLog> {
    private static final Logger log = LoggerFactory.getLogger(ApiLogService.class);

    @Autowired
    private ApiLogMapper apiLogMapper;

    /**
    * 获取数据层mapper接口对象，子类必须实现该方法
    *
    * @return GenericMapper<E, PK> 数据层mapper接口对象
    */
    @Override
    protected GenericMapper<ApiLog, Long> getMapper() {
        return apiLogMapper;
    }

    /**
    * 根据id获取对象，如果为空，返回空对象
    * @param id Long 公司id
    * @return ApiLog api请求日志对象
    */
    public ApiLog getSafety(Long id) {
        ApiLog apiLog = get(id);
        if (apiLog == null) {
            apiLog = new ApiLog();
        }
        return apiLog;
    }

    @Async
    public void save(String uid, String path, Integer resCode){
        ApiLog apiLog = new ApiLog();
        if(StringUtils.isNoneBlank(uid)){
            apiLog.setBusinessUid(uid);
        }else {
            apiLog.setBusinessUid("anonymous");
        }
        apiLog.setPath(path);
        apiLog.setResCode(resCode);
        apiLog.setActionTime(DateUtil.getTimestamp());
        try {
            insert(apiLog);
        } catch (ServiceProcessException e) {
            e.printStackTrace();
        }
    }
}