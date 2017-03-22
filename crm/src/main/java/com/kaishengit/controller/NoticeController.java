package com.kaishengit.controller;

import com.google.common.collect.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.exception.ServiceException;
import com.kaishengit.pojo.Notice;
import com.kaishengit.pojo.NoticeView;
import com.kaishengit.service.NoticeService;
import com.kaishengit.shiro.ShiroUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liu on 2017/3/19.
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;

    @GetMapping
    public String noticeList(){
        return "notice/list";
    }

    @PostMapping("/load")
    @ResponseBody
    public DataTablesResult<Notice> load(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        Map<String,Object> param = Maps.newHashMap();
        param.put("start",start);
        param.put("length",length);

        List<Notice> noticeList = noticeService.findByParam(param);
        Long count = noticeService.count();

        return new DataTablesResult<>(draw,noticeList,count,count);

    }

    @GetMapping("/new")
    public String newNotice(){
        return"notice/new";
    }
    @PostMapping("/new")
    public String saveNotice(Notice notice){
        noticeService.save(notice);
        return "redirect:/notice";
    }

    @GetMapping("/detail/{noticeId:\\d+}")
    public String noticeDetail(@PathVariable Integer noticeId, Model model){
        Notice notice = noticeService.findById(noticeId);
        NoticeView noticeView1 = noticeService.findNoticeViewByNoticeId(noticeId) ;
        if(noticeView1==null){
            NoticeView noticeView = new NoticeView();
            noticeView.setNoticeid(noticeId);
            noticeView.setViewname(ShiroUtil.getRealName());
            noticeView.setViewtime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
            noticeService.saveNoticeView(noticeView);
        }

        List<NoticeView> noticeViewList = noticeService.findNoticeViews(noticeId);
        model.addAttribute("noticeViewList",noticeViewList);

        model.addAttribute("notice",notice);
        return "notice/view";
    }

    /**
     * 在编辑器上进行图片上传
     * @param file
     * @return
     */
    @PostMapping("/img/upload")
    @ResponseBody
    public Map<String,Object> upload(MultipartFile file){
        Map<String,Object> result = new HashMap();
        try {
            String savePath = noticeService.saveFile(file);

            result.put("success","true");
            result.put("file_path",savePath);

        }catch(ServiceException e){
            e.printStackTrace();
            result.put("success","true");
            result.put("message",e.getMessage());
        }
        return result;
    }
}
