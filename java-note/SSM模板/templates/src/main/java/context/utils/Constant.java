package com.msymobile.mobile.context.utils;

import java.io.IOException;
import java.util.Properties;

/**
 * Create By HuangDongChang On 2018/7/23
 */
public class Constant {

    public static String API_NAME = null;
    public static String PASSWORD = null;
    public static String CHECK_URL = null;
    public static String ACCOUNT = null;
    public static String ENCRYPT_PASSWORD = null;
    public static String SINGLE_URL = null;
    public static String BATCH_URL = null;
    public static String DOMAIN_URL = null;
    public static String SPIDER_NOTIFY_URL = null;

    /** 注册短信地址，账号，密码*/
    public static String WECHAT_VALIDATE_URL = null;
    /**批量校验接口 */
    public static String WECHAT_VALIDATE_BATCH_URL = null;
    public static String WECHAT_REGISTER_URL = null;
    public static String WECHAT_REGISTER_USERNAME = null;
    public static String WECHAT_REGISTER_PASSWORD = null;

    /**辽宁运营商*/
    public static String LIAONING_SFTP_USERNAME = null;
    public static String LIAONING_SFTP_PASSWORD = null;
    public static String LIAONING_SFTP_HOST = null;
    public static String LIAONING_SFTP_PORT = null;

    static {
        Properties properties = new Properties();
        try {
            properties.load(
                    Constant.class.getClassLoader().getResourceAsStream(
                            "conf/config-properties/checkMobile.properties"));
            API_NAME = properties.getProperty("apiName");
            PASSWORD = properties.getProperty("password");
            CHECK_URL = properties.getProperty("check_url");
            ACCOUNT = properties.getProperty("account");
            ENCRYPT_PASSWORD = properties.getProperty("encrypt_password");
            SINGLE_URL = properties.getProperty("single_url");
            BATCH_URL = properties.getProperty("batch_url");
            DOMAIN_URL = properties.getProperty("domain_url");
            SPIDER_NOTIFY_URL = properties.getProperty("spider_notify_url");

            WECHAT_VALIDATE_URL = properties.getProperty("wechat_validate_url");
            WECHAT_VALIDATE_BATCH_URL = properties.getProperty("wechat_validate_batch_url");
            WECHAT_REGISTER_URL = properties.getProperty("wechat_register_url");
            WECHAT_REGISTER_USERNAME = properties.getProperty("wechat_register_username");
            WECHAT_REGISTER_PASSWORD = properties.getProperty("wechat_register_password");


            LIAONING_SFTP_USERNAME = properties.getProperty("liaoning_sftp_username");
            LIAONING_SFTP_PASSWORD = properties.getProperty("liaoning_sftp_password");
            LIAONING_SFTP_HOST = properties.getProperty("liaoning_sftp_host");
            LIAONING_SFTP_PORT = properties.getProperty("liaoning_sftp_port");



        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
