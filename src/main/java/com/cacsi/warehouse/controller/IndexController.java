package com.cacsi.warehouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class IndexController {
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "views/index";
    }
    @RequestMapping("/toConsole")
    public String toConsole(){

        return "views/home/console";
    }

}
