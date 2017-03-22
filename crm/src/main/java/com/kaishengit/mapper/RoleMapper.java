package com.kaishengit.mapper;

import com.kaishengit.pojo.Role;

import java.util.List;

/**
 * Created by liu on 2017/3/17.
 */
public interface RoleMapper {


    Role findById(Integer id);

    List<Role> findAll();
}
