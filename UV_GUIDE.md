# UV 包管理配置指南

## 概述
本项目已配置使用 UV 作为包管理工具。UV 是一个现代化的 Python 包管理器，速度快、可靠性高。

## 快速开始

### 1. 虚拟环境激活

**PowerShell 方式**:
```powershell
.\.venv\Scripts\Activate.ps1
```

**CMD 方式**:
```cmd
.\.venv\Scripts\activate.bat
```

**快速启动脚本**（推荐）:
```powershell
# PowerShell
.\launch_webui.ps1

# CMD
launch_webui.bat
```

### 2. 安装依赖

所有依赖已安装在虚拟环境中，但如需更新：

```bash
# 安装所有主要依赖
uv pip install -r requirements.txt

# 安装额外依赖
uv pip install -r extra-req.txt

# 安装单个包
uv pip install package_name

# 升级包
uv pip install --upgrade package_name
```

### 3. 查看已安装的包

```bash
# 列出所有包
uv pip list

# 查看特定包的信息
uv pip show package_name

# 导出当前环境的依赖
uv pip freeze > requirements_current.txt
```

## 项目配置

### pyproject.toml 配置
项目使用现代的 `pyproject.toml` 配置：

```toml
[project]
name = "GPT-SoVITS"
requires-python = ">=3.9,<3.13"

[tool.setuptools]
packages = ["GPT_SoVITS"]
```

## 常见命令

### 虚拟环境管理

```bash
# 创建新的虚拟环境（使用 Python 3.11）
uv venv --python 3.11

# 删除虚拟环境
rm -r .venv  # PowerShell: Remove-Item -Recurse .venv
```

### 依赖管理

```bash
# 安装特定版本的包
uv pip install package_name==1.0.0

# 安装包的特定版本范围
uv pip install "package_name>=1.0,<2.0"

# 卸载包
uv pip uninstall package_name

# 检查过期的包
uv pip list --outdated
```

### 项目运行

```bash
# 激活环境后运行 Python 脚本
python GPT_SoVITS/inference_cli.py

# 运行 Web UI
python webui.py

# 运行快速推理
python GPT_SoVITS/inference_webui_fast.py
```

## 环境变量

如需自定义 Python 环境行为，可以设置：

```powershell
# PowerShell
$env:PYTHONPATH = "C:\Work\dev\GPT-SoVITS"
$env:CUDA_VISIBLE_DEVICES = "0"  # 如果有GPU

# CMD
set PYTHONPATH=C:\Work\dev\GPT-SoVITS
set CUDA_VISIBLE_DEVICES=0
```

## 故障排除

### 虚拟环境无法激活

```powershell
# 如果 PowerShell 提示执行策略问题，运行：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 包安装失败

```bash
# 清除 UV 缓存
uv cache prune

# 重新安装依赖
uv pip install --force-reinstall -r requirements.txt
```

### Python 版本不匹配

```bash
# 查看虚拟环境中的 Python 版本
.\.venv\Scripts\python --version

# 如需使用不同的 Python 版本，重新创建虚拟环境：
rm -r .venv
uv venv --python 3.10  # 或其他版本
```

## 更新项目依赖

当需要更新依赖版本时：

1. **编辑 `requirements.txt` 或 `extra-req.txt`**
2. **运行更新命令**:
   ```bash
   uv pip install -r requirements.txt --upgrade
   ```
3. **测试应用**确保兼容性
4. **生成锁定文件**（可选）:
   ```bash
   uv pip freeze > requirements_lock.txt
   ```

## 最佳实践

1. **始终使用虚拟环境** - 避免全局 Python 污染
2. **定期更新依赖** - 保持安全补丁最新
3. **使用具体版本号** - 在生产环境中锁定版本
4. **记录变更** - 当修改依赖时更新此文档
5. **定期清理缓存** - 使用 `uv cache prune` 释放空间

## 更多信息

- [UV 官方文档](https://docs.astral.sh/uv/)
- [项目部署报告](DEPLOYMENT_REPORT.md)
- [项目README](README.md)

---

最后更新: 2026-02-09
