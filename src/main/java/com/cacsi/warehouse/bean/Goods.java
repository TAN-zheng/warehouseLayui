package com.cacsi.warehouse.bean;

import lombok.Data;

@Data
public class Goods {
    private Long id;
    private String goodsname;
    private String produceplace;
    private String gsize;
    private String goodspackage;
    private String productcode;
    private String promitcode;
    private String description;
    private Double price;
    private Long number;
    private Long dangernum;
    private String goodsimg;
    private Long available;
    private Long providerid;
    private String providername;
}
