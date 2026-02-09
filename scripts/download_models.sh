#!/bin/bash

# Download Models Script for GPT-SoVITS
# Extracted and adapted from install.sh for modular usage (e.g. with uv)

RESET="\033[0m"
BOLD="\033[1m"
ERROR="\033[1;31m[ERROR]: $RESET"
WARNING="\033[1;33m[WARNING]: $RESET"
INFO="\033[1;32m[INFO]: $RESET"
SUCCESS="\033[1;34m[SUCCESS]: $RESET"

set -eE
set -o errtrace

trap 'on_error $LINENO "$BASH_COMMAND" $?' ERR

# Ensure we are in project root (assuming script is in scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
if [[ "$(basename "$SCRIPT_DIR")" == "scripts" ]]; then
    PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
    cd "$PROJECT_ROOT" || exit 1
fi

on_error() {
    local lineno="$1"
    local cmd="$2"
    local code="$3"
    echo -e "${ERROR}${BOLD}Command \"${cmd}\" Failed${RESET} at ${BOLD}Line ${lineno}${RESET} with Exit Code ${BOLD}${code}${RESET}"
    exit "$code"
}

run_download() {
    if command -v wget &> /dev/null; then
        wget --tries=5 --wait=5 --read-timeout=40 -q --show-progress "$@"
    elif command -v curl &> /dev/null; then
        # Basic argument parsing to support -O
        if [[ "$2" == "-O" ]]; then
            echo -e "Downloading $3..."
            curl -L --retry 5 --retry-delay 5 -o "$3" "$1"
        else
            echo -e "Downloading $(basename "$1")..."
            curl -L --retry 5 --retry-delay 5 -O "$1"
        fi
    else
        echo -e "${ERROR} Neither wget nor curl found. Please install one."
        exit 1
    fi
}

# Alias for compatibility with existing calls
run_wget_quiet() {
    run_download "$@"
}

USE_HF=false
USE_HF_MIRROR=false
USE_MODELSCOPE=false
DOWNLOAD_UVR5=false

print_help() {
    echo "Usage: bash download_models.sh --source <HF|HF-Mirror|ModelScope> [--download-uvr5]"
    echo ""
    echo "Options:"
    echo "  --source   HF|HF-Mirror|ModelScope     Specify the model source (REQUIRED)"
    echo "  --download-uvr5                        Enable downloading the UVR5 model"
    echo "  -h, --help                             Show this help message and exit"
}

if [[ $# -eq 0 ]]; then
    print_help
    exit 0
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
    --source)
        case "$2" in
        HF) USE_HF=true ;;
        HF-Mirror) USE_HF_MIRROR=true ;;
        ModelScope) USE_MODELSCOPE=true ;;
        *)
            echo -e "${ERROR}Error: Invalid Download Source: $2"
            echo -e "${ERROR}Choose From: [HF, HF-Mirror, ModelScope]"
            exit 1
            ;;
        esac
        shift 2
        ;;
    --download-uvr5)
        DOWNLOAD_UVR5=true
        shift
        ;;
    -h | --help)
        print_help
        exit 0
        ;;
    *)
        echo -e "${ERROR}Unknown Argument: $1"
        print_help
        exit 1
        ;;
    esac
done

if ! $USE_HF && ! $USE_HF_MIRROR && ! $USE_MODELSCOPE; then
    echo -e "${ERROR}Error: Download Source is REQUIRED"
    print_help
    exit 1
fi

if [ "$USE_HF" = "true" ]; then
    echo -e "${INFO}Download Model From HuggingFace"
    PRETRINED_URL="https://huggingface.co/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/pretrained_models.zip"
    G2PW_URL="https://huggingface.co/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/G2PWModel.zip"
    UVR5_URL="https://huggingface.co/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/uvr5_weights.zip"
    NLTK_URL="https://huggingface.co/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/nltk_data.zip"
    PYOPENJTALK_URL="https://huggingface.co/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/open_jtalk_dic_utf_8-1.11.tar.gz"
elif [ "$USE_HF_MIRROR" = "true" ]; then
    echo -e "${INFO}Download Model From HuggingFace-Mirror"
    PRETRINED_URL="https://hf-mirror.com/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/pretrained_models.zip"
    G2PW_URL="https://hf-mirror.com/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/G2PWModel.zip"
    UVR5_URL="https://hf-mirror.com/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/uvr5_weights.zip"
    NLTK_URL="https://hf-mirror.com/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/nltk_data.zip"
    PYOPENJTALK_URL="https://hf-mirror.com/XXXXRT/GPT-SoVITS-Pretrained/resolve/main/open_jtalk_dic_utf_8-1.11.tar.gz"
elif [ "$USE_MODELSCOPE" = "true" ]; then
    echo -e "${INFO}Download Model From ModelScope"
    PRETRINED_URL="https://www.modelscope.cn/models/XXXXRT/GPT-SoVITS-Pretrained/resolve/master/pretrained_models.zip"
    G2PW_URL="https://www.modelscope.cn/models/XXXXRT/GPT-SoVITS-Pretrained/resolve/master/G2PWModel.zip"
    UVR5_URL="https://www.modelscope.cn/models/XXXXRT/GPT-SoVITS-Pretrained/resolve/master/uvr5_weights.zip"
    NLTK_URL="https://www.modelscope.cn/models/XXXXRT/GPT-SoVITS-Pretrained/resolve/master/nltk_data.zip"
    PYOPENJTALK_URL="https://www.modelscope.cn/models/XXXXRT/GPT-SoVITS-Pretrained/resolve/master/open_jtalk_dic_utf_8-1.11.tar.gz"
fi

# Ensure unzip is available
if ! command -v unzip &> /dev/null; then
    echo -e "${ERROR} unzip is not installed. Please install it."
    exit 1
fi

if [ ! -d "GPT_SoVITS/pretrained_models/sv" ]; then
    echo -e "${INFO}Downloading Pretrained Models..."
    rm -rf pretrained_models.zip
    run_wget_quiet "$PRETRINED_URL"
    unzip -q -o pretrained_models.zip -d GPT_SoVITS
    rm -rf pretrained_models.zip
    echo -e "${SUCCESS}Pretrained Models Downloaded"
else
    echo -e "${INFO}Pretrained Model Exists"
fi

if [ ! -d "GPT_SoVITS/text/G2PWModel" ]; then
    echo -e "${INFO}Downloading G2PWModel.."
    rm -rf G2PWModel.zip
    run_wget_quiet "$G2PW_URL"
    unzip -q -o G2PWModel.zip -d GPT_SoVITS/text
    rm -rf G2PWModel.zip
    echo -e "${SUCCESS}G2PWModel Downloaded"
else
    echo -e "${INFO}G2PWModel Exists"
fi

if [ "$DOWNLOAD_UVR5" = "true" ]; then
    if find -L "tools/uvr5/uvr5_weights" -mindepth 1 ! -name '.gitignore' | grep -q .; then
        echo -e "${INFO}UVR5 Models Exists"
    else
        echo -e "${INFO}Downloading UVR5 Models..."
        rm -rf uvr5_weights.zip
        run_wget_quiet "$UVR5_URL"
        unzip -q -o uvr5_weights.zip -d tools/uvr5
        rm -rf uvr5_weights.zip
        echo -e "${SUCCESS}UVR5 Models Downloaded"
    fi
fi

echo -e "${INFO}Locating Python environment for NLTK and OpenJTalk data..."
# Use python from PATH (which should be uv's venv python if activated or run via uv run)
PY_PREFIX=$(python3 -c "import sys; print(sys.prefix)" 2>/dev/null || echo "")
if [ -z "$PY_PREFIX" ]; then
    echo -e "${WARNING} Could not determine Python prefix. Skipping NLTK/OpenJTalk data download to site-packages."
    echo -e "Please ensure you run this script within the python environment (e.g. 'uv run scripts/download_models.sh')."
else
    echo -e "${INFO} Python Prefix: $PY_PREFIX"
    
    echo -e "${INFO}Downloading NLTK Data..."
    rm -rf nltk_data.zip
    run_wget_quiet "$NLTK_URL" -O nltk_data.zip
    unzip -q -o nltk_data -d "$PY_PREFIX"
    rm -rf nltk_data.zip
    echo -e "${SUCCESS}NLTK Data Downloaded"

    echo -e "${INFO}Downloading Open JTalk Dict..."
    if python3 -c "import pyopenjtalk" &> /dev/null; then
        PYOPENJTALK_PREFIX=$(python3 -c "import os, pyopenjtalk; print(os.path.dirname(pyopenjtalk.__file__))")
        rm -rf open_jtalk_dic_utf_8-1.11.tar.gz
        run_wget_quiet "$PYOPENJTALK_URL" -O open_jtalk_dic_utf_8-1.11.tar.gz
        tar -xzf open_jtalk_dic_utf_8-1.11.tar.gz -C "$PYOPENJTALK_PREFIX"
        rm -rf open_jtalk_dic_utf_8-1.11.tar.gz
        echo -e "${SUCCESS}Open JTalk Dic Downloaded to $PYOPENJTALK_PREFIX"
    else
        echo -e "${WARNING} pyopenjtalk not found in current python environment. Skipping Dictionary download."
    fi
fi

echo -e "${SUCCESS}Model Download Completed"
