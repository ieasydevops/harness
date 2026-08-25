#!/usr/bin/env sh
set -eu

# Workflow 成功完成后的项目级扩展点。
#
# 项目可在下方加入重启服务、刷新生成物或发送本地通知等收尾命令。
# Hook 应保持非交互；任一命令失败时返回非零退出码，由 Workflow 报告失败，
# 但不回滚已经完成的 Phase。

# {{项目收尾命令；未配置时保持 no-op}}
exit 0
