package com.forum.dao;

import com.forum.domain.Topic;

import java.util.List;

public interface TopicMapper {
    int insertTopic(Topic topic);
    List<Topic> listTopicsAndUsers(int index);
    List<Topic>  listMostCommentsTopics(int index);
    Topic selectById(int id);
    int clickAddOne(Integer id);
    int getTopicsNum();
    int updateTopic(Topic record);
}
