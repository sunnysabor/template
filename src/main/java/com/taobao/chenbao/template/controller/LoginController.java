package com.taobao.chenbao.template.controller;

import com.taobao.chenbao.template.biz.ExampleBiz;
import com.taobao.chenbao.template.biz.TemplateBiz;
import com.taobao.chenbao.template.entity.Student;
import com.taobao.chenbao.template.entity.StudentCourses;
import com.taobao.chenbao.template.entity.Teacher;
import com.taobao.chenbao.template.mapper.StudentCoursesMapper;
import com.taobao.chenbao.template.mapper.StudentMapper;
import com.taobao.chenbao.template.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * @Description:
 * @Author jerry
 * Date 2020/6/3 7:16 下午
 **/
@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    TemplateBiz templateBiz;
    @Autowired
    StudentMapper studentMapper;
    @Autowired
    TeacherMapper teacherMapper;
    @Autowired
    StudentCoursesMapper studentCoursesMapper;

    @GetMapping
    public String login(String role, String username, String password, String inputstr, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        String code = (String) session.getAttribute("code");
        String fail = "login";
        if (StringUtils.isEmpty(inputstr) || StringUtils.isEmpty(code)) {
            request.setAttribute("error", "请填写验证码！");
            request.setAttribute("ming", username);
            request.setAttribute("mima", password);
            return fail;
        }
        if (!code.equals(inputstr)) {
            request.setAttribute("error", "验证码错误！");
            request.setAttribute("ming", username);
            request.setAttribute("mima", password);
            return fail;
        }
        session.setAttribute("role", role);
        if ("student".equals(role)) {
            Example example = ExampleBiz.getExample(Student.class);
            example.createCriteria().andEqualTo("name", username).andEqualTo("password", password);
            List<Student> students = studentMapper.selectByExample(example);
            if (CollectionUtils.isEmpty(students)) {
                request.setAttribute("error", "用户名密码错误！");
                request.setAttribute("ming", username);
                request.setAttribute("mima", password);
                return fail;
            }
            request.getSession().setAttribute("userinfo", students.get(0));
            session.setAttribute("userinfo", students.get(0));
            Example coursesEx = ExampleBiz.getExample(StudentCourses.class);
            Example.Criteria criteria = coursesEx.createCriteria();
            criteria.andEqualTo("student_id", students.get(0).getId());
            List<StudentCourses> sources = studentCoursesMapper.selectByExample(coursesEx);
            if (!CollectionUtils.isEmpty(sources)) {
                session.setAttribute("studentcourses", sources.get(0));
            }
            return "student";
        } else if ("teacher".equals(role)) {
            Example example = ExampleBiz.getExample(Teacher.class);
            example.createCriteria().andEqualTo("name", username).andEqualTo("password", password);
            List<Teacher> teachers = teacherMapper.selectByExample(example);
            if (CollectionUtils.isEmpty(teachers)) {
                request.setAttribute("error", "用户名密码错误！");
                request.setAttribute("ming", username);
                request.setAttribute("mima", password);
                return fail;
            }
            request.getSession().setAttribute("userinfo", teachers.get(0));
            session.setAttribute("userinfo", teachers.get(0));
            Example coursesEx = ExampleBiz.getExample(StudentCourses.class);
            Example.Criteria criteria = coursesEx.createCriteria();
            criteria.andEqualTo("teacher_id", teachers.get(0).getId());
            List<StudentCourses> sources = studentCoursesMapper.selectByExample(coursesEx);
            if (!CollectionUtils.isEmpty(sources)) {
                session.setAttribute("studentcourses", sources.get(0));
            }
            return "teacher";
        } else if ("userAdmin".equals(role)) {
            return "userAdmin";
        } else {

        }
        return "error";
    }


}
