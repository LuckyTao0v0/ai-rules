# AI Rules for Loon

这是一个由 GitHub Actions 自动维护的 Loon AI 分流规则订阅。当前聚合：OpenAI、Claude 和 Gemini。

## Loon 订阅地址

推送到 GitHub 后，在 Loon 的规则订阅中使用：

```text
https://raw.githubusercontent.com/LuckyTao0v0/ai-rules/main/Loon/AI.list
```

若默认分支仍是 `master`，将 URL 中的 `main` 改为 `master`。

## 部署

1. 将本目录中的所有文件上传到 `LuckyTao0v0/ai-rules` 仓库根目录。
2. 在仓库 **Settings → Actions → General → Workflow permissions** 选择 **Read and write permissions**，保存。
3. 打开仓库的 **Actions** 页，选择 **Sync AI rules**，点击 **Run workflow** 运行一次。

之后工作流每天自动检查上游；只有规则改变时才会创建提交。

## 更改规则集合

在 `sources.txt` 每行填一个 blackmatrix7 的 Loon `.list` 原始文件 URL。下次运行工作流时会自动下载、合并并去重。保留顺序以避免意外改变规则优先级。

## 来源与许可证

规则来源：[blackmatrix7/ios_rule_script](https://github.com/blackmatrix7/ios_rule_script)，其仓库采用 GPL-2.0 许可证。本仓库会保留来源说明；若公开发布，请在 GitHub 创建仓库时选择 GPL-2.0 许可证，或加入上游的完整 LICENSE 文本。
