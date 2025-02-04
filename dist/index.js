"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SharedPrismaModule = exports.PrismaService = void 0;
// src/index.ts
var prisma_service_1 = require("./prisma.service"); // Adjust to your file structure
Object.defineProperty(exports, "PrismaService", { enumerable: true, get: function () { return prisma_service_1.PrismaService; } });
var prisma_module_1 = require("./prisma.module"); // If you want to export the module
Object.defineProperty(exports, "SharedPrismaModule", { enumerable: true, get: function () { return prisma_module_1.SharedPrismaModule; } });
