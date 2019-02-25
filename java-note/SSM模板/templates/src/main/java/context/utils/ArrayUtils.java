package com.msymobile.mobile.context.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by developer2 on 2018/8/17.
 */
public class ArrayUtils {
    /**
     * 把list分成容量为n的多个数组
     * @param source 需要被分解的数组
     * @param n 数组容量
     */
    public static <T> List<List<T>> averageAssign(List<T> source, int n){
        List<List<T>> arrayList = new ArrayList<>();
        int remain=source.size() % n; //(先计算出余数)
        int number=source.size()/ n; //然后是商
        for (int i = 0;i< number;i++){
            List<T> newList = source.subList(i*n,(i+1)*n);
            arrayList.add(newList);
        }
        if (remain != 0){
            arrayList.add(source.subList(number*n,number*n+remain));
        }
        return arrayList;
    }
}
