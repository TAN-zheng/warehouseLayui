package com.cacsi.warehouse.service;

import com.cacsi.warehouse.bean.User;

public interface UserService {
    public User getUserByLoginNameAndPassword(String loginname, String password);
}
