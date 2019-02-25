package com.test.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.test.dao.ModProductMapper;
import com.test.dao.ModTimeMapper;
import com.test.dao.ModTitleMapper;
import com.test.model.ModProduct;
import com.test.model.ModTime;
import com.test.model.ModTitle;
import com.test.utils.DateUtil;
import com.test.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.*;

/**
 * Create By HuangDongChang On 2018/8/27
 */
@Service
public class WakeListService {

    @Autowired
    ModProductMapper modProductMapper;

    @Autowired
    ModTimeMapper modTimeMapper;

    @Autowired
    ModTitleMapper modTitleMapper;

    public List<ModProduct> getPidInfo(String channel, String action) {
        Byte type = 0;
        if ("adview".equals(action)){
            type = 1;
        }
        String now = DateUtil.format(new Date(), "yyyy-MM-dd HH:mm:ss");
        Map<String,Object> params = new HashMap<>();
        params.put("channel",channel);
        params.put("status",1);
        params.put("type",type);
        params.put("startTime",now);
        params.put("endTime",now);
        params.put("orderField","priority");
        params.put("orderSeq","DESC");
        return modProductMapper.getList(params);
    }

    public String getRunTimes(){
        List<ModTime> modTimes = modTimeMapper.getList();
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("[");
        for (ModTime modTime:modTimes
             ) {
            String formatTime = String.format("[%s:%s,%s:%s]",
                    modTime.getShour(),modTime.getSminute(),modTime.getEhour(),modTime.getEminute());
            stringBuilder.append(formatTime).append(",");
        }
        return stringBuilder.substring(0, stringBuilder.length() - 1) + "]";
    }

    public ModTitle getPromote(Integer pid){
        Map<String,Object> params = new HashMap<>();
        params.put("pid",pid);
        List<ModTitle> modTitles = modTitleMapper.getList(params);
        Random random = new Random();
        int i = random.nextInt(modTitles.size());
        return modTitles.get(i);
    }

    public ModTitle getMsg(Integer id){
        return getPromote(id);
    }

    public String getChannelWakelist(String channel, String action){

        List<ModProduct> modProducts = getPidInfo(channel, action);
        String modProductStr = JSONObject.toJSONString(modProducts);
        List<ProductVO> productVOS = JSONArray.parseArray(modProductStr, ProductVO.class);

        for (ProductVO productVO:productVOS
             ) {
            ModTitle modTitle = getMsg(productVO.getId());
            productVO.setImgurl(modTitle.getImgurl());
            productVO.setMsg(modTitle.getMsg());
        }

        String productVOStr = JSONObject.toJSONString(productVOS);
        String runTimes = getRunTimes();
        return String.format("{time:%s,expired:%s,data:%s}",runTimes,String.valueOf(getExpired()),productVOStr);
    }

    public Long getExpired(){
        String formatOne = DateUtil.format(new Date(), "yyyy-MM-dd");
        Long now = DateUtil.getTimestamp();
        Long expire = 0L;
        try {
            String format = DateUtil.format(DateUtil.parseDate(formatOne),"yyyy-MM-dd HH:mm:ss");
            Date date = DateUtil.parseDate(format, "yyyy-MM-dd HH:mm:ss");
            Date tomorrow = DateUtil.addDays(date, 1);
            expire = tomorrow.getTime()/1000L - now;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return expire;
    }

}
