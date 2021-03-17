package com.cacsi.warehouse.config;

import com.cacsi.warehouse.interceptor.MyInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@Configuration
public class MyInterceptorConfig extends WebMvcConfigurationSupport {
    @Autowired
    private MyInterceptor myInterceptor;
    /**
     *
     * 功能描述:
     *  配置静态资源,避免静态资源请求被拦截
     */
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/templates/**")
                .addResourceLocations("classpath:/templates/");
    }
    //添加拦截器
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(myInterceptor)
                //addPathPatterns 用于添加拦截规则 /**代表拦截所有请求
                .addPathPatterns("/**")
                //excludePathPatterns 用于排除拦截 此处我们排除"/"(登录界面)以及"/loginCheck"（验证登录账号密码方法
                .excludePathPatterns("/")
                .excludePathPatterns("/checkUser")
                .excludePathPatterns("/templates/**")
                .excludePathPatterns("/static/**");

    }
}
