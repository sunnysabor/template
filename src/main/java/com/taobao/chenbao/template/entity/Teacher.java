package com.taobao.chenbao.template.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Table(name = "teacher")
@Data
@Accessors(chain = true)
public class Teacher {
    /**
     * 自增主键
     */
    @Id
    private Long id;

    /**
     * 角色中文名称
     */
    @Excel(name = "老师名称", isImportField = "true", width = 20)
    private String name;

    /**
     * 角色
     */
    @Excel(name = "老师职工号", isImportField = "true", width = 20)
    private String no;

    /**
     * 冗余字段
     */
    @Excel(name = "教师密码", isImportField = "true", width = 20)
    private String password;
    @Excel(name = "专业", isImportField = "true", width = 20)
    private String major;


}