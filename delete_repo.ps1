# GitHub 仓库删除脚本
# 请将 YOUR_TOKEN_HERE 替换为您的 GitHub 个人访问令牌

$owner = "orangewoker"
$repo = "DoBao-TTS-Win"
$token = "YOUR_TOKEN_HERE"  # 替换为您的 GitHub 个人访问令牌

# GitHub API 端点
$apiUrl = "https://api.github.com/repos/$owner/$repo"

# 请求头
$headers = @{
    "Authorization" = "token $token"
    "Accept" = "application/vnd.github.v3+json"
}

# 发送 DELETE 请求
Write-Host "正在删除仓库: $owner/$repo" -ForegroundColor Yellow
$response = Invoke-RestMethod -Uri $apiUrl -Method Delete -Headers $headers

# 检查响应状态
if ($LASTEXITCODE -eq 0 -or $null -eq $response) {
    Write-Host "✓ 仓库 $owner/$repo 已成功删除!" -ForegroundColor Green
} else {
    Write-Host "✗ 删除失败: $response" -ForegroundColor Red
}
