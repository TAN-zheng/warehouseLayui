package com.cacsi.warehouse.service;


import com.cacsi.warehouse.bean.Customer;
import com.cacsi.warehouse.common.CustomerQuery;
import com.cacsi.warehouse.dao.CustomerDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {
    @Autowired
    CustomerDao customerDao;
//    分页查询
    public List<Customer> getPageList(CustomerQuery customerQuery){
        List<Customer> customerList = customerDao.getPageList(customerQuery);
        return customerList;
    }

//    获取查询数据的总条数
    public Long getCount(CustomerQuery customerQuery){
        Long count = customerDao.getCount(customerQuery);
        return count;
    }

    public boolean addCustomer(Customer customer) {
        return customerDao.addCustomer(customer);
    }

    public Customer getCustomer(String id) {
        return customerDao.getCustomer(id);
    }

    public boolean updateCustomer(Customer customer) {
        return customerDao.updateCustomer(customer);
    }

    public boolean deleteCustomerByIds(List<Long> ids) {
        return customerDao.deleteCustomerByIds(ids);
    }
}
