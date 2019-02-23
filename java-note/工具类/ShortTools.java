package com.hdc.utils;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class ShortTools {
    public ShortTools() {
    }

    public static boolean lessEqualZero(Short i) {
        return i == null || i.shortValue() <= 0;
    }

    public static boolean lessZero(Short i) {
        return i == null || i.shortValue() < 0;
    }

    public static Short parseShort(String param) {
        return param != null && StringUtils.isNumeric(param.trim()) ? Short.parseShort(param.trim()) : null;
    }

    public static List<Short> parseShortList(String param) {
        List<Short> idList = new ArrayList();
        if (param != null) {
            String[] idArray = param.split(",");
            String[] var3 = idArray;
            int var4 = idArray.length;

            for(int var5 = 0; var5 < var4; ++var5) {
                String idStr = var3[var5];
                if (StringUtils.isNumeric(idStr.trim())) {
                    idList.add(Short.parseShort(idStr.trim()));
                }
            }
        }

        return idList;
    }

    public static List<Short> parseShortList(String[] param) {
        List<Short> idList = new ArrayList();
        if (param != null && param.length > 0) {
            String[] var2 = param;
            int var3 = param.length;

            for(int var4 = 0; var4 < var3; ++var4) {
                String idStr = var2[var4];
                if (StringUtils.isNumeric(idStr.trim())) {
                    idList.add(Short.parseShort(idStr.trim()));
                }
            }
        }

        return idList;
    }
}
