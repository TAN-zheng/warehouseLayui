package com.cacsi.warehouse.bean;

import lombok.Data;

import java.util.Date;
/**
 * lombok插件和一个jar包，可以免写setter和getter 方法。
 * */
@Data
public class User {
    private long id;
    private String name;
    private String loginname;
    private String address;
    private int sex;
    private String remark;
    private String pwd;
    private long deptid;
    private Date hiredate;
    private long mgr;
    private long available;
    private long ordernum;
    private long type;
    private String imgpath;
    private String salt;
}
