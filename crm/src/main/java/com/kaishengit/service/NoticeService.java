package com.kaishengit.service;

import com.kaishengit.dto.wx.WeixinMessage;
import com.kaishengit.exception.ServiceException;
import com.kaishengit.mapper.NoticeMapper;
import com.kaishengit.pojo.Notice;
import com.kaishengit.pojo.NoticeView;
import com.kaishengit.shiro.ShiroUtil;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by liu on 2017/3/19.
 */
@Service
public class NoticeService {

    private Logger logger = LoggerFactory.getLogger(NoticeService.class);
    @Autowired
    private NoticeMapper noticeMapper;
    @Autowired
    private WeixinService weixinService;

    @Value("${imagePath}")
    private String savePath;

    public List<Notice> findByParam(Map<String, Object> param) {
        return noticeMapper.findByParam(param);
    }

    public Long count() {
        return noticeMapper.count();
    }

    @Transactional
    public void save(Notice notice) {

        notice.setCreatetime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
        notice.setUserid(ShiroUtil.getUserId());
        notice.setRealname(ShiroUtil.getRealName());

        noticeMapper.save(notice);
        //使用微信企业号发送消息
        WeixinMessage weixinMessage = new WeixinMessage();
        weixinMessage.setToparty("8|9|10");
        WeixinMessage.TextBean text = new WeixinMessage.TextBean();
        //此处只发送公告标题
        text.setContent("公司发布了新的公告："+notice.getTitle()+"请注意查看");
        weixinMessage.setText(text);
        weixinService.sendMessage(weixinMessage);
    }

    public Notice findById(Integer noticeId) {
        return noticeMapper.findById(noticeId);
    }

    public String saveFile(MultipartFile file) {
        try {
            InputStream inputStream = file.getInputStream();
            String fileName = file.getOriginalFilename();
            fileName=  UUID.randomUUID().toString();

            OutputStream outputStream = new FileOutputStream(new File(savePath,fileName));

            IOUtils.copy(inputStream,outputStream);
            inputStream.close();
            outputStream.flush();
            outputStream.close();
            //传到本地服务器的去一个servlet或controller里面显示
            return "/preview/"+fileName;
        } catch (IOException e) {
            logger.error("编辑器文件上传失败{}",e.getMessage());
           throw new ServiceException("上传图片失败");
        }
    }

    public void saveNoticeView(NoticeView noticeView) {
        noticeMapper.saveNoticeView(noticeView);
    }

    public List<NoticeView> findNoticeViews(Integer noticeId) {
        return noticeMapper.findNoticeViews(noticeId);
    }

    public NoticeView findNoticeViewByNoticeId(Integer noticeId) {
        return noticeMapper.findNoticeViewByNoticeId(noticeId);
    }
}
