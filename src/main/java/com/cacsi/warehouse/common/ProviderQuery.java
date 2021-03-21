package com.cacsi.warehouse.common;

import lombok.Data;

@Data
public class ProviderQuery {
        private long page;
        private long limit;
        private String providername;
        private String telephone;
        private String connectionperson;
}
