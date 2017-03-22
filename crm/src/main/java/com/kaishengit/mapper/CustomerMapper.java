package com.kaishengit.mapper;

import com.kaishengit.pojo.Customer;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/3/18.
 */
public interface CustomerMapper {
    Long count();

    Long count(Map<String, Object> map);

    List<Customer> findByMap(Map<String, Object> map);

    List<Customer> findCompany();

    void save(Customer customer);

    Customer findIdByName(String name);

    Customer findById(Integer id);

    void update(Customer customer);

    void delCustomer(Integer id);

    List<Customer> findByCompanyId(Integer companyId);
}
