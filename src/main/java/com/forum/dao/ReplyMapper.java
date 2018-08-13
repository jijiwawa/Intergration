package com.forum.dao;

import com.forum.domain.Reply;

import java.util.List;

public interface ReplyMapper {
    int insert(Reply record);
    List<Reply> getRepliesOfTopic(Integer topicId);
    int getRepliesNum(Integer topicId);
}
