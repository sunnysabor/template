package com.taobao.chenbao.template.entity;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Table(name = "user_admin")
@Data
@Accessors(chain = true)
public class UserAdmin {
    /**
     * 自增主键
     */
    @Id
    private Long id;

    /**
     * 角色中文名称
     */
    private String name;

    /**
     * 角色
     */
    private String no;

    /**
     * 冗余字段
     */
    private String password;

    private String role;

}