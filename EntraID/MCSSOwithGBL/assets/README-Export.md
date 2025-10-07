# 架构图导出指南 / Architecture Diagram Export Guide

## 中文说明

### 导出步骤
1. 使用 VS Code 安装 Draw.io Integration 插件
2. 打开对应的 .drawio 文件：
   - `upstream-view.drawio` - Mooncake作为IdP的架构图
   - `downstream-view.drawio` - Global作为IdP的架构图  
   - `cross-cloud-sso.drawio` - 整体跨云架构概览

3. 在 Draw.io 中选择 File > Export as > PNG
4. 设置导出参数：
   - 分辨率：300 DPI (高质量)
   - 背景：透明或白色
   - 边框宽度：10px
   - 文件名对应架构图类型

5. 将导出的 PNG 文件保存到 `./assets/` 目录下

### 预期文件列表
- `upstream-view.png` - Upstream场景架构图
- `downstream-view.png` - Downstream场景架构图
- `cross-cloud-sso.png` - 跨云SSO总览图

---

## English Instructions

### Export Steps
1. Install Draw.io Integration extension in VS Code
2. Open corresponding .drawio files:
   - `upstream-view.drawio` - Architecture with Mooncake as IdP
   - `downstream-view.drawio` - Architecture with Global as IdP
   - `cross-cloud-sso.drawio` - Overall cross-cloud architecture overview

3. In Draw.io, select File > Export as > PNG
4. Configure export parameters:
   - Resolution: 300 DPI (high quality)
   - Background: Transparent or white
   - Border width: 10px
   - Filename corresponding to architecture type

5. Save exported PNG files to `./assets/` directory

### Expected File List
- `upstream-view.png` - Upstream scenario architecture
- `downstream-view.png` - Downstream scenario architecture  
- `cross-cloud-sso.png` - Cross-cloud SSO overview

---

## 命令行导出 / Command Line Export

如果安装了 draw.io desktop 应用，可以使用命令行导出：

```bash
# Windows
drawio.exe --export --format png --output ./assets/upstream-view.png ./assets/upstream-view.drawio
drawio.exe --export --format png --output ./assets/downstream-view.png ./assets/downstream-view.drawio
drawio.exe --export --format png --output ./assets/cross-cloud-sso.png ./assets/cross-cloud-sso.drawio

# macOS/Linux
drawio --export --format png --output ./assets/upstream-view.png ./assets/upstream-view.drawio
drawio --export --format png --output ./assets/downstream-view.png ./assets/downstream-view.drawio
drawio --export --format png --output ./assets/cross-cloud-sso.png ./assets/cross-cloud-sso.drawio
```

## 在线导出 / Online Export

1. 访问 https://app.diagrams.net
2. 打开对应的 .drawio 文件
3. File > Export as > PNG
4. 下载并保存到相应目录