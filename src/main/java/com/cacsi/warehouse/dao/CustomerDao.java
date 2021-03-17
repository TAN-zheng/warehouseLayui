package com.cacsi.warehouse.dao;

import com.cacsi.warehouse.bean.Customer;
import com.cacsi.warehouse.common.CustomerQuery;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface CustomerDao {
//    进行更新，修改数据。
    public boolean updateCustomer(Customer customer);

    //    查询信息
    public List<Customer> getPageList(CustomerQuery customerQuery);
//    获取页数
    public Long getCount(CustomerQuery query);
//新增客户
    public boolean addCustomer(Customer customer);
//这个查询是用于修改客户信息的,@Param("id")绑定id否则sql找不到参数，也就传不进去
    public Customer getCustomer(@Param("id") String id);
//这个是删除一条数据的
  public boolean deleteCustomerByIds(List<Long> ids);
}
