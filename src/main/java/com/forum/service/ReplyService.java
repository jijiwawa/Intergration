package com.forum.service;

import com.forum.domain.Reply;

import java.util.List;

public interface ReplyService {
    List<Reply> getRepliesOfTopic(Integer topicId);

    boolean addReply(Reply reply);

    int repliesNum(Integer topicId);
}
