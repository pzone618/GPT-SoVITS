# GPT-SoVITS Windows 11 部署报告

## 系统配置信息

### 硬件配置
- **电脑型号**: Lenovo 21D3S08801
- **处理器**: AMD Ryzen (Family 25 Model 68) @ ~2701 MHz
- **物理内存**: 32,020 MB (总计)
- **可用内存**: 10,132 MB (当前可用)
- **系统类型**: x64-based PC

### 操作系统
- **OS**: Microsoft Windows 11 Enterprise
- **版本**: 10.0.26100 (Build 26100)
- **时区**: (UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi

### 虚拟化与安全
- **Hyper-V**: 已启用
- **虚拟化安全**: 运行中
- **SMM隔离级别**: 30

### 网络适配器
- **WiFi**: Qualcomm FastConnect 6900 (已连接)
- **有线网络**: 已断开连接
- **DHCP启用**: 是
- **IP地址**: 9.110.210.74

### GPU配置
- **NVIDIA GPU**: 未安装
- **使用**: CPU 计算 (通过 onnxruntime-gpu for x86_64)

---

## Python 环境配置

### Python 版本
- **Python版本**: 3.12.4
- **项目目标版本**: 3.11 (虚拟环境)
- **项目基础版本要求**: >= 3.9, < 3.13

### 包管理工具
- **UV版本**: 0.9.0 (39b688653 2025-10-07)
- **pip版本**: 25.2

---

## 项目部署步骤

### 1. 虚拟环境配置
✅ 使用UV创建Python 3.11虚拟环境
```bash
uv venv --python 3.11
```
- 虚拟环境位置: `.venv`
- 激活命令: `.venv\Scripts\activate.ps1`

### 2. pyproject.toml 改进
✅ 创建了现代化的 pyproject.toml 配置
- 使用 setuptools 作为构建后端
- 指定了GPT_SoVITS包的配置
- 添加了可选的dev依赖组
- 包含了所有关键项目元数据

### 3. 依赖安装

#### 主要依赖 (requirements.txt)
✅ 已安装 181 个包，包括：

**核心包**:
- numpy 1.26.4
- scipy 1.17.0
- tensorboard 2.20.0
- librosa 0.10.2
- numba 0.63.1

**深度学习框架**:
- torch 2.10.0
- torchaudio 2.10.0
- pytorch-lightning 2.6.1
- peft 0.17.1 (< 0.18.0)
- torchmetrics 1.5.0
- transformers 4.50.0

**本地推理引擎**:
- onnxruntime-gpu 1.24.1 (x86_64 优化版本)
- onnxruntime 1.24.1

**音频和ASR**:
- librosa 0.10.2
- av 16.1.0
- faster-whisper 1.2.1
- funasr 1.0.27
- pyopenjtalk 0.4.1

**Web框架**:
- fastapi 0.128.5
- fastapi[standard] >= 0.115.2
- gradio 4.44.1
- uvicorn 0.40.0

**自然语言处理**:
- transformers 4.50.0
- peft 0.17.1
- tokenizers 0.21.4
- sentencepiece 0.2.1
- g2p-en 2.1.0
- jieba 0.42.1
- jieba-fast 0.53

**多语言支持**:
- cn2an 0.5.23
- pypinyin 0.55.0
- split-lang 2.1.1
- fast-langdetect 1.0.0
- opencc 1.2.0
- tojyutping 3.2.0
- g2pk2 0.0.3
- ko-pron 1.3

**其他关键包**:
- pydantic 2.10.6 (<= 2.10.6)
- PyYAML 6.0.3
- psutil 7.2.2
- ctranslate2 4.7.1
- modelscope 1.34.0

#### 额外依赖 (extra-req.txt)
✅ 已安装 24 个额外包：
- faster-whisper 1.2.1
- onnxruntime 1.24.1

### 4. 安装验证
✅ 总共安装 207 个包
✅ 所有关键依赖已正确安装
✅ 支持 GPU 加速 (onnxruntime-gpu x86_64版本)

---

## 项目启动命令

### 激活虚拟环境
```powershell
.\.venv\Scripts\activate.ps1
```

### Web UI 启动
```bash
python webui.py
```

### 命令行推理
```bash
python GPT_SoVITS/inference_cli.py
```

### 快速推理
```bash
python GPT_SoVITS/inference_webui_fast.py
```

### Gradio Web UI (标准)
```bash
python GPT_SoVITS/inference_webui.py
```

---

## 系统性能预期

### 优势
1. **32GB 内存**: 足以支持中等规模的模型训练和推理
2. **GPU 加速**: 通过 onnxruntime-gpu 进行优化的 x86_64 计算
3. **现代CPU**: AMD Ryzen 处理器具有良好的多核性能
4. **64位系统**: 完全支持所有现代深度学习框架

### 建议
1. **模型大小**: 建议使用中等规模的预训练模型 (< 4GB)
2. **批处理大小**: 推荐使用较小的批处理以优化内存使用
3. **并发任务**: 建议限制并发推理任务数量以避免OOM
4. **磁盘空间**: 确保有足够的磁盘空间存储模型和中间结果

---

## 故障排除

### 如果遇到导入错误
1. 确保虚拟环境已激活
2. 运行 `uv pip list` 验证包是否已安装
3. 检查 Python 版本: `python --version`

### 如果模型加载失败
1. 检查磁盘空间: `dir C:\` 
2. 检查内存使用: `Get-Process | Sort-Object -Descending -Property WS | Select-Object -First 10`
3. 尝试使用更小的模型

### 如果ONNX Runtime出现问题
1. 验证安装: `python -c "import onnxruntime; print(onnxruntime.get_available_providers())"`
2. 如果需要CPU版本: `uv pip install onnxruntime`

---

## 重要文件位置

- 项目根目录: `C:\Work\dev\GPT-SoVITS`
- 虚拟环境: `C:\Work\dev\GPT-SoVITS\.venv`
- 配置文件: `pyproject.toml`
- 依赖文件: `requirements.txt`, `extra-req.txt`
- Web UI: `webui.py`
- 推理脚本: `GPT_SoVITS/inference_*.py`

---

## 部署日期
**2026-02-09**

## 部署状态
✅ **部署成功**

所有依赖已正确安装，项目可以开始使用。

