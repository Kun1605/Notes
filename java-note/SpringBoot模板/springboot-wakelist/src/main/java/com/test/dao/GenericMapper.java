package com.test.dao;

import org.apache.ibatis.session.RowBounds;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Create By HuangDongChang On 2018/8/28
 */
public interface GenericMapper<E, PK extends Serializable> {

    E get(PK var1);

    E getByDynamicWhere(Map<String, Object> var1);

    int getCount();

    int getCount(Map<String, Object> var1);

    List<E> getList();

    List<E> getList(Map<String, Object> var1);

    List<E> getList(RowBounds var1);

    List<E> getList(RowBounds var1, Map<String, Object> var2);

    int insert(E var1);

    int update(E var1);

    int delete(PK var1);

    int batchDelete(List<PK> var1);
}
