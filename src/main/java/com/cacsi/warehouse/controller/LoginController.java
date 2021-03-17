package com.cacsi.warehouse.controller;

import com.cacsi.warehouse.bean.User;
import com.cacsi.warehouse.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    UserServiceImpl userService;
//    访问登录页面
    @RequestMapping("/")
    public String toLogin(){
        return "views/user/login";
    }
//    进行登陆验证
    @RequestMapping("/checkUser")
    public String checkUser(HttpSession session, @RequestParam("loginname") String loginname, @RequestParam("password") String password){
        System.out.println(loginname+password);
        User user = userService.getUserByLoginNameAndPassword(loginname,password);
        if (user !=null){
            session.setAttribute("user",user);
            return "redirect:/toIndex";
        }
        session.setAttribute("msg","用户名或者密码错误！");
        return "redirect:/";
    }

//    退出
    @RequestMapping("/logOut")
    public String logOut(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }
}
