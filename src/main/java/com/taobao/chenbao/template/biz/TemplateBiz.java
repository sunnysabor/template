package com.taobao.chenbao.template.biz;

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
    @Autowired
    StudentCoursesMapper studentCoursesMapper;
    @Autowired
    UserAdminMapper userAdminMapper;

    public List<Student> getStudents() {
        return studentMapper.selectAll();
    }

    public List<Teacher> getTeacher(){
        return teacherMapper.selectAll();
    }

    public List<StudentCourses> getStCrs(){
        return studentCoursesMapper.selectAll();
    }

    public void saveStudent(Student student) {
        studentMapper.insert(student);
    }

    public void saveTeacher(Teacher teacher) {
        teacherMapper.insert(teacher);
    }

    public void saveStudentCourse(StudentCourses studentCourses) {
        studentCoursesMapper.insert(studentCourses);
    }

    public void saveUserAdmin(UserAdmin userAdmin) {
        userAdminMapper.insert(userAdmin);
    }
}
