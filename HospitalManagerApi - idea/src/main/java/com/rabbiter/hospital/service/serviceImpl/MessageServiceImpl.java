package com.rabbiter.hospital.service.serviceImpl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.rabbiter.hospital.mapper.MessageMapper;
import com.rabbiter.hospital.pojo.Message;
import com.rabbiter.hospital.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 作者： Administrator
 * 日期: 2024/12/20/020
 * Description :
 */
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    MessageMapper mapper;

    @Override
    public int sendMessage(Message message) {
        return mapper.insert(message);

    }

    @Override
    public List<Message> getMessages() {
        QueryWrapper<Message> wrapper = new QueryWrapper<>();
        wrapper.eq("has_read",0);
        return mapper.selectList(wrapper);
    }

    @Override
    public int updateMessage(Boolean hasRead) {

        UpdateWrapper wrapper =new UpdateWrapper();
        wrapper.set("has_read",hasRead);
        return mapper.update(null,wrapper);
    }
}
