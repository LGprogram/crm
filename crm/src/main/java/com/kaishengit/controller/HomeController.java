package com.kaishengit.controller;

import com.kaishengit.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by liu on 2017/3/17.
 */
@Controller
public class HomeController {
    @Autowired
    private UserService userService;

    /**
     * 去登录页面
     * @return
     */
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index() {
        return "login";
    }

    @RequestMapping(value = "/",method = RequestMethod.POST)
    public String login(String username, String password,
                        RedirectAttributes redirectAttributes, HttpServletRequest request) {
        Subject subject = SecurityUtils.getSubject();

        if(subject.isAuthenticated()) {
            //当前用户已经登录,则先退出之前的账号（选做）
            subject.logout();
        }

        try {
            UsernamePasswordToken usernamePasswordToken =
                    new UsernamePasswordToken(username, DigestUtils.md5Hex(password));
            subject.login(usernamePasswordToken);


            return "redirect:/home";
        } catch (LockedAccountException ex) {
            redirectAttributes.addFlashAttribute("message","账号已被禁用");
        } catch (AuthenticationException exception) {
            redirectAttributes.addFlashAttribute("message","账号或密码错误");
        }
        return "redirect:/";
    }
    @GetMapping("/home")
    public String home() {
        return "home";
    }
}
