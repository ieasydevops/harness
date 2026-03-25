# Harness - AI Agent Workflow Framework

Harness 是一个用于 AI Agent 工作流管理的工程模板，支持多 Agent 协作、Skills 流程编排和上下文管理。

## 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/ieasydevops/harness.git
cd harness
```

### 2. 在 Cursor 中打开

1. 打开 Cursor
2. 选择 `File` → `Open Folder`
3. 选择 `harness` 项目目录

### 3. 配置 Cursor AI

在 Cursor 设置中配置以下选项：

#### 3.1 启用 .md 规则文件

Cursor 会自动读取项目根目录的 `CLAUDE.md` 和 `AGENTS.md` 文件，这些文件定义了：
- Agent 角色和职责
- Skills 流程和规范
- 项目约束和最佳实践

#### 3.2 配置 AI 行为（可选）

在 Cursor 设置中添加以下规则：

```
- 遵循 AGENTS.md 中定义的多 Agent 协作流程
- 执行任务前先读取对应的 Skill 定义文件
- 遵守 Phase 门禁 (GATE) 规则，需要确认时主动询问
- 使用结构化输出（表格、清单）进行任务交接
```

### 4. 项目结构说明

```
harness/
├── AGENTS.md                 # AI 知识库入口（必读）
├── CLAUDE.md                 # Cursor 规则引用
├── .harness/
│   ├── agents/               # Agent 角色定义
│   ├── skills/               # Skill 流程定义
│   ├── knowledge/            # 项目知识库
│   ├── prd/                  # 产品文档
│   ├── specs/                # 设计文档
│   └── plans/                # 实现计划
└── locals/                   # 本地配置（不入 git）
```

### 5. 常用操作

#### 启动新任务

在 Cursor Chat 中描述你的需求，例如：
- "添加一个新功能：用户登录模块"
- "治理代码，检查代码规范"
- "回填知识库，更新架构文档"

AI 会根据 `AGENTS.md` 中的规则自动路由到对应的 Skill 流程。

#### 查看 Skill 定义

所有 Skill 定义在 `.harness/skills/` 目录：
- `iterate-feature.md` - 功能迭代
- `verify-build.md` - 构建验证
- `governance-code.md` - 代码治理
- `backfill-knowledge.md` - 知识回填

#### 多 Agent 协作

项目支持两种运行模式：

| 模式 | 说明 | 适用场景 |
|------|------|----------|
| 单 Agent | 主 Agent 独立完成 | 简单任务、文档修改 |
| 多 Agent | Orchestrator + Reviewer 协作 | 功能开发、代码审查 |

### 6. 最佳实践

1. **任务开始前**：AI 会自动读取 `.harness/knowledge/` 了解项目全貌
2. **遵循流程**：严格按照 Skill 定义的 Phase 顺序执行
3. **GATE 确认**：遇到 `[GATE]` 标记时，必须等待用户确认
4. **上下文管理**：多步任务使用检查点摘要压缩上下文
5. **文档更新**：任务完成后更新 `specs/` 和 `plans/` 目录

### 7. Cursor 特定配置

#### 7.1 使用 @ 符号引用文件

在 Cursor Chat 中，使用 `@` 可以快速引用项目文件：
- `@AGENTS.md` - 查看任务路由规则
- `@.harness/skills/iterate-feature.md` - 查看功能迭代流程

#### 7.2 使用 Composer 功能

对于多文件修改，使用 Cursor 的 Composer 功能：
1. 按 `Cmd+I` (Mac) 或 `Ctrl+I` (Windows) 打开 Composer
2. 描述修改需求
3. AI 会自动分析相关文件并生成修改

#### 7.3 终端集成

Cursor 内置终端可直接执行命令：
```bash
# 查看 Skill 列表
ls .harness/skills/

# 查看当前任务计划
cat .harness/plans/active/plan-*.md
```

### 8. 故障排查

| 问题 | 解决方案 |
|------|----------|
| AI 不遵循流程 | 提醒 AI 读取 `AGENTS.md` 和对应 Skill 文件 |
| 上下文超限 | 使用检查点摘要压缩，或拆分任务 |
| 文件找不到 | 检查 `.harness/` 目录结构是否完整 |

### 9. 学习资源

- `AGENTS.md` - 完整流程和规范
- `.harness/knowledge/` - 项目知识库
- `.harness/guides/` - 方法论和操作指南

---

**版本**: 1.0  
**最后更新**: 2026-03-25
