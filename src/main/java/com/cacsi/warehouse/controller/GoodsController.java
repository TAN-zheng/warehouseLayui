package com.cacsi.warehouse.controller;

import com.cacsi.warehouse.bean.Goods;
import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.GoodsQuery;
import com.cacsi.warehouse.common.Result;
import com.cacsi.warehouse.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    GoodsService goodsService;

    //    访问list页面。
    @RequestMapping("toGoodsPage")
    public String toGoodsList() {

        return "/views/goods/goodsList";
    }

    /*
     * 查询所有的商品数据
     * */
    @RequestMapping("getGoodsList")
//    回传给响应体
    @ResponseBody
    public Result getGoodsList(@RequestBody GoodsQuery goodsQuery) {
        goodsQuery.setPage(goodsQuery.getPage()-1);
        /*
         * 1、这是根据表头面板指定的数据 查询的
         * 2、sql语句进行了动态查询，不传入指定的条件就会查询所有的数据。
         * */
        List<Goods> goodsList = goodsService.getGoodsList(goodsQuery);
        /*
         * 创建一个方法查询数据总数。用于分页
         * */
        Long count = goodsService.getCount(goodsQuery);
        /*
         * 一、创建一个通用类
         * 1、把查询出来的对象封装到前端json可以接收的格式中去：{"code":0,"msg":"","count":1000,
         * "data":[{"xxx":"xx","xxx":"xx",...},{"xxx":"xx","xxx":"xx",...},{"xxx":"xx","xxx":"xx",...}]}
         * 2、因此创建一个符合前端页面的接受格式的类，返回给前端json解析。
         * 3、
         * */
        Result result = new Result();
        result.setCode(0);
        result.setCount(count);//获取的上平总数
        result.setData(goodsList);//把查询的单个的商品数据放进了json的data对象里面了。前端通过【data.属性名】获取
        return result;
    }
/*
* 跳转到新增弹出层的子页面
* */
    @RequestMapping("toGoodsLayer")
    public String toGoodsLayer(){
        return "views/goods/goodsLayer";
    }
    /*
    * 查询供货商名称
    * */
    @RequestMapping("getProviderName")
    public Result getProviderName(){
        List<Provider> providerList = goodsService.getProviderName();

        Result result = new Result();
        result.setData(providerList);
        return result;
    }
}
