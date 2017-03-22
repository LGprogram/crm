package com.kaishengit.controller;

import com.beust.jcommander.internal.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.dto.JSONResult;
import com.kaishengit.exception.NotFoundException;
import com.kaishengit.pojo.Customer;
import com.kaishengit.pojo.User;
import com.kaishengit.service.CustomerService;
import com.kaishengit.service.UserService;
import com.kaishengit.shiro.ShiroUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/3/18.
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private UserService userService;
    @GetMapping
    public String list(Model model){
        List<Customer> companyList = customerService.findCompanyAll();
        model.addAttribute("companyList",companyList);
    return "customer/list";
    }

    @PostMapping("/list")
    @ResponseBody
    public DataTablesResult<Customer> load(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");

        Map<String,Object> map = Maps.newHashMap();
        map.put("start",start);
        map.put("length",length);
        map.put("keyword",keyword);

        Long count1 = customerService.countTotle();
        Long count2 = customerService.countFile(map);
        List<Customer> customerList =customerService.findByMap(map);
        return new DataTablesResult<>(draw,customerList,count1,count2);
    }

    /**
     * 添加客户
     * @return
     */
    @PostMapping("/new")
    @ResponseBody
    public JSONResult saveCustomer(Customer customer){
       try {
            customerService.save(customer);
            JSONResult jsonResult = new JSONResult();
            jsonResult.setState(JSONResult.SUCCESS);
            return jsonResult;
       } catch (Exception e) {
            e.printStackTrace();
            return new JSONResult(e.getMessage());
        }
    }
    @PostMapping("/edit")
    @ResponseBody
    public JSONResult editCustomer(Integer id){
        Customer customer = customerService.findById(id);
        if(customer!=null){
            return new JSONResult(customer);
        }else{
            return new JSONResult(JSONResult.ERROR,"该客户不存在");
        }
    }
    @PostMapping("/update")
    @ResponseBody
    public JSONResult updateCustomer(Customer customer){
        customerService.updateCustomer(customer);
        JSONResult jsonResult = new JSONResult();
        jsonResult.setState(JSONResult.SUCCESS);
        return jsonResult;

    }
    @GetMapping("/del/{id:\\d+}")
    @ResponseBody
    public JSONResult delCustomer(@PathVariable Integer id){
        Customer customer = customerService.findById(id);
        if(customer==null){
            return new JSONResult(JSONResult.ERROR,"该客户不存在");
        }else{
            customerService.delCustomer(customer);
            JSONResult result = new JSONResult();
            result.setState(JSONResult.SUCCESS);
            return result;
        }
    }

    @GetMapping("/{id:\\d+}")
    public String detailsCustomer(@PathVariable Integer id,Model model){
        Customer customer = getCustomer(id);
        String username = ShiroUtil.getUserName();
        Map<String,Object> param = Maps.newHashMap();
        param.put("username",username);
        param.put("enable",true);
        param.put("roleid",1);

        List<User> userList = userService.findUserByParam(param);
        if("company".equals(customer.getType())){
            List<Customer> customerList = customerService.findByCompanyId(id);
            model.addAttribute("customerList",customerList);
        }
        model.addAttribute("userList",userList);
        model.addAttribute("customer",customer);
        return "customer/view";
    }
    @PostMapping("/move")
    public String moveCust(Integer id,Integer userid){
        Customer customer = getCustomer(id);
        if(customer==null){
            throw new NotFoundException();
        }
        customerService.moveCust(customer,userid);

        return "redirect:/customer";
    }
    @GetMapping("/open/{id:\\d+}")
    public String openCust(@PathVariable Integer id){
        Customer customer = getCustomer(id);
        customerService.openCust(customer);
        return "redirect:/customer/"+id;

    }



    public Customer getCustomer(Integer id){
        Customer customer = customerService.findById(id);
        if(customer!=null){
            return customer;
        }else{
            throw new NotFoundException();
        }
    }

}
