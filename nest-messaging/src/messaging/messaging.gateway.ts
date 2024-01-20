import { SubscribeMessage, WebSocketGateway } from '@nestjs/websockets';

@WebSocketGateway({ namespace: 'message-event' })
export class MessagingGateway {
  @SubscribeMessage('message-event')
  handleMessage(client: any, payload: any): string {
    return 'Hello world!';
  }
}
