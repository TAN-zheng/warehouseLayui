package com.cacsi.warehouse.service;

import com.cacsi.warehouse.bean.Goods;
import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.GoodsQuery;
import com.cacsi.warehouse.common.ProviderQuery;
import com.cacsi.warehouse.dao.GoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Service
public class GoodsService {
    @Autowired
    GoodsDao goodsDao;
//查询的所有的商品信息
    public List<Goods> getGoodsList(GoodsQuery goodsQuery) {
       List<Goods> goodsList = goodsDao.getGoodsList(goodsQuery);
        return goodsList;
    }
//    查询商品信息的总数，用于分页
    public Long getCount(GoodsQuery goodsQuery){
        return goodsDao.getCount(goodsQuery);
    }
//    查询供货商名称、
    public List<Provider> getProviderName(){
//        返回查询的值给上service层调用此方法的对象。
        return goodsDao.getProviderName();
    };
}
