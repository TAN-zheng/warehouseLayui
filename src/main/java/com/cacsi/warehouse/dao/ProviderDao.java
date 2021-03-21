package com.cacsi.warehouse.dao;

import com.cacsi.warehouse.bean.Provider;
import com.cacsi.warehouse.common.ProviderQuery;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ProviderDao {
//    获取所有的供应商信息。
    public List<Provider> getPageList(ProviderQuery providerQuery);
//这个查询是为了统计有多少条数据
    public Long getCount(ProviderQuery providerQuery);
// 这是前端新增供应商信息的接口方法。
    public boolean addProvider(Provider provider);
//这个dao的目的是为了编辑按钮，修改数据的作用。
    /*
    *传入的参数需要标记，否则sql语句找不到这个传入的参数。
    * */
    public Provider getProvider(@Param("id") String id);
//进行修改，编辑的dao
    public boolean updateProvider(Provider provider);
//list页面的删除操作
    public boolean deleteProviderByIds(List<Long> ids);
}
