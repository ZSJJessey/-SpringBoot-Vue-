package com.rabbiter.hospital.service;

import com.rabbiter.hospital.pojo.Message;

import java.util.List;

public interface MessageService {

    int sendMessage(Message message);

    List<Message> getMessages();

   int updateMessage(Boolean hasRead);
}
