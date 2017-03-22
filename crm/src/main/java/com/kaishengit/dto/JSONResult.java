package com.kaishengit.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
//将该标记放在属性上，如果该属性为NULL则不参与序列化
//如果放在类上边,那对这个类的全部属性起作用
@JsonInclude(JsonInclude.Include.NON_NULL)
public class JSONResult {

    public static final String SUCCESS = "success";
    public static final String ERROR = "error";

    private String state;
    private String message;
    private Object data;

    public JSONResult(Object data) {
        this(SUCCESS,data);
    }

    public JSONResult(String message) {
        this(ERROR,message);
    }

    public JSONResult(){}

    public JSONResult(String state, String message) {
        this.state = state;
        this.message = message;
    }

    public JSONResult(String state, Object data) {
        this.state = state;
        this.data = data;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
