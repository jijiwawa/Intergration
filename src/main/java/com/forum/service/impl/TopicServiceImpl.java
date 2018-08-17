package com.forum.service.impl;

import com.forum.dao.TopicMapper;
import com.forum.domain.Topic;
import com.forum.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class TopicServiceImpl implements TopicService {

    @Autowired
    public TopicMapper topicDao;

    public List<Topic> listTopicsAndUsers(int index) {
        return topicDao.listTopicsAndUsers(index);
    }

    public List<Topic> listMostCommentsTopics() {
        return topicDao.listMostCommentsTopics();
    }

    public Topic selectById(int id) {
        return topicDao.selectById(id);
    }

    public boolean addTopic(Topic topic) {
        return topicDao.insertTopic(topic)>0;
    }

    public boolean clickAddOne(int id) {
        return topicDao.clickAddOne(id)>0;
    }

    public int getTopicsNum() {
        return topicDao.getTopicsNum();
    }

    public boolean updateTopic(Topic topic) {
        return topicDao.updateTopic(topic)>0;
    }
}
