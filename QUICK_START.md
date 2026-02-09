# GPT-SoVITS Windows 11 部署 - 快速参考

## ⚡ 快速启动

### 方法 1: PowerShell 启动（推荐）
```powershell
.\launch_webui.ps1
```

### 方法 2: CMD 启动
```cmd
launch_webui.bat
```

### 方法 3: 手动启动
```powershell
# 激活虚拟环境
.\.venv\Scripts\Activate.ps1

# 启动Web UI
python webui.py
```

## 🖥️ 系统配置摘要

| 项目 | 配置 |
|-----|------|
| **电脑型号** | Lenovo 21D3S08801 |
| **CPU** | AMD Ryzen (~2701 MHz) |
| **内存** | 32 GB RAM |
| **操作系统** | Windows 11 Enterprise (Build 26100) |
| **Python** | 3.12.4 (项目环境: 3.11) |
| **Package Manager** | UV 0.9.0 |

## 📦 关键依赖版本

| 包名 | 版本 |
|-----|------|
| PyTorch | 2.10.0 (CPU) |
| ONNX Runtime | 1.24.1 GPU优化版 |
| Transformers | 4.50.0 |
| Gradio | 4.44.1 |
| FastAPI | 0.128.5 |
| Librosa | 0.10.2 |
| FunASR | 1.0.27 |
| Faster-Whisper | 1.2.1 |

## 🔧 常用命令

### 查看已安装包
```bash
uv pip list
```

### 安装新包
```bash
uv pip install package_name
```

### 升级包
```bash
uv pip install --upgrade package_name
```

### 查看虚拟环境状态
```bash
.\.venv\Scripts\python --version
```

### 运行推理脚本
```bash
# CLI 推理
python GPT_SoVITS/inference_cli.py

# 快速Web UI
python GPT_SoVITS/inference_webui_fast.py

# 标准Web UI
python webui.py
```

## 📖 文档文件

- **[DEPLOYMENT_REPORT.md](DEPLOYMENT_REPORT.md)** - 完整部署报告
- **[UV_GUIDE.md](UV_GUIDE.md)** - UV 包管理详细指南
- **[README.md](README.md)** - 项目主文档

## ✅ 验证清单

- ✅ 系统硬件检查完成
- ✅ Python 3.11 虚拟环境创建
- ✅ 207 个依赖包安装完毕
- ✅ ONNX Runtime GPU 优化版已安装
- ✅ 核心库导入验证通过
- ✅ Web UI 启动脚本就绪

## 🚀 下一步

1. **启动 Web UI**
   ```powershell
   .\launch_webui.ps1
   ```

2. **访问应用**
   - 打开浏览器访问 `http://localhost:7860`

3. **准备模型**
   - 下载或放置预训练模型到 `GPT_SoVITS/pretrained_models/`

4. **开始使用**
   - 上传音频文件进行推理

## ⚠️ 常见问题

### Q: 启动时提示"虚拟环境不存在"？
**A**: 虚拟环境已创建在 `.venv` 目录，脚本应该能自动激活。

### Q: 如何升级依赖？
**A**: 使用命令 `uv pip install --upgrade -r requirements.txt`

### Q: 可以使用 GPU 吗？
**A**: 当前安装了 CPU 版本。如有 NVIDIA GPU，可运行：
```bash
uv pip install torch torchcuda
```

### Q: 如何重新创建虚拟环境？
**A**: 
```powershell
Remove-Item -Recurse .venv
uv venv --python 3.11
uv pip install -r requirements.txt
```

## 📞 支持

如遇问题，请参考：
1. [DEPLOYMENT_REPORT.md](DEPLOYMENT_REPORT.md) 中的**故障排除**部分
2. [UV_GUIDE.md](UV_GUIDE.md) 中的**常见命令**
3. 项目原始 [README.md](README.md)

---

**部署日期**: 2026-02-09  
**状态**: ✅ 可用  
**最后更新**: 2026-02-09
