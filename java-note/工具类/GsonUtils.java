package com.hdc.utils;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class GsonUtils {
    public GsonUtils() {
    }

    public static <T> String toJson(T obj) {
        return toJson(obj, (ExclusionStrategy)null, (FieldNamingPolicy)null);
    }

    public static <T> String toJson(T obj, boolean pretty) {
        return toJson(obj, (ExclusionStrategy)null, (FieldNamingPolicy)null, pretty);
    }

    public static <T> String toJson(T obj, ExclusionStrategy strategy) {
        return toJson(obj, strategy, (FieldNamingPolicy)null);
    }

    public static <T> String toJson(T obj, ExclusionStrategy strategy, boolean pretty) {
        return toJson(obj, strategy, (FieldNamingPolicy)null, pretty);
    }

    public static <T> String toJson(T obj, FieldNamingPolicy policy) {
        return toJson(obj, (ExclusionStrategy)null, policy);
    }

    public static <T> String toJson(T obj, FieldNamingPolicy policy, boolean pretty) {
        return toJson(obj, (ExclusionStrategy)null, policy, pretty);
    }

    public static <T> String toJson(T obj, ExclusionStrategy strategy, FieldNamingPolicy policy) {
        return toJson(obj, strategy, policy, true);
    }

    public static <T> String toJson(T obj, ExclusionStrategy strategy, FieldNamingPolicy policy, boolean pretty) {
        GsonBuilder gsonBuilder = new GsonBuilder();
        if (strategy != null) {
            gsonBuilder.setExclusionStrategies(new ExclusionStrategy[]{strategy});
        }

        if (policy != null) {
            gsonBuilder.setFieldNamingPolicy(policy);
        }

        if (pretty) {
            gsonBuilder.setPrettyPrinting();
        }

        Type type = (new TypeToken<T>() {
        }).getType();
        return gsonBuilder.create().toJson(obj, type);
    }

    public static String toJson(Object obj, Type type) {
        return toJson(obj, type, true);
    }

    public static String toJson(Object obj, Type type, boolean pretty) {
        GsonBuilder gsonBuilder = new GsonBuilder();
        if (pretty) {
            gsonBuilder.setPrettyPrinting();
        }

        return gsonBuilder.create().toJson(obj, type);
    }

    public static <T> T fromJson(String jsonStr, Class<T> classOfT) {
        return fromJson(jsonStr, (Class)classOfT, (FieldNamingPolicy)null);
    }

    public static <T> T fromJson(String jsonStr, Class<T> classOfT, FieldNamingPolicy policy) {
        GsonBuilder gsonBuilder = new GsonBuilder();
        if (policy != null) {
            gsonBuilder.setFieldNamingPolicy(policy);
        }

        return gsonBuilder.create().fromJson(jsonStr, classOfT);
    }

    public static <T> T fromJson(String jsonStr, Type type, FieldNamingPolicy policy) {
        Gson gson = (new GsonBuilder()).setFieldNamingPolicy(policy).create();
        return gson.fromJson(jsonStr, type);
    }

    public static <T> T fromJson(String jsonStr, Type type) {
        Gson gson = (new GsonBuilder()).create();
        return gson.fromJson(jsonStr, type);
    }

    public static <T> T fromJsonNoException(String jsonStr, Type type) {
        try {
            return fromJson(jsonStr, type);
        } catch (Exception var3) {
            var3.printStackTrace();
            return null;
        }
    }

    public static Map<String, Object> toStrObjMap(String json) {
        Type type = (new TypeToken<Map<String, Object>>() {
        }).getType();
        return (Map)fromJson(json, type);
    }

    public static Map<String, String> toStrStrMap(String json) {
        Type type = (new TypeToken<Map<String, String>>() {
        }).getType();
        return (Map)fromJson(json, type);
    }

    public static Map<String, Long> toStrLongMap(String json) {
        Type type = (new TypeToken<Map<String, Long>>() {
        }).getType();
        return (Map)fromJson(json, type);
    }

    public static Map<String, Integer> toStrIntegerMap(String json) {
        Type type = (new TypeToken<Map<String, Integer>>() {
        }).getType();
        return (Map)fromJson(json, type);
    }

    public static Map<String, List<Long>> toStrLongListMap(String json) {
        Type type = (new TypeToken<Map<String, List<Long>>>() {
        }).getType();
        return (Map)fromJson(json, type);
    }

    public static List<Long> toLongList(String json) {
        Type type = (new TypeToken<List<Long>>() {
        }).getType();
        return (List)fromJson(json, type);
    }
}
