package com.taobao.chenbao.template.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Table(name = "student")
@Data
@Accessors(chain = true)
public class Student {
    /**
     * 自增主键
     */
    @Id
    private Long id;

    /**
     * 角色中文名称
     */
    @Excel(name = "学生名称", isImportField = "true", width = 20)
    private String name;

    /**
     * 角色
     */
    @Excel(name = "学号", isImportField = "true", width = 20)
    private String no;

    /**
     * 冗余字段
     */
    @Excel(name = "学生密码", isImportField = "true", width = 20)
    private String password;
    @Excel(name = "学生专业", isImportField = "true", width = 20)
    private String major;
    @Excel(name = "学生性别", isImportField = "true", width = 20)
    private int sex;

}