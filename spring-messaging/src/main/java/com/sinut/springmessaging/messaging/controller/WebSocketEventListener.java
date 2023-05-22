package com.sinut.springmessaging.messaging.controller;

import com.sinut.springmessaging.messaging.model.Message;
import com.sinut.springmessaging.messaging.model.MessageType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.util.Objects;

@Component
@Slf4j
@RequiredArgsConstructor
public class WebSocketEventListener {

    private final SimpMessageSendingOperations sendingOperations;

    @EventListener
    public void handleWebSocketConnectListener(final SessionConnectedEvent event) {
        log.info("We have new connection!");
    }

    @EventListener
    public void handleWebSocketDisconnectListener(final SessionDisconnectEvent event) {
        final StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        final String username = (String) Objects.requireNonNull(headerAccessor.getSessionAttributes()).get("username");
        final Message message = Message
                .builder()
                .type(MessageType.DISCONNECT)
                .sender(username)
                .build();
        sendingOperations.convertAndSend("/topic/public", message);
        log.info("Someone disconnected...");
    }

}
