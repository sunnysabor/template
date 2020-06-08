package com.taobao.chenbao.template.controller;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.result.ExcelImportResult;
import com.taobao.chenbao.template.biz.ExampleBiz;
import com.taobao.chenbao.template.entity.Student;
import com.taobao.chenbao.template.entity.StudentCourses;
import com.taobao.chenbao.template.entity.Teacher;
import com.taobao.chenbao.template.entity.UserAdmin;
import com.taobao.chenbao.template.mapper.StudentCoursesMapper;
import com.taobao.chenbao.template.mapper.StudentMapper;
import com.taobao.chenbao.template.mapper.TeacherMapper;
import com.taobao.chenbao.template.mapper.UserAdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Struct;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @Description:
 * @Author jerry
 * Date 2020/6/6 8:59 上午
 **/
@Controller
@RequestMapping("/business")
public class BusinessController {

    @Autowired
    StudentCoursesMapper studentCoursesMapper;
    @Autowired
    StudentMapper studentMapper;
    @Autowired
    TeacherMapper teacherMapper;
    @Autowired
    UserAdminMapper userAdminMapper;

    @GetMapping("/getStdCourses")
    public List<StudentCourses> getStudentCourses(long studentId) {
        Example example = ExampleBiz.getExample(StudentCourses.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("student_id", studentId);
        return studentCoursesMapper.selectByExample(example);
    }

    @GetMapping("/studentinfo")
    public String getStudent(HttpServletRequest request) {
        return "studentinfo";
    }

    @GetMapping("/teacherinfo")
    public String getTeacherInfo(HttpServletRequest request) {
        return "teacherinfo";
    }

    @GetMapping("/studentcourses")
    public String getStudentCourses() {
        return "studentcourses";
    }

    @GetMapping("/changepwd")
    public String changePwd() {
        return "changepwd";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "login";
    }

    @PostMapping("changePassword")
    @ResponseBody
    public String changePassWord(String newPassword, HttpSession session, HttpServletResponse response) throws IOException {
        String role = (String) session.getAttribute("role");
        Object object = session.getAttribute("userinfo");
        if (StringUtils.isEmpty(role) || Objects.isNull(object)) {
            //   return "login";
            return "<h1>修改失败</h1>";

        }

        if ("student".equals(role)) {
            Student student = (Student) object;
            student.setPassword(newPassword);
            studentMapper.updateByPrimaryKeySelective(student);
            return "<h1>修改成功</h1>";
        }
        return "<h1>修改成功</h1>";
    }


    @PostMapping("/batch")
    public void batchChange(@RequestParam("file") MultipartFile file, @RequestParam("role") String role, HttpServletRequest request) throws Exception {
        if ("teachet".equals(role)) {
            ExcelImportResult<Teacher> excelImportResult = getTeachers(file);
            List<Teacher> teachers = excelImportResult.getList();
            teachers.forEach(teacher -> teacherMapper.insert(teacher));
        }
        if ("student".equals(role)) {
            ExcelImportResult<Student> excelImportResult = getStudents(file);
            List<Student> students = excelImportResult.getList();
            students.forEach(student -> studentMapper.insert(student));
        }
        if ("userAdmin".equals(role)) {
            ExcelImportResult<UserAdmin> excelImportResult = getUserAdmin(file);
            List<UserAdmin> userAdmins = excelImportResult.getList();
            userAdmins.forEach(userAdmin -> userAdminMapper.insert(userAdmin));
        }
    }

    private ExcelImportResult<UserAdmin> getUserAdmin(MultipartFile file) throws Exception {
        ImportParams params = new ImportParams();
        params.setNeedVerfiy(true);
        params.setHeadRows(1);
        ExcelImportResult<UserAdmin> result = ExcelImportUtil.importExcelMore(file.getInputStream(), UserAdmin.class, params);
        return result;
    }


    private ExcelImportResult<Teacher> getTeachers(MultipartFile file) throws Exception {
        ImportParams params = new ImportParams();
        params.setNeedVerfiy(true);
        params.setHeadRows(1);
        ExcelImportResult<Teacher> result = ExcelImportUtil.importExcelMore(file.getInputStream(), Teacher.class, params);
        return result;
    }

    private ExcelImportResult<Student> getStudents(MultipartFile file) throws Exception {
        ImportParams params = new ImportParams();
        params.setNeedVerfiy(true);
        params.setHeadRows(1);
        ExcelImportResult<Student> result = ExcelImportUtil.importExcelMore(file.getInputStream(), Student.class, params);
        return result;
    }
}
