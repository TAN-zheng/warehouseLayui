package com.cacsi.warehouse.dao;

import com.cacsi.warehouse.bean.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

//添加注解，使其加载成一个bean
@Component
public interface UserDao {
    public User getUserByLoginNameAndPassword(@Param("loginname") String username,@Param("password") String password);
}
