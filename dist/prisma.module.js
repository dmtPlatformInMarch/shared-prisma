"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SharedPrismaModule = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("./prisma.service");
@(0, common_1.Module)({
    providers: [prisma_service_1.PrismaService],
    exports: [prisma_service_1.PrismaService],
})
class SharedPrismaModule {
}
exports.SharedPrismaModule = SharedPrismaModule;
