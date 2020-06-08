package com.taobao.chenbao.template.biz;

import com.taobao.chenbao.template.entity.StudentCourses;
import tk.mybatis.mapper.entity.Example;

/**
 * @Description:
 * @Author jerry
 * Date 2020/6/6 9:03 上午
 **/
public class ExampleBiz {

    public static Example getExample(Class c) {
        return new Example(c, false);
    }
}
