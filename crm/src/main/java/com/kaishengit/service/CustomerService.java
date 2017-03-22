package com.kaishengit.service;

import com.kaishengit.mapper.CustomerMapper;
import com.kaishengit.pojo.Customer;
import com.kaishengit.pojo.User;
import com.kaishengit.shiro.ShiroUtil;
import com.kaishengit.util.PinYinUtil;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/3/18.
 */
@Service
public class CustomerService {
    @Autowired
    private CustomerMapper customerMapper;



    public Long countTotle() {
        return customerMapper.count();
    }

    public Long countFile(Map<String, Object> map) {
        return customerMapper.count(map);
    }

    public List<Customer> findByMap(Map<String, Object> map) {
        if(ShiroUtil.isEmploee()){
            map.put("userid",ShiroUtil.getUserId());
        }

        return customerMapper.findByMap(map);
    }

    public List<Customer> findCompanyAll() {
        return customerMapper.findCompany();
    }
    public Customer findByName(String name){
        return customerMapper.findIdByName(name);
    }

    public void save(Customer customer) {
        User user = ShiroUtil.getCurrentUser();
        customer.setUserid(user.getId());
        customer.setCreatetime(DateTime.now().toString("yyyy-MM-dd"));
        customer.setPinyin(PinYinUtil.getPinYin(customer.getName()));
        if(customer.getCompanyid()!=null){
            customer.setCompanyname(findById(customer.getCompanyid()).getName());
        }
        customerMapper.save(customer);
    }

    public Customer findById(Integer id) {
        return customerMapper.findById(id);
    }

    public void updateCustomer(Customer customer) {
        customer.setPinyin(PinYinUtil.getPinYin(customer.getName()));
        if(customer.getCompanyname()!=null){
            customer.setCompanyid(findByName(customer.getCompanyname()).getId());
        }
        customerMapper.update(customer);
    }
    public void del(Integer id){
        //1.删除销售机会
        //2.删除待办事项
        //3.删除客户

        customerMapper.delCustomer(id);
    }


    @Transactional
    public void delCustomer(Customer customer) {
        //1.删除销售机会
        //2.删除待办事项
        //3.删除客户
        if("person".equals(customer.getType())){
            del(customer.getId());

        }else{
         List<Customer> customerList = customerMapper.findByCompanyId(customer.getId());
         for (Customer cus:customerList){
            del(cus.getId());
         }
            del(customer.getId());
        }
    }

    public List<Customer> findByCompanyId(Integer id) {
        return customerMapper.findByCompanyId(id);
    }

    /**
     * 转移客户
     * @param customer
     * @param userid
     */
    public void moveCust(Customer customer, Integer userid) {
        customer.setUserid(userid);
        customerMapper.update(customer);
    }

    public void openCust(Customer customer) {
        customer.setUserid(null);
        customerMapper.update(customer);
    }
}
