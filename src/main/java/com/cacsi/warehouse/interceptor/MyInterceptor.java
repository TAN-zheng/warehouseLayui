package com.cacsi.warehouse.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class MyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取session中的user标签
        Object user=request.getSession().getAttribute("user");
        //如果user为空则说明没有登录
        if(user==null){
            //添加提示信息
            request.getSession().setAttribute("msg","请先登录！！");
            //重定向到根目录即登录页面
            request.getRequestDispatcher("/").forward(request,response);
            //返回false拒绝执行该方法
            return false;
        }
        //放行，执行该方法
        return true;
    }
}
