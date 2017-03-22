package com.kaishengit.mapper;

import com.kaishengit.pojo.Notice;
import com.kaishengit.pojo.NoticeView;

import java.util.List;
import java.util.Map;

/**
 * Created by liu on 2017/3/19.
 */
public interface NoticeMapper {

    List<Notice> findByParam(Map<String, Object> param);

    Long count();

    void save(Notice notice);

    Notice findById(Integer noticeId);

    void saveNoticeView(NoticeView noticeView);

    List<NoticeView> findNoticeViews(Integer noticeId);

    NoticeView findNoticeViewByNoticeId(Integer noticeId);
}
