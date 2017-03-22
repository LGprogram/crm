package com.kaishengit.shiro;

import com.kaishengit.pojo.User;
import org.apache.shiro.SecurityUtils;

/**
 * Created by liu on 2017/3/18.
 */
public class ShiroUtil {
    /**
     * 获取当前登录的对象
     * @return
     */
    public static User getCurrentUser(){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        return user;
    }
    /**
     * 获取当前登录的对象账号
     * @return
     */
    public static String getUserName(){
        return getCurrentUser().getUsername();
    }

    /**
     * 获取当前登录对象ID
     * @return
     */
    public static Integer getUserId(){
        return getCurrentUser().getId();
    }

    /**
     * 获取当前登录对象的真实姓名
     * @return
     */
    public static String getRealName(){
        return getCurrentUser().getRealname();
    }
    /**
     * 判断当前登录对象是否为经理
     * @return
     */
    public static boolean isManager(){
        return SecurityUtils.getSubject().hasRole("经理");
    }
    /**
     * 判断当前登录对象是否为员工
     * @return
     */
    public static boolean isEmploee(){
        return SecurityUtils.getSubject().hasRole("员工");
    }

    /**
     * 判断当前对象是否为管理员
     * @return
     */
    public static boolean isAdmin(){
        return SecurityUtils.getSubject().hasRole("管理员");
    }

}
