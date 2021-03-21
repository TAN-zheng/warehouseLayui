package com.cacsi.warehouse.dao;

import com.cacsi.warehouse.bean.Goods;
import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.GoodsQuery;
import com.cacsi.warehouse.common.ProviderQuery;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface GoodsDao {
//    获取商品数据
    public List<Goods> getGoodsList(GoodsQuery goodsQuery);
//    获取数据总条数
    public Long getCount(GoodsQuery GoodsQuery);
//    查询一个供货商的名称
    public List<Provider> getProviderName();
}
