package com.kaishengit.controller;

import com.beust.jcommander.internal.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.dto.JSONResult;
import com.kaishengit.pojo.Role;
import com.kaishengit.pojo.User;
import com.kaishengit.service.RoleService;
import com.kaishengit.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by liu on 2017/3/17.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/users",method = RequestMethod.GET)
    public String userList(Model model) {
        List<Role> roleList = roleService.findAll();
        model.addAttribute("roleList",roleList);
        return "admin/userlist";
    }

    @PostMapping("/users/load")
    @ResponseBody
    public DataTablesResult<User> load(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");

        Map<String,Object> queryParam = Maps.newHashMap();

        queryParam.put("start",start);
        queryParam.put("length",length);
        queryParam.put("keyword",keyword);

        Long recordsTotal = userService.findAll();
        Long recordsFiltered = userService.findAllByQueryParam(queryParam);
        List<User> data = userService.findUserByQueryParam(queryParam);
        //DataTablesResult(String draw, List<T> data, Long recordsTotal, Long recordsFiltered)
        DataTablesResult<User> dataTablesResult = new DataTablesResult<>(draw,data,recordsTotal,recordsFiltered);

        return dataTablesResult;
    }

    @PostMapping("/users/new")
    @ResponseBody
    public String save(User user ){
        userService.save(user);

        return "success";
    }

    @GetMapping("/users/checkusername")
    @ResponseBody
    public String checkusername(String username){
        User user  = userService.findUserByname(username);
        if(user==null){
            return "true";
        }else{
            return "false";
        }
    }

    @PostMapping("/users/edit")
    @ResponseBody
    public JSONResult edit(Integer id){
        User user = userService.finUserById(id);
        if(user==null){
            return new JSONResult(JSONResult.ERROR,"找不到这个用户");
        }else{
            return new JSONResult(user);
        }
    }

    @GetMapping("/users/checkeditusername")
    @ResponseBody
    public String checkeditusername(HttpServletRequest request){
        String id = request.getParameter("id");
        System.out.println("id:"+id);
        String username = request.getParameter("username");
        User user = userService.findUserByname(username);
        if(user!=null){
            if(user.getId().equals(id)){
                return "true";
            }else{
                return "false";
            }
        }else{
            return "true";
        }
    }

    @PostMapping("/users/update")
    @ResponseBody
    public String edit(User user){
        userService.updateUser(user);
        return"success";
    }

    @PostMapping("/users/resetpassword")
    @ResponseBody
    public  String resetPassword(Integer id){
        User user = userService.finUserById(id);
        if(user!=null){
            user.setPassword("000000");
            userService.updateUser(user);
            return "success";
        }else{
            return "error";
        }

    }
}
