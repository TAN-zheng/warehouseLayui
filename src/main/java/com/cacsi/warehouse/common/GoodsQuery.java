package com.cacsi.warehouse.common;

import lombok.Data;

@Data
public class GoodsQuery {
    private Long page;
    private Long limit;
    private String providername;
    private String goodsname;
    private Long productcode;
    private Long promitcode;
    private String description;
    private String gsize;
}
