package com.forum.service;

import com.forum.domain.Topic;

import java.util.List;

public interface TopicService {

    /**
     * 获取全部主题及用户信息 用于渲染首页
     */
    List<Topic> listTopicsAndUsers(int index);

    /**
     * 获取最多评论主题列表
     * @return
     */
    List<Topic> listMostCommentsTopics(int index);

    /**
     * 获取指定ID主题
     */
    Topic selectById(int id);

    /**
     * 新建主题
     */
    boolean addTopic(Topic topic);

    /**
     * 点击量加一
     */
    boolean clickAddOne(int id);

    /**
     * 获取主题总数
     */
    int getTopicsNum();

    boolean updateTopic(Topic topic);
}
