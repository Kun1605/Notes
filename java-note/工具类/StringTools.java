package com.hdc.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class StringTools {
    public StringTools() {
    }

    public static boolean isEmpty(String str) {
        return str == null || str.isEmpty();
    }

    public static String parseString(String param) {
        return param == null ? null : param.trim();
    }

    public static String parseEmptyString(String param) {
        return param == null ? "" : param.trim();
    }

    public static String removeQuote(String str) {
        return str == null ? null : str.replaceAll("\"", "").replaceAll("'", "");
    }

    public static List<String> parseList(String params) {
        return parseList(params, ",", false);
    }

    public static List<String> parseList(String params, String regex, boolean supportedOperation) {
        List<String> list = Arrays.asList(params.split(regex));
        return (List)(supportedOperation ? new ArrayList(list) : list);
    }
}
