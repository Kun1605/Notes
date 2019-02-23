package com.test.controller;

import com.test.service.WakeListService;
import org.apache.commons.lang3.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.concurrent.TimeUnit;

/**
 * Create By HuangDongChang On 2018/8/28
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring-server.xml"})
public class WakeListControllerTest {

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private WakeListService wakeListService;

    @Test
    public void wakelist() throws Exception {
        String channel = "test";
        String action = "adview";
        if (StringUtils.isNotBlank(channel)){
            String resultKey = String.format("wakepool_%s_list_%s",action,channel);
            String result = redisTemplate.opsForValue().get(resultKey,0,-1);
            if (StringUtils.isBlank(result)){
                result = wakeListService.getChannelWakelist(channel, action);
                redisTemplate.opsForValue().set(resultKey,result,86400, TimeUnit.SECONDS);
            }
            System.out.println("result= " + result);
        }
    }

}