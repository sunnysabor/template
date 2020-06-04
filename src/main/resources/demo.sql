drop table if exists student,teacher,student_courses,user_admin;
CREATE TABLE `student`
(
    `id`       bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`     varchar(100) COLLATE utf8mb4_bin COMMENT '角色中文名称',
    `no`       varchar(60) COLLATE utf8mb4_bin COMMENT '角色',
    `password` varchar(60) COLLATE utf8mb4_bin COMMENT '冗余字段',
    `major`    varchar(100),
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT ='学生表';

CREATE TABLE `teacher`
(
    `id`       bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`     varchar(100) COLLATE utf8mb4_bin COMMENT '角色中文名称',
    `no`       varchar(60) COLLATE utf8mb4_bin COMMENT '角色',
    `password` varchar(60) COLLATE utf8mb4_bin COMMENT '冗余字段',
    `major`    varchar(100),
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT ='老师表';

CREATE TABLE `student_courses`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `student_id` bigint(20) unsigned NOT NULL,
    `teacher_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT ='选择表';
CREATE TABLE `user_admin`
(
    `id`       bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`     varchar(100) COLLATE utf8mb4_bin COMMENT '角色中文名称',
    `no`       varchar(60) COLLATE utf8mb4_bin COMMENT '角色',
    `password` varchar(60) COLLATE utf8mb4_bin COMMENT '冗余字段',
    `role`     varchar(100),
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT ='管理员表';