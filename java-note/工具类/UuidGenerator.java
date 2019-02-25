package com.hdc.utils;

import org.bson.types.ObjectId;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class UuidGenerator {
    private static final int machineIdentifier = ObjectId.getGeneratedMachineIdentifier();
    private static int userInc = 0;
    private static int orderInc = 0;
    private static int goodsInc = 0;

    public UuidGenerator() {
    }

    public static String nextUid() {
        return ObjectId.createFromLegacyFormat(DateUtil.getTimestamp().intValue(), machineIdentifier, ++userInc).toString();
    }

    public static String nextOid() {
        return ObjectId.createFromLegacyFormat(DateUtil.getTimestamp().intValue(), machineIdentifier, ++orderInc).toString();
    }

    public static String nextGid() {
        return ObjectId.createFromLegacyFormat(DateUtil.getTimestamp().intValue(), machineIdentifier, ++goodsInc).toString();
    }
}
