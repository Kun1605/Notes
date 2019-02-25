package com.test.utils;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class LongTools {
    public LongTools() {
    }

    public static Long parse(String param) {
        return parse(param, (Long)null);
    }

    public static Long parse(String param, Long defaultValue) {
        return param != null && StringUtils.isNumeric(param.trim()) ? Long.parseLong(param.trim()) : defaultValue;
    }

    public static boolean lessEqualZero(Long l) {
        return l == null || l.longValue() <= 0L;
    }

    public static boolean greaterThanZero(Long l) {
        return !lessEqualZero(l);
    }

    public static boolean lessZero(Long l) {
        return l == null || l.longValue() < 0L;
    }

    public static List<Long> parseList(String param) {
        return parseList(param, ",");
    }

    public static List<Long> parseList(String param, String flag) {
        List<Long> idList = new ArrayList();
        if (param != null) {
            String[] idArray = param.split(flag);
            String[] var4 = idArray;
            int var5 = idArray.length;

            for(int var6 = 0; var6 < var5; ++var6) {
                String idStr = var4[var6];
                if (StringUtils.isNumeric(idStr.trim())) {
                    idList.add(Long.parseLong(idStr.trim()));
                }
            }
        }

        return idList;
    }
}
