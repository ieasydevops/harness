# 约定与约束（实现细节）

本文件是项目规范约定的权威来源，AGENTS.md "二、项目规范"各节为摘要引用，以本文件为准。

---

# 一、UI交互约定

{{UI_INTERACTION_CONVENTIONS}}

---

# 二、编码约定

{{CODING_CONVENTIONS}}

示例章节结构：
## 图片/媒体处理
## 数据格式
## 本地化
## 常量管理

---

# 三、质量约定

## 编译

零警告，提交前构建验证。构建命令：{{BUILD_COMMAND}}

## 错误处理

- 用户：自然语言，无技术细节
- 开发：统一日志框架含错误码，禁止完整密钥
- 异步错误切回主线程再更新 UI
- 超时：必须设超时，不允许无超时

## 日志

{{LOGGING_CONVENTIONS}}

## 线程与并发

- UI 更新主线程；IO 密集操作后台线程，完成后切回主线程
- 取消机制

## 内存与性能

{{MEMORY_AND_PERFORMANCE_RULES}}

## 单元测试

- 新增/修改核心模块时同步补充
- 外部依赖协议注入 Mock

---

# 四、文件管理约定

- 禁止主动创建 README
- 不删除项目文件（临时 spec 除外）
- 文件名：小写英文 kebab-case，动词-名词语序
- 临时 spec 落盘到 `.harness/context/agents/agent-specs-${事项}.md`

---

# 五、安全约定

{{SECURITY_CONVENTIONS}}
