package com.kaishengit.service;

import com.kaishengit.mapper.DocumentMapper;
import com.kaishengit.pojo.Document;
import com.kaishengit.shiro.ShiroUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by liu on 2017/3/18.
 */
@Service
public class DocumentService {
    @Autowired
    private DocumentMapper documentMapper;

    @Value("${imagePath}")
    private String savePath;

    public List<Document> findAll(Integer fid) {
        return documentMapper.findAll(fid);
    }

    public void save(Document document) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        document.setCreatetime(simpleDateFormat.format(new Date()));

        documentMapper.save(document);
    }

    public void saveFile(InputStream inputStream, String originalFilename, String contentType, long size, Integer fid) {
        //String md5 = null;
        String extName = "";
        if(originalFilename.lastIndexOf(".") != -1) {
            extName = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String newFileName = UUID.randomUUID().toString() + extName;
        try {
            //md5 = DigestUtils.md5Hex(inputStream);
            FileOutputStream outputStream = new FileOutputStream(new File(savePath,newFileName));
            IOUtils.copy(inputStream,outputStream);
            outputStream.flush();
            outputStream.close();
            inputStream.close();
        } catch (IOException ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }

        Document document = new Document();
        document.setCreatetime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
        document.setName(originalFilename);
        document.setFid(fid);
        document.setType(Document.FILE_TYPE);
        document.setCreateuser(ShiroUtil.getRealName());
        document.setContexttype(contentType);
        document.setSize(FileUtils.byteCountToDisplaySize(size));
        //document.setMd5(md5);
        document.setFilename(newFileName);
        documentMapper.save(document);
    }

    public Document findDocumentById(Integer id) {
        return documentMapper.findDocumentById(id);
    }
}
