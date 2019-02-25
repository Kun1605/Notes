package com.test.controller;

import com.test.service.WakeListService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import sun.misc.BASE64Encoder;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.concurrent.TimeUnit;

/**
 * Create By HuangDongChang On 2018/8/27
 */
@RestController
public class WakeListController {

//    @Autowired
//    private RedisTemplate redisTemplate;

    @Autowired
    private StringRedisTemplate redisTemplate;  //StringRedisTemplate 默认使用 StringRedisSerializer进行序列化

    @Autowired
    private WakeListService wakeListService;

    /**
     * spring-data-redis的RedisTemplate<K, V>模板类在操作redis时默认使用JdkSerializationRedisSerializer来进行序列化
     * 会使key添加序列化前缀，造成key不一致 ["\xac\xed\x00\x05t\x00\x04name"]
     *
     */
    /*@Autowired(required = false)
    public void setRedisTemplate(RedisTemplate redisTemplate) {
        RedisSerializer stringSerializer = new StringRedisSerializer();
        redisTemplate.setKeySerializer(stringSerializer);
        redisTemplate.setValueSerializer(stringSerializer);
        redisTemplate.setHashKeySerializer(stringSerializer);
        redisTemplate.setHashValueSerializer(stringSerializer);
        this.redisTemplate = redisTemplate;
    }*/

    @GetMapping("/wakelist")
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
