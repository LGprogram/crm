package com.kaishengit.service;

import com.kaishengit.mapper.UserMapper;
import com.kaishengit.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by liu on 2017/3/17.
 */
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private WeixinService weixinService;
    public Long findAll() {
        return userMapper.findAll();
    }

    public Long findAllByQueryParam(Map<String,Object> queryParam) {
        return userMapper.findAllByQueryParam(queryParam);
    }

    public List<User> findUserByQueryParam(Map<String, Object> queryParam) {
        return userMapper.findUserByQueryParam(queryParam);
    }
    @Transactional
    public void save(User user) {
        user.setEnable(true);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String createtime = simpleDateFormat.format(new Date());
        user.setCreatetime(createtime);
        userMapper.save(user);

        //保存到微信
        com.kaishengit.dto.wx.User wxUser = new com.kaishengit.dto.wx.User();
        wxUser.setName(user.getRealname());
        wxUser.setUserid(user.getId().toString());
        wxUser.setMobile(user.getWeixin());
        wxUser.setDepartment(Arrays.asList(user.getRoleid()));
        weixinService.saveUser(wxUser);


    }

    public User findUserByname(String username) {
        return userMapper.findByUserName(username);
    }

    public User finUserById(Integer id) {
        return userMapper.findUserById(id);
    }

    public void updateUser(User user) {
        userMapper.update(user);
    }

    public List<User> findUserByParam(Map<String, Object> param) {
        return userMapper.findByParam(param);
    }
}
