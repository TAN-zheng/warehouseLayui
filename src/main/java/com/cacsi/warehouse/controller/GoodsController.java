package com.cacsi.warehouse.controller;

import com.cacsi.warehouse.bean.Customer;
import com.cacsi.warehouse.bean.Goods;
import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.GoodsQuery;
import com.cacsi.warehouse.common.Result;
import com.cacsi.warehouse.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
        result.setCode(0);

        result.setData(providerList);
        return result;
    }
//    新增商品信息
    @RequestMapping("addOrUpdateGoods")
    @ResponseBody
    public Result addOrUpdateGoods(@RequestBody Goods goods){
        System.out.println(goods);
        boolean flag=false;
        if (goods.getId()==null){
            flag= goodsService.addGoods(goods);
        }else {
            flag= goodsService.updateGoods(goods);
        }
        Result result = new Result();
        if (flag==true){

            result.setMsg("操作成功");
        }else {
            result.setMsg("操作失败");
        }
        return result;
    }
    /*
     * 访问子页面的方法,修改数据。
     * */
    @RequestMapping("changeGoodsLayer")
    public String changeGoodsLayer(@RequestParam(required = false,value = "id") String id, Model model){
        //         到数据库查询从前端，按钮事件点击传入的id，到数据路查询信息。
        Goods goods = goodsService.getGoods(id);
        System.out.println(goods);
        /*
         *1、把根据id查询的值，通过model对象，设置进去保存。然后在前端取出对象进行更改。
         * 2、在前台用EL表达式拿数据就行。例如：格式：${(provider.id)}
         * */
        model.addAttribute("goods",goods);
        return "/views/goods/goodsLayer";
    }
/*
* 删除操作
* */
    @RequestMapping("deleteGoodsByIds")
    @ResponseBody
    public Result deleteGoodsByIds(@RequestParam List<Long> ids){
        boolean flag=goodsService.deleteGoodsByIds(ids);
        Result result = new Result();
        result.setMsg("成功删除！"+ids.size()+"条数据！");
        System.out.println(ids+" goods controller");
        return result;
    }
}
