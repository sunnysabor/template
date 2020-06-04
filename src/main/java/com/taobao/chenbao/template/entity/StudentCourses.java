package com.taobao.chenbao.template.entity;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Table(name = "student_courses")
@Data
@Accessors(chain = true)
public class StudentCourses {
    /**
     * 自增主键
     */
    @Id
    private Long id;

    private Long student_id;

    private Long teacher_id;


}