import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  constructor() {
    super();
    console.log('PrismaService constructor initialized');
  }

  async onModuleInit() {
    console.log('Connecting to Prisma...');
    await this.$connect();
    console.log('Prisma connected');
  }

  async onModuleDestroy() {
    console.log('Disconnecting Prisma...');
    await this.$disconnect();
    console.log('Prisma disconnected');
  }
}
