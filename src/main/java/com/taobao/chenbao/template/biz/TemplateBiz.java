package com.taobao.chenbao.template.biz;

import com.taobao.chenbao.template.entity.Student;
import com.taobao.chenbao.template.mapper.StudentMapper;
import com.taobao.chenbao.template.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @Description: Date 2020/6/3 7:12 下午
 **/
@Component
public class TemplateBiz {

    @Autowired
    StudentMapper studentMapper;
    @Autowired
    TeacherMapper teacherMapper;

    public List<Student> getStudents() {
        return studentMapper.selectAll();
    }

    public void save() {
        Student student = new Student().setName("jerry").setMajor("物理");
        studentMapper.insert(student);
    }
}
