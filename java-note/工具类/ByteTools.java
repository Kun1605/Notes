package com.hdc.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class ByteTools {
    public ByteTools() {
    }

    public static boolean lessEqualZero(Byte b) {
        return b == null || b.byteValue() <= 0;
    }

    public static boolean lessZero(Byte b) {
        return b == null || b.byteValue() < 0;
    }

    public static Byte parseByte(String param) {
        return param != null && StringUtils.isNumeric(param.trim()) ? Byte.parseByte(param.trim()) : null;
    }
}
