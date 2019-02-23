package com.hdc.utils;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class IntegerTools {
    public IntegerTools() {
    }

    public static boolean lessEqualZero(Integer i) {
        return i == null || i.intValue() <= 0;
    }

    public static boolean lessZero(Integer i) {
        return i == null || i.intValue() < 0;
    }

    public static Integer parse(String param) {
        return parse(param, (Integer)null);
    }

    public static Integer parse(String param, Integer defaultValue) {
        return param != null && StringUtils.isNumeric(param.trim()) ? Integer.parseInt(param.trim()) : defaultValue;
    }

    public static List<Integer> parseList(String param) {
        List<Integer> idList = new ArrayList();
        if (param != null) {
            String[] idArray = param.split(",");
            String[] var3 = idArray;
            int var4 = idArray.length;

            for(int var5 = 0; var5 < var4; ++var5) {
                String idStr = var3[var5];
                if (StringUtils.isNumeric(idStr.trim())) {
                    idList.add(Integer.parseInt(idStr.trim()));
                }
            }
        }

        return idList;
    }

    public static List<Integer> parseList(String[] param) {
        List<Integer> idList = new ArrayList();
        if (param != null && param.length > 0) {
            String[] var2 = param;
            int var3 = param.length;

            for(int var4 = 0; var4 < var3; ++var4) {
                String idStr = var2[var4];
                if (StringUtils.isNumeric(idStr.trim())) {
                    idList.add(Integer.parseInt(idStr.trim()));
                }
            }
        }

        return idList;
    }
}
