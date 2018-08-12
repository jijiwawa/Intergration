package com.forum.dao;

import com.forum.domain.Topic;

import java.util.List;

public interface TopicMapper {
    int insertTopic(Topic topic);
    List<Topic> listTopicsAndUsers();
    List<Topic>  listMostCommentsTopics();
    Topic selectById(int id);
    int clickAddOne(Integer id);
    int getTopicsNum();
    int updateTopic(Topic record);
}
