package com.test.controller;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

/**
 * SpringBoot 的启动入口
 * Create By HuangDongChang On 2018/8/29
 */
@SpringBootApplication(scanBasePackages = "com.test")
@MapperScan("com.test.dao")
public class SpringBootMain extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(
            SpringApplicationBuilder application) {
        return application.sources(SpringBootMain.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(SpringBootMain.class,args);
    }

}