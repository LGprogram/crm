package com.kaishengit.service;

import com.kaishengit.mapper.RoleMapper;
import com.kaishengit.pojo.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by liu on 2017/3/18.
 */
@Service
public class RoleService {
    @Autowired
    private RoleMapper roleMapper;
    public List<Role> findAll() {
        return roleMapper.findAll();
    }
}
