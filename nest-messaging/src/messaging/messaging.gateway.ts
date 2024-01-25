import {
  MessageBody,
  OnGatewayConnection,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server } from 'socket.io';

@WebSocketGateway()
export class MessagingGateway implements OnGatewayConnection {
  @WebSocketServer()
  server: Server;

  numConnection: number = 0;

  // Emit the message immediately when connection is made
  handleConnection(client: any, ...args: any[]) {
    console.log('Connected (GatewatConnection)');
    this.numConnection++;
    let counter = 0;
    setInterval(() => {
      this.server.emit('onMessage', {
        counter: counter,
        numConnection: this.numConnection,
      });
      counter++;
    }, 1500);
  }

  // handle the message from client
  @SubscribeMessage('message-event')
  handleMessage(@MessageBody() data: any) {
    console.log(data);
    return 'Hello world!';
  }
}
