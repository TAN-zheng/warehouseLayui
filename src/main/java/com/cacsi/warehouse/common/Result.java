package com.cacsi.warehouse.common;


import lombok.Data;

/**
 * 统一返回类的格式，在前端有一个json的字符串。
 * */
@Data
public class Result {

    private int code;
    private String msg;
    private Long count;
    private Object data;
}
