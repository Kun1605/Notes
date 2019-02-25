package com.test.controller;

import com.test.service.WakeListService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.concurrent.TimeUnit;

/**
 * Create By HuangDongChang On 2018/8/27
 */
@Controller
public class WakeListController {

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private WakeListService wakeListService;

    @RequestMapping("/wakelist")
    @ResponseBody
    public String wakelist(@RequestParam(required = false) String channel,
                         @RequestParam(required = false,defaultValue = "notify") String action){

        if (StringUtils.isNotBlank(channel)){
            String resultKey = String.format("wakepool_%s_list_%s",action,channel);
            String result = redisTemplate.opsForValue().get(resultKey,0,-1);
            if (StringUtils.isBlank(result)){
                result = wakeListService.getChannelWakelist(channel, action);
                redisTemplate.opsForValue().set(resultKey,result,86400, TimeUnit.SECONDS);
            }
            return result;
        }
        return null;
    }


}
