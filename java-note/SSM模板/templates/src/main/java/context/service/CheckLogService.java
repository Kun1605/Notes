package com.msymobile.mobile.context.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.msymobile.mobile.context.api.exception.ApiException;
import com.msymobile.mobile.context.api.exception.enu.ApiErrorEnum;
import com.msymobile.mobile.context.api.validate.MobileApiValidate;
import com.msymobile.mobile.context.dao.CheckLogMapper;
import com.msymobile.mobile.context.model.BusinessInfo;
import com.msymobile.mobile.context.model.CheckLog;
import com.msymobile.mobile.context.utils.Constant;
import com.msymobile.mobile.context.utils.XMLUtils;
import com.msymobile.mobile.context.vao.CheckMobileVO;
import com.sungness.core.dao.GenericMapper;
import com.sungness.core.httpclient.HttpClientException;
import com.sungness.core.httpclient.HttpClientUtils;
import com.sungness.core.service.LongPKBaseService;
import com.sungness.core.service.ServiceProcessException;
import com.sungness.core.util.DateUtil;
import com.sungness.core.util.GsonUtils;
import com.sungness.core.util.UuidGenerator;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.msymobile.mobile.context.utils.RSAUtil.encryptStringByPrivateKey;

/**
* 校验信息记录 业务处理类
*
* Created by HuangDongChang on 7/21/18.
*/
@Service
public class CheckLogService
        extends LongPKBaseService<CheckLog> {
    private static final Logger log = LoggerFactory.getLogger(CheckLogService.class);

    @Autowired
    private CheckLogMapper checkLogMapper;

    @Autowired
    private MobileApiValidate mobileApiValidate;

    /**
    * 获取数据层mapper接口对象，子类必须实现该方法
    *
    * @return GenericMapper<E, PK> 数据层mapper接口对象
    */
    @Override
    protected GenericMapper<CheckLog, Long> getMapper() {
        return checkLogMapper;
    }

    /**
    * 根据id获取对象，如果为空，返回空对象
    * @param id Long 公司id
    * @return CheckLog 校验信息记录对象
    */
    public CheckLog getSafety(Long id) {
        CheckLog checkLog = get(id);
        if (checkLog == null) {
            checkLog = new CheckLog();
        }
        return checkLog;
    }

    /**
     *  空号验证
     * @param params 请求参数
     * @param businessInfo 商家信息
     * @param requestData 商家请求内容
     * @return 返回给客户端的加密结果
     * @throws Exception Exception
     */
    public String checker(Map<String,Object> params,
                          BusinessInfo businessInfo,
                          String requestData,
                          Map<String, String> validateParams) throws Exception {
        String responseStr = sendPost(params);
        JSONObject jsonObject = JSONObject.parseObject(responseStr);
        String oid = save(businessInfo.getUid(),"123",requestData,jsonObject.toString(),1);
        String resultMsg = jsonObject.getString("resultMsg");
        if ( !"成功".equals(resultMsg)) {
            throw new ApiException(
                    ApiErrorEnum.ACTION_ERROR);
        }
        String notValidMobiles = validateParams.get("notValidMobile");
        if (StringUtils.isNotBlank(notValidMobiles)) {
            responseStr = modifyResult(responseStr, notValidMobiles);
        }

        Map<String,String> resultMap = new HashMap<>();
        resultMap.put("oid",oid);
        resultMap.put("resultObj",responseStr);
        return encryptStringByPrivateKey(GsonUtils.toJson(resultMap,false).getBytes("UTF-8"),
                businessInfo.getPrivateKey());
    }

    /**
     * 发送POST 请求
     * @param params 请求参数
     * @return 返回结果
     * @throws HttpClientException http异常
     * @throws UnsupportedEncodingException 编码异常
     */
    public String sendPost(Map<String,Object> params) throws HttpClientException, UnsupportedEncodingException {
        StringBuilder stringBuilder = new StringBuilder();
        for (String key : params.keySet()) {
            stringBuilder.append(key)
                    .append("=").append(URLEncoder.encode((String) params.get(key), "UTF-8"))
                    .append("&");
        }
        return HttpClientUtils.postForm(Constant.CHECK_URL,
                stringBuilder.substring(0,stringBuilder.length()-1));
    }

    public String save(String uid,String channelCode,String requestData,String response,Integer status) throws ServiceProcessException {
        String oid = UuidGenerator.nextOid();
        CheckLog checkLog = new CheckLog();
        checkLog.setOid(oid);
        checkLog.setChannelCode(channelCode);
        checkLog.setBusinessUid(uid);
        checkLog.setBusinessRequest(requestData.trim());
        checkLog.setThirdResponse(response);
        checkLog.setCreateTime(DateUtil.getTimestamp());
        checkLog.setStatus(status);
        insert(checkLog);
        return oid;
    }

    /**
     * 添加不合法的手机号码bean 到返回结果中
     */
    public String modifyResult(String resultObj,String notValidMobiles){
        List<CheckMobileVO> checkMobileVOList = new ArrayList<>();
        for (String notValidMobile:notValidMobiles.split(",")
                ) {
            CheckMobileVO checkMobileVO = new CheckMobileVO();
            checkMobileVO.setMobile(notValidMobile);
            checkMobileVO.setMsg(ApiErrorEnum.MOBILE_VALIDATE_ERROR.getDescription());
            checkMobileVOList.add(checkMobileVO);
        }
        JSONObject jsonResultObj = JSONObject.parseObject(resultObj);
        String resultObjStr = jsonResultObj.getString("resultObj");
        JSONArray jsonArray = JSONArray.parseArray(resultObjStr);
        jsonArray.addAll(checkMobileVOList);
        jsonResultObj.put("resultObj",jsonArray);
        return jsonResultObj.toString();
    }

    /**
     * 检测单个号码
     */
    public String single_checker(Map<String, Object> params,String jsonData,BusinessInfo businessInfo) throws Exception {
        String jsonString = JSON.toJSONString(params);
        String resultXML = HttpClientUtils.postJson(Constant.SINGLE_URL, jsonString);
        Map<String, String> map = XMLUtils.xmlToMap(resultXML);
        String responseStr = JSONObject.toJSONString(map);
        String oid = save(businessInfo.getUid(), "123",jsonData,responseStr ,1);
        Map<String,String> resultMap = new HashMap<>();
        resultMap.put("oid",oid);
        resultMap.put("resultObj",responseStr);
        return encryptStringByPrivateKey(JSONObject.toJSONString(resultMap).getBytes("UTF-8"),
                businessInfo.getPrivateKey());
    }

}