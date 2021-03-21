package com.cacsi.warehouse.service;

import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.ProviderQuery;
import com.cacsi.warehouse.dao.ProviderDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProviderService {
//    注入dao接口
    @Autowired
    ProviderDao providerDao;
//      查询所有的供应商数据，或者实现精确的个别筛选的数据。具体实现是sql动态查询实现的。
        public List<Provider> getPageList(ProviderQuery providerQuery){
            List<Provider> providerList = providerDao.getPageList(providerQuery);
            return providerList;
        }
/*
        统计数据有多少条。
*/
        public Long getCount(ProviderQuery providerQuery){
            Long count = providerDao.getCount(providerQuery);
            return count;
        }
//新增一个供应商信息记录到数据库。
    public boolean addProvider(Provider provider) {
        return providerDao.addProvider(provider);
    }
//    根据id查询一个数据，显示在编辑列表里面。
    public Provider getProvider(String id) {

        return providerDao.getProvider(id);
    }
//进行编辑，修改的dao层。
    public boolean updateProvider(Provider provider) {
     return providerDao.updateProvider(provider);
    }

    public boolean deleteProviderByIds(List<Long> ids) {
        System.out.println(ids+"Service");
        return providerDao.deleteProviderByIds(ids);
    }
}
