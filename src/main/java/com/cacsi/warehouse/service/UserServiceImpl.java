package com.cacsi.warehouse.service;

import com.cacsi.warehouse.bean.User;
import com.cacsi.warehouse.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
     UserDao userDao;
    @Override
    public User getUserByLoginNameAndPassword(String loginname, String password) {
        return userDao.getUserByLoginNameAndPassword(loginname,password);
    }
}
