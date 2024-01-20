import { Module } from '@nestjs/common';
import { MessagingModule } from './messaging/messaging.module';

@Module({
  imports: [MessagingModule],
  providers: [],
})
export class AppModule {}
