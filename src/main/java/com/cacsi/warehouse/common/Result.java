package com.cacsi.warehouse.common;


import lombok.Data;

/**
 * 统一返回类的格式，在前端有一个json的字符串接受。
 * */
@Data
public class Result {

    private int code;
    private String msg;
    private Long count;
//    实体类的所有属性，这是一个对象。
    private Object data;
}
