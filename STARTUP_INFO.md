# GPT-SoVITS Web UI 启动信息

## ✅ 服务启动成功！

### 🌐 访问地址
**http://localhost:7860**

### 📋 启动状态
- ✅ Python 虚拟环境已激活 (Python 3.11.13)
- ✅ 依赖包已加载 (183个包)
- ✅ Web UI 服务已启动
- ⏳ Gradio 界面加载中...

### 🔧 当前配置

| 项目 | 配置 |
|-----|------|
| **框架** | Gradio Web UI |
| **Python版本** | 3.11.13 |
| **PyTorch** | 2.10.0 |
| **ONNX Runtime** | 1.24.1 |
| **Transformers** | 4.50.0 |

### ⚠️ 重要说明

#### 缺少预训练模型
当前缺少以下模型文件：
- `GPT_SoVITS/pretrained_models/v2Pro/s2Gv2Pro.pth`
- `GPT_SoVITS/pretrained_models/v2Pro/s2Dv2Pro.pth`
- `GPT_SoVITS/pretrained_models/s1v3.ckpt`
- `GPT_SoVITS/pretrained_models/chinese-roberta-wwm-ext-large`
- `GPT_SoVITS/pretrained_models/chinese-hubert-base`

#### 下载模型
运行以下命令下载预训练模型：
```bash
.\.venv\Scripts\python GPT_SoVITS/download.py
```

或访问 [GPT-SoVITS Release Page](https://github.com/RVC-Boss/GPT-SoVITS/releases) 手动下载。

### 🎯 使用步骤

1. **启动Web UI** ✅ (已完成)
   ```bash
   python webui.py
   ```

2. **下载模型**
   ```bash
   python GPT_SoVITS/download.py
   ```

3. **上传参考音频** (在Web界面中)
   - 选择一个.wav或.mp3文件作为参考

4. **输入文本** (在Web界面中)
   - 输入想要合成的文本内容

5. **生成语音**
   - 点击生成按钮，等待合成完成

### 🚀 快速命令参考

**激活虚拟环境**
```bash
.\.venv\Scripts\Activate.ps1
```

**停止Web UI服务**
- 在终端中按 `Ctrl+C`

**查看日志**
- Web UI 会将日志输出到控制台

**重启服务**
```bash
.\.venv\Scripts\python webui.py
```

### 📞 故障排除

**如果Web界面无法访问**
1. 检查防火墙设置
2. 确认7860端口未被占用
3. 重启服务
4. 查看控制台错误信息

**如果模型加载失败**
1. 确保已下载所有模型文件
2. 检查模型文件路径
3. 参考项目文档下载最新模型

**如果出现Python导入错误**
1. 确认虚拟环境已激活
2. 重新安装依赖: `uv pip install -r requirements.txt`
3. 检查Python版本 (应为 3.11.13)

### 📚 相关文档

- [部署报告](DEPLOYMENT_REPORT.md)
- [快速开始](QUICK_START.md)
- [UV管理指南](UV_GUIDE.md)
- [项目README](README.md)

---

**启动时间**: 2026-02-09  
**Python版本**: 3.11.13  
**虚拟环境**: .venv  
**状态**: ✅ 运行中

现在打开浏览器访问 http://localhost:7860 开始使用！
