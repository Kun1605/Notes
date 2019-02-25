package com.test.utils;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class DateUtil {
    public DateUtil() {
    }

    public static String format(Long timestamp) {
        return timestamp == null ? "" : DateFormatUtils.format(timestamp.longValue() * 1000L, "yyyy-MM-dd");
    }

    public static String format(Date date) {
        return format(date, "yyyy-MM-dd");
    }

    public static String format(Date date, String pattern) {
        return DateFormatUtils.format(date, pattern);
    }

    public static String patternFormat(Date date) {
        return format(date, "yyyyMMdd");
    }

    public static String fullFormat(Long timestamp) {
        return LongTools.lessEqualZero(timestamp) ? "" : DateFormatUtils.format(timestamp.longValue() * 1000L, "yyyy-MM-dd HH:mm:ss");
    }

    public static Long getTimestamp() {
        return System.currentTimeMillis() / 1000L;
    }

    public static Date parseDate(String dateStr) throws ParseException {
        return parseDate(dateStr, "yyyy-MM-dd");
    }

    public static Date parseMonthDate(String dateStr) throws ParseException {
        return parseMonthDate(dateStr, "yyyy-MM");
    }

    public static Date parseMonthAddDate(Date dateStr) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateStr);
        cal.add(2, 1);
        return cal.getTime();
    }

    public static Date parseMonthDate(String dateStr, String... parsePatterns) throws ParseException {
        return DateUtils.parseDate(dateStr, parsePatterns);
    }

    public static Date parseDate(String dateStr, String... parsePatterns) throws ParseException {
        return DateUtils.parseDate(dateStr, parsePatterns);
    }

    public static int compare(Date date1, Date date2, int field) {
        return DateUtils.truncatedCompareTo(date1, date2, field);
    }

    public static int compare(Date date1, Date date2) {
        return compare(date1, date2, 5);
    }

    public static long compareTime(Date date1, Date date2) {
        return date1.getTime() - date2.getTime();
    }

    public static Date addDays(Date date, int amount) {
        return DateUtils.addDays(date, amount);
    }

    public static Date addMonths(Date date, int amount) {
        return DateUtils.addMonths(date, amount);
    }

    public static Date getYesterday() {
        return addDays(new Date(), -1);
    }

    public static String getYesterdayStr() {
        return format(getYesterday());
    }

    public static String getYesterdayStr(String pattern) {
        return format(getYesterday(), pattern);
    }

    public static String getWeekDate() {
        return format(addDays(new Date(), -7));
    }

    public static String getMonthDate() {
        return format(addDays(new Date(), -30));
    }

    public static Date getEndDate(Date beginDate, Integer requestRange, Date maxEndDate) {
        Date endDate = addDays(beginDate, requestRange.intValue() - 1);
        if (compare(endDate, maxEndDate) > 0) {
            endDate = maxEndDate;
        }

        return endDate;
    }
}
