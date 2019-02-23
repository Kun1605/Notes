package com.msymobile.mobile.context.utils;

import java.util.Calendar;

/**
 * Create By HuangDongChang On 2018/8/16
 */
public class DateExtUtils {

    /**
     * 获取昨天00:00:00:000点的时间戳
     */
    public static Long getStartTime() {
        Calendar todayStart = Calendar.getInstance();
        todayStart.add(Calendar.DATE,-1);
        todayStart.set(Calendar.HOUR_OF_DAY, 0);
        todayStart.set(Calendar.MINUTE, 0);
        todayStart.set(Calendar.SECOND, 0);
        todayStart.set(Calendar.MILLISECOND, 0);
        return todayStart.getTimeInMillis()/1000;
    }

    /**
     * 获取昨天23:59:59:999点的时间戳
     */
    public static Long getEndTime() {
        Calendar todayEnd = Calendar.getInstance();
        todayEnd.add(Calendar.DATE,-1);
        todayEnd.set(Calendar.HOUR_OF_DAY, 23);
        todayEnd.set(Calendar.MINUTE, 59);
        todayEnd.set(Calendar.SECOND, 59);
        todayEnd.set(Calendar.MILLISECOND, 999);
        return todayEnd.getTimeInMillis()/1000;
    }

    public static void main(String[] args) {
        System.out.println(getStartTime());
        System.out.println(getEndTime());
    }
}
