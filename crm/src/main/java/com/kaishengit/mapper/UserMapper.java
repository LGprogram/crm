package com.kaishengit.mapper;

import com.kaishengit.pojo.User;

import java.util.List;
import java.util.Map;

/**
 * Created by liu on 2017/3/17.
 */
public interface UserMapper {
    User findByUserName(String username);

    Long findAll();

    Long findAllByQueryParam(Map<String, Object> queryParam);

    List<User> findUserByQueryParam(Map<String, Object> queryParam);

    void save(User user);

    User findUserById(Integer id);

    void update(User user);

    List<User> findByParam(Map<String, Object> param);
}
