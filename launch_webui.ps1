#!/usr/bin/env pwsh

# GPT-SoVITS Windows 11 快速启动脚本 (PowerShell)
# 此脚本自动激活虚拟环境并启动WebUI

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "         GPT-SoVITS Windows 11 部署包" -ForegroundColor Green -NoNewline
Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""

# 检查虚拟环境是否存在
if (-not (Test-Path ".venv")) {
    Write-Host "❌ 错误: 虚拟环境不存在" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先运行以下命令创建虚拟环境:" -ForegroundColor Yellow
    Write-Host "  uv venv --python 3.11" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "按 Enter 键退出"
    exit 1
}

# 激活虚拟环境
& .\.venv\Scripts\Activate.ps1

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 虚拟环境激活失败" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}

Write-Host "✅ 虚拟环境已激活" -ForegroundColor Green
Write-Host ""
Write-Host "正在启动Web UI..." -ForegroundColor Green
Write-Host ""
Write-Host "访问地址: http://localhost:7860" -ForegroundColor Cyan
Write-Host ""
Write-Host "按 Ctrl+C 停止服务器" -ForegroundColor Yellow
Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""

# 启动WebUI
python webui.py

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ WebUI 启动失败" -ForegroundColor Red
    Write-Host ""
    Write-Host "如有问题，请查看错误信息或参考 DEPLOYMENT_REPORT.md" -ForegroundColor Yellow
    Write-Host ""
}

Read-Host "按 Enter 键退出"
