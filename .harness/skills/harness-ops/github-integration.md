# Skill: GitHub 集成

**触发**: 用户提到 GitHub、仓库、PR、Issue、CI/CD、推送代码、拉取代码等

**职责**: 使用 gh CLI 和 git 命令与 GitHub 交互，管理仓库、PR、Issue、Actions 等

---

## 前置条件

### 1. 环境检查

```bash
# 检查 gh CLI 是否安装
which gh

# 检查 git 是否安装
which git
```

### 2. SSH 认证配置

**生成 SSH Key**（如未配置）:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519 -N ""
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

**添加到 ssh-agent**:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**配置 SSH**（如端口 22 被阻止）:
```bash
cat >> ~/.ssh/config << 'EOF'

Host github.com
    HostName ssh.github.com
    Port 443
    User git
EOF
```

**添加公钥到 GitHub**:
1. 复制 `~/.ssh/id_ed25519.pub` 内容
2. GitHub → Settings → SSH and GPG keys → New SSH key
3. 粘贴公钥，保存

---

## 核心命令

### 仓库操作

```bash
# 查看仓库信息
gh repo view owner/repo --json name,description,updatedAt

# 克隆仓库
git clone git@github.com:owner/repo.git

# 创建新仓库
gh repo create owner/new-repo --public --source=. --push

# 推送代码
git add .
git commit -m "feat: 描述"
git push origin main
```

### Pull Requests

```bash
# 列出 PR
gh pr list --repo owner/repo --limit 10

# 查看 PR 详情
gh pr view <pr-number> --repo owner/repo

# 查看 CI 状态
gh pr checks <pr-number> --repo owner/repo

# 创建 PR
gh pr create --title "标题" --body "描述" --base main

# 合并 PR
gh pr merge <pr-number> --merge --delete-branch
```

### Issues

```bash
# 列出 Issue
gh issue list --repo owner/repo --limit 10

# 查看 Issue 详情
gh issue view <issue-number> --repo owner/repo

# 创建 Issue
gh issue create --title "标题" --body "描述"

# 关闭 Issue
gh issue close <issue-number>
```

### Actions (CI/CD)

```bash
# 列出工作流运行
gh run list --repo owner/repo --limit 10

# 查看运行详情
gh run view <run-id> --repo owner/repo

# 查看失败日志
gh run view <run-id> --repo owner/repo --log-failed

# 重新运行
gh run rerun <run-id> --repo owner/repo

# 查看工作流列表
gh workflow list --repo owner/repo
```

### API 高级查询

```bash
# 获取 PR 特定字段
gh api repos/owner/repo/pulls/<number> --jq '.title, .state, .user.login'

# 获取仓库信息
gh api repos/owner/repo --jq '.name, .stargazers_count, .forks_count'

# 列出分支
gh api repos/owner/repo/branches --jq '.[].name'
```

---

## 标准流程

### 流程 1: 推送代码到 GitHub

1. **检查本地变更**
   ```bash
   git status
   git diff
   ```

2. **提交变更**
   ```bash
   git add .
   git commit -m "描述"
   ```

3. **推送**
   ```bash
   git push origin main
   ```

4. **验证**
   ```bash
   gh repo view owner/repo
   ```

### 流程 2: 创建 PR

1. **创建分支**
   ```bash
   git checkout -b feature/xxx
   ```

2. **提交并推送**
   ```bash
   git add .
   git commit -m "feat: xxx"
   git push -u origin feature/xxx
   ```

3. **创建 PR**
   ```bash
   gh pr create --title "feat: xxx" --body "## 变更内容\n- 功能 1\n- 功能 2" --base main
   ```

4. **监控 CI**
   ```bash
   gh pr checks --watch
   ```

### 流程 3: 备份代码到知识库

1. **克隆/更新本地副本**
   ```bash
   cd /path/to/backup-repo
   git pull origin main
   ```

2. **复制新内容**
   ```bash
   cp -r /source/path/* /path/to/backup-repo/daily/$(date +%Y-%m-%d)/
   ```

3. **提交并推送**
   ```bash
   git add .
   git commit -m "backup: $(date +%Y-%m-%d) 技能进化备份"
   git push origin main
   ```

---

## 错误处理

| 错误 | 原因 | 解决方案 |
|------|------|----------|
| `gh: command not found` | 未安装 gh CLI | 从 https://cli.github.com 安装 |
| `Permission denied (publickey)` | SSH Key 未配置 | 重新生成并添加公钥到 GitHub |
| `Connection timed out port 22` | 防火墙阻止 | 使用端口 443 配置（见前置条件） |
| `Could not read from remote repository` | 认证失败 | 检查 SSH Key 和权限 |
| `Everything up-to-date` 但 GitHub 无更新 | 推送到错误分支 | 检查 `git branch` 和 `git remote -v` |

---

## 最佳实践

1. **使用 SSH 而非 HTTPS** - 避免每次输入密码
2. **配置端口 443** - 绕过防火墙限制
3. **使用 `--json` 和 `--jq`** - 获取结构化数据
4. **定期备份** - 重要代码及时推送到远程
5. **PR 描述清晰** - 包含变更内容、测试方法、影响范围

---

## 相关文档

- AGENTS.md - 任务路由规则
- .harness/knowledge/22-file-map.md - 文件映射
- .harness/skills/harness-ops/governance-code.md - 代码治理

---

**版本**: 1.0  
**创建**: 2026-03-25  
**最后更新**: 2026-03-25
