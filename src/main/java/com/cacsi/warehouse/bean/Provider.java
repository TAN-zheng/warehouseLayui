package com.cacsi.warehouse.bean;

import lombok.Data;

@Data
public class Provider {
    private Long id;
    private String providername;
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
