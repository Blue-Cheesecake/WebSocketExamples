package com.sinut.springmessaging.messaging.controller;

import com.sinut.springmessaging.messaging.model.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import java.util.Objects;

@Controller
public class MessageController {

    @MessageMapping("/chat.send")
    @SendTo("/topic/public")
    public Message sendMessage(final Message message) {
        return message;
    }

    @MessageMapping("/chat.newUser")
    @SendTo("/topic/public")
    public Message newUser(final Message message, SimpMessageHeaderAccessor headerAccessor) {
        // someone joined!!
        Objects.requireNonNull(headerAccessor.getSessionAttributes()).put("username", message.getSender());
        return message;
    }
}
