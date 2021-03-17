package com.cacsi.warehouse.bean;


import lombok.Data;

/**
 * 客户类
 * */
@Data
public class Customer {
    private Long id;
    private String customername;
    private String zip;
    private String address;
    private String telephone;
    private String connectionperson;
    private String phone;
    private String bank;
    private String account;
    private String email;
    private String fax;
    private Long available;
}
