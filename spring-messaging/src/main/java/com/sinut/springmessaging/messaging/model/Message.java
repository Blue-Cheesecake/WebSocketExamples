package com.sinut.springmessaging.messaging.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Message {
    private MessageType type;
    private String body;
    private String sender;
    private String time;
}
