package com.hdc.utils;

import java.math.BigDecimal;
import org.apache.commons.lang3.math.NumberUtils;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class DoubleTools {
    public DoubleTools() {
    }

    public static Double parseDouble(String param) {
        return param != null && NumberUtils.isNumber(param.trim()) ? Double.parseDouble(param.trim()) : null;
    }

    public static BigDecimal parseBigDecimal(String param) {
        return parseBigDecimal(param, (BigDecimal)null);
    }

    public static BigDecimal parseBigDecimal(String param, BigDecimal defaultValue) {
        return param != null && NumberUtils.isNumber(param.trim()) ? new BigDecimal(Double.parseDouble(param.trim())) : defaultValue;
    }

    public static boolean lessEqualZero(Double d) {
        return d == null || d.doubleValue() <= 0.0D;
    }

    public static boolean lessZero(Double d) {
        return d == null || d.doubleValue() < 0.0D;
    }
}
