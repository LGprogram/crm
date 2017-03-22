package com.kaishengit.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.kaishengit.dto.wx.User;
import com.kaishengit.dto.wx.WeixinMessage;
import com.kaishengit.exception.ServiceException;
import com.qq.weixin.mp.aes.AesException;
import com.qq.weixin.mp.aes.WXBizMsgCrypt;
import okhttp3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

/**
 * Created by liu on 2017/3/19.
 */
@Service
public class WeixinService {

    private Logger logger = LoggerFactory.getLogger(WeixinService.class);
    @Value("${weixin.token}")
    private String token;
    @Value("${weixin.aesk}")
    private String aesk;
    @Value("${weixin.CorpID}")
    private  String corpId;
    @Value("${weixin.Secret}")
    private String secret;
    private static final String ACCESS_TOKEN_URL = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}";
    private static final String CREATE_USER_URL = "https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token={0}";
    private static final String SEND_MESSAGE_URL = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token={0}";

    private LoadingCache<String,String> cache = CacheBuilder.newBuilder()
            .expireAfterWrite(7200, TimeUnit.SECONDS)
            .maximumSize(10)
            .build(new CacheLoader<String, String>() {
                @Override
                public String load(String s) throws Exception {//此处的s为:cache.get(Key k) k的值，
                    // 当此方法返回的数据与相关时，其作为键存起来，否则键值为空，或者任意值均可？
                    String url= MessageFormat.format(ACCESS_TOKEN_URL,corpId,secret);
                    OkHttpClient client = new OkHttpClient();
                    Request request = new Request.Builder().url(url).build();
                    Response response = client.newCall(request).execute();
                    String result =  response.body().string();
                    Map<String,Object> resultMap = new ObjectMapper().readValue(result, HashMap.class);

                    if(resultMap.containsKey("errcode")){
                        throw new ServiceException("获取微信access_token异常");
                    }else{
                        return resultMap.get("access_token").toString();
                    }
                }
            });

    /**
     * 微信企业号初始化方法
     * @return
     */
    public String init(String msg_signature, String timestamp, String nonce, String echostr) {
        try {
            WXBizMsgCrypt crypt = new WXBizMsgCrypt(token,aesk,corpId);
            return crypt.VerifyURL(msg_signature,timestamp,nonce,echostr);
        } catch (AesException e) {
            throw new ServiceException("微信初始化异常",e);
        }
    }

    public String getAccessToken(){
        try {
            return cache.get("");
        } catch (ExecutionException e) {
            throw new ServiceException("获取微信Access_token异常",e);
        }
    }

    /**
     * 微信创建用户
     * @param user
     */
    public void saveUser(User user)  {
        String url = MessageFormat.format(CREATE_USER_URL,getAccessToken());
        try {
        String json =  new ObjectMapper().writeValueAsString(user);
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/json;charset=UTF-8"),json);
        Request request = new Request.Builder().post(requestBody).url(url).build();

            Response response = new OkHttpClient().newCall(request).execute();
            String resultJson = response.body().string();
            response.close();

            Map<String,Object> result = new ObjectMapper().readValue(resultJson,HashMap.class);

            String errcode =  result.get("errcode").toString();

            if(!"0".equals(errcode)){
                logger.error("微信创建用户异常:{}",resultJson);
                throw new ServiceException("微信创建用户异常:"+resultJson);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void sendMessage(WeixinMessage weixinMessage){
        String url = MessageFormat.format(SEND_MESSAGE_URL,getAccessToken());
        try {
            String json = new ObjectMapper().writeValueAsString(weixinMessage);
            RequestBody body = RequestBody.create(MediaType.parse("application/json;charset=UTF-8"),json);
            Request request = new Request.Builder().post(body).url(url).build();
            Response response = new OkHttpClient().newCall(request).execute();
            String result = response.body().string();
            Map<String,Object> map = new ObjectMapper().readValue(result,HashMap.class);

            if(!map.get("errcode").toString().equals("0")){
                logger.error("微信企业号发送消息异常:{}",map);
                throw new ServiceException("微信发送消息异常");

            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}
