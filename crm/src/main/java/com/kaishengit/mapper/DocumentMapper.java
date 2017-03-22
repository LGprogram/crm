package com.kaishengit.mapper;

import com.kaishengit.pojo.Document;

import java.util.List;

/**
 * Created by liu on 2017/3/18.
 */
public interface DocumentMapper {
    List<Document> findAll(Integer fid);

    void save(Document document);

    Document findDocumentById(Integer id);
}
