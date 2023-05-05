package com.sinut.springmessaging.controller;

import com.sinut.springmessaging.model.HelloMessage;
import com.sinut.springmessaging.model.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

// Create a Message-handling Controller

@Controller
public class MessageController {

    @MessageMapping("/hello")
    @SendTo("/topic/messages")
    public Message message(HelloMessage helloMessage) throws Exception {
        Thread.sleep(1000);
        return new Message("Hello, " + helloMessage.getName() + " !");
    }
}
