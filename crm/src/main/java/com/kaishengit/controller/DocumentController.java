package com.kaishengit.controller;

import com.kaishengit.exception.NotFoundException;
import com.kaishengit.pojo.Document;
import com.kaishengit.service.DocumentService;
import com.kaishengit.shiro.ShiroUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.List;

/**
 * Created by liu on 2017/3/18.
 */
@Controller
@RequestMapping("/doc")
public class DocumentController {
    @Autowired
    private DocumentService documentService;
    @Value("${imagePath}")
    private String savePath;
    @GetMapping
    public String doc(@RequestParam(required = false,defaultValue = "0") Integer fid, Model model){
        List<Document> documentList = documentService.findAll(fid);
        model.addAttribute("documentList",documentList);
        model.addAttribute("fid",fid);
        return "doc/docList";
    }

    /**
     * 保存新文件夹
     * @param document
     * @return
     */
    @PostMapping("/newDir")
    public String newDir(Document document){
        document.setType(Document.DIRECTORY_TYPE);
        document.setCreateuser(ShiroUtil.getUserName());
        Integer fid = document.getFid();
        documentService.save(document);

        return "redirect:/doc?fid="+fid;

    }
    /**
     * 文件上传
     * @return
     */
    @RequestMapping(value = "/file/upload",method = RequestMethod.POST)
    @ResponseBody
    public String saveFile(MultipartFile file, Integer fid) throws IOException {
        if(file.isEmpty()) {
            throw new NotFoundException();
        } else {
            documentService.saveFile(file.getInputStream(),file.getOriginalFilename(),file.getContentType(),file.getSize(),fid);
        }
        return "success";
    }

    //文件下载
    @GetMapping("/download/{id:\\d+}")
    public ResponseEntity<InputStreamResource> downloadFile(@PathVariable Integer id) throws FileNotFoundException, UnsupportedEncodingException {
        Document document = documentService.findDocumentById(id);
        if(document == null) {
            throw new NotFoundException();
        }
        File file = new File(savePath,document.getFilename());
        if(!file.exists()) {
            throw new NotFoundException();
        }

        FileInputStream inputStream = new FileInputStream(file);
        String fileName = document.getName();
        fileName = new String(fileName.getBytes("UTF-8"),"ISO8859-1");

        return ResponseEntity
                .ok()
                .contentType(MediaType.parseMediaType(document.getContexttype()))
                .contentLength(file.length())
                .header("Content-Disposition","attachment;filename=\""+fileName+"\"")
                .body(new InputStreamResource(inputStream));
    }
}
