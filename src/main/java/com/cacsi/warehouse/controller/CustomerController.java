package com.cacsi.warehouse.controller;

import com.cacsi.warehouse.bean.Customer;
import com.cacsi.warehouse.common.CustomerQuery;
import com.cacsi.warehouse.common.Result;
import com.cacsi.warehouse.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController {
//    注入CustomerService
    @Autowired
    CustomerService customerService;


    @RequestMapping("toCustomerList")
    public String toCustomerList() {
        return "/views/customer/customerList";
    }


    /**
     *
     * 分页数据
     */

    @RequestMapping("getPageList")
//    解析成json的格式转换，需要这个注解。
    @ResponseBody
//    传一个请求对象进来CustomerQuery,
    public Result getPageList(@RequestBody CustomerQuery customerQuery){
//        因为传是从1开始传的,page查询的时候是从0开始查的。
        customerQuery.setPage(customerQuery.getPage()-1);
        List<Customer> customerList = customerService.getPageList(customerQuery);
        Long count = customerService.getCount(customerQuery);
        Result result = new Result();
        result.setCode(0);
        result.setCount(count);
        result.setData(customerList);
        System.out.println(result);
        return result;
    }

    @RequestMapping("customerLayer")
    public String customerLayer(@RequestParam(required = false,value = "id") String id, Model model){
        Customer customer = customerService.getCustomer(id);
//        用model传到前台，用EL表达式拿到这个数据。
        model.addAttribute("customer",customer);
        return "views/customer/customerLayer";
    }
    @RequestMapping("addOrUpdateCustomer")
    @ResponseBody
    public Result addOrUpdateCustomer(@RequestBody Customer customer){
        System.out.println(customer);
        boolean flag=false;
        if (customer.getId()==null){
            flag= customerService.addCustomer(customer);
        }else {
            flag= customerService.updateCustomer(customer);
        }
        Result result = new Result();
        if (flag==true){

            result.setMsg("操作成功");
        }else {
            result.setMsg("操作失败");
        }
        return result;
    }
    @RequestMapping("deleteCustomerByIds")
    @ResponseBody
    public Result deleteCustomerByIds(@RequestParam List<Long> ids){
        boolean flag = customerService.deleteCustomerByIds(ids);
        Result result = new Result();
        result.setMsg("成功删除"+ids.size()+"条数据！");
        System.out.println(ids);
        return result;
     }
}
