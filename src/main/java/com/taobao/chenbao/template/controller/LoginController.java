package com.taobao.chenbao.template.controller;

import com.taobao.chenbao.template.biz.TemplateBiz;
import com.taobao.chenbao.template.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author jerry
 * Date 2020/6/3 7:16 下午
 **/
@RestController
@RequestMapping("/login")
public class LoginController {

    @Autowired
    TemplateBiz templateBiz;

    @GetMapping
    public List<Student> login() {
        templateBiz.save();
        return templateBiz.getStudents();
    }


}
