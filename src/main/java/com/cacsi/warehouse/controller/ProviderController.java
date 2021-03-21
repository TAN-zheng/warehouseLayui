package com.cacsi.warehouse.controller;

import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.ProviderQuery;
import com.cacsi.warehouse.common.Result;
import com.cacsi.warehouse.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/provider")
public class ProviderController {
//    注入service层
    @Autowired
    ProviderService providerService;
//    index主页的导航页面选中后，子页面的显示路径。
    /*
    * 一、@RequestParam(required = false,value = "id") String id:这句话的意思是：这个参数可以传进来，也可以不传进来。
    * 二、Model model：这个是用来做回响的。用里面的Attribute函数。
    * */
    @RequestMapping("toProviderList")
    public String toSupplierList(){

        return "/views/provider/providerList";
    }
/*
* 子页面的表单查询
* */
    @RequestMapping("getPageList")
    @ResponseBody
//    @RequestBody ProviderQuery providerQuery请求时接受一个对象的参数的请求。
    public Result getPageList(@RequestBody ProviderQuery providerQuery){
//        解决查询第一个index是0的问题。
        providerQuery.setPage(providerQuery.getPage()-1);
//        查询的实体对象集合。存放在providerList里面。
        List<Provider> providerList = providerService.getPageList(providerQuery);
//        获取统计的条数
        Long count = providerService.getCount(providerQuery);
/*
*       这个类对象是为了返回一个json格式的字符串，给前端接受创建的符合前端的接受格式对象。
*       只有当格式一致的时候才能被前端解析出来。
*
* */
        Result result = new Result();
//        这个是为了符合前端Json格式要求设置的值，属性。
        result.setCode(0);
//        统计的数据条数。
        result.setCount(count);
//        这是json专为对象类型设置的一个对象属性。在前端就可以通过，【对象.属性名】直接拿到相应的json对象数据。
        result.setData(providerList);
        return result;
    }
/*
* 访问子页面的方法
* */
    @RequestMapping("providerLayer")
    public String toProviderLayer(@RequestParam(required = false,value = "id") String id, Model model){
        //         到数据库查询从前端，按钮事件点击传入的id，到数据路查询信息。
        Provider provider = providerService.getProvider(id);
        /*
         *1、把根据id查询的值，通过model对象，设置进去保存。然后在前端取出对象进行更改。
         * 2、在前台用EL表达式拿数据就行。例如：格式：${(provider.id)}
         * */
        model.addAttribute("provider",provider);
        return "/views/provider/providerLayer";
    }
/*
* 提交弹出iframe层的数据，即新增数据
* */
    @RequestMapping("addOrUpdateProvider")
    @ResponseBody
    public Result addOrUpdateProvider(@RequestBody Provider provider){
//        前端的标签里面的name属性要与实体类的属性字段对应，否则值传递不过来。
        System.out.println(provider);
        /*
        * 判断是否id为空，如果为空说明是新增，如果不为空说明，前端向controller层提供了id，
        * 目的是为了修改数据，就进入修改的后台。
        * */
        boolean flag=false;
        if (provider.getId()==null){
             flag= providerService.addProvider(provider);
        }else {
             flag=providerService.updateProvider(provider);
        }
        Result result = new Result();
        if (flag==true){
            result.setMsg("操作成功了，来自controller层的提示！");
        }else {
            result.setMsg("操作失败！");
        }
        return result;
    }
    /*
    * 删除一条供应商信息，或者多条供应商信息
    * */
    @RequestMapping("deleteProviderByIds")
    @ResponseBody
    public Result deleteProviderByIds(@RequestParam List<Long> ids){
        boolean flag = providerService.deleteProviderByIds(ids);
        Result result = new Result();
//        在json格式中设置一个提示信息。
        result.setMsg("成功删除！"+ids.size()+"条数据！");
        System.out.println(ids+" controller");
        return result;
    }
}
