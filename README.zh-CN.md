# forza-painter FH6

[English](README.md) | [中文](README.zh-CN.md)

把图片转换成 Forza Horizon 6 的 Vinyl Group 图层。

这个软件主要做两件事：

- 把 PNG/JPG/BMP 图片生成 geometry JSON。
- 把 JSON 导入到当前打开的 FH6 Vinyl Group Editor。

生成 JSON 使用 GPU/OpenCL 版 geometrize 生成器。请保持显卡驱动正常；如果生成器提示 OpenCL 错误，优先修显卡驱动。

正常使用不需要手动填写内存地址。FH6 只需要填写模板层数，软件会自动查找当前可编辑的图层组。

## 下载后怎么安装

1. 下载本仓库 ZIP，并解压。
2. 安装 64 位 Python。推荐使用 Python 3.12。
3. 打开解压后的文件夹。
4. 双击 `install_dependencies.bat`。
5. 双击 `start_app.bat`。

Python 程序只需要 `psutil` 和 `pywin32`。图片/JSON 预览需要可选的 NumPy/OpenCV，安装脚本会在容易冲突的 Python 版本上自动跳过预览依赖。

## 生成 JSON

1. 打开 `start_app.bat`。
2. 进入 `Generate JSON` 页面。
3. 添加 PNG/JPG/BMP 图片。
4. 选择品质配置。
5. 可选：开启自定义参数，修改输出层数、分辨率或样本数。
6. 点击 `Start generating`。
7. 等待生成 `.json` 文件。

快的品质配置生成更快，但画面更粗糙。慢的配置耗时更长，通常效果更好。
自定义参数只会覆盖本次运行的预设，不需要手动编辑配置文件。

生成的文件会保存在原图片旁边，例如 `image.1000.json`。

## 准备 FH6

1. 启动 Forza Horizon 6。
2. 进入 `Create Vinyl Group` / `Vinyl Group Editor`。
3. 加载或创建一个由大量简单 sphere 图层组成的模板。
4. 把模板 `Ungroup`。
5. 记住游戏里显示的真实层数。
6. 导入时保持这个编辑器打开，不要切换菜单。

推荐模板大小：500 到 3000 层。

## 导入 JSON

1. 进入软件的 `Import` 页面。
2. 点击 `Refresh`，选择正在运行的 `forzahorizon6.exe` 进程。
3. 填写游戏里的真实模板层数。
4. 添加生成好的 `.json`，或者点击 `Use generated JSON`。
5. 高级地址输入框保持空白。
6. 点击 `Import JSON`。

软件会先定位并验证 FH6 图层表，确认安全后才写入。如果无法安全确认目标，软件会在写入前停止。

## 必须注意

- 模板必须已经 Ungroup。
- 软件里的层数必须和游戏里的层数完全一致。
- 导入过程中不要切换菜单。
- 如果重启游戏、重新加载模板、改变模板层数，请用新的正确层数重新导入。
- 如果 JSON 比模板小，未使用的模板层会被隐藏。
- 如果 JSON 比模板大，超出的图形会被裁剪。

## 环境问题修复

### `_ARRAY_API not found`、NumPy 或 OpenCV 报错

这是预览依赖问题，不是仓库少文件。

FH6 导入可以不依赖预览继续使用。先重新安装核心依赖：

```powershell
python -m pip uninstall -y numpy opencv-python
python -m pip install -r requirements.txt
```

如果需要内置预览，请使用 Python 3.12，再安装可选预览依赖：

```powershell
py -3.12 -m pip install -r requirements.txt
py -3.12 -m pip install -r requirements-preview.txt
```

如果你正在用 Python 3.14，并且依赖安装失败，请安装 Python 3.12 后重新运行 `install_dependencies.bat`。

### 检查依赖是否正常

在软件文件夹里运行：

```powershell
check_environment.bat
```

出现 `Core OK` 说明 Python 程序依赖正常。出现 `Preview is unavailable` 只代表当前 Python 环境不能显示内置预览，不影响生成 JSON 或导入 FH6。

### GPU 生成器或 OpenCL 报错

更新 NVIDIA/AMD/Intel 显卡驱动。仓库自带的生成器是 `forza-painter-geometrize-go.exe`，它使用 OpenCL，不依赖 Python 的 NumPy/OpenCV。

### 权限错误或 `OpenProcess` 失败

关闭软件，用管理员身份运行 `start_app.bat`。

生成 JSON 不需要管理员权限，但导入 FH6 通常需要。

### 找不到游戏进程

确认 FH6 已经启动。点击软件里的 `Refresh`。如果还是没有，先打开游戏，再重启软件。

### 定位不到安全模板

检查：

- 你在 Vinyl Group Editor，不是在车身涂装或车辆编辑页面。
- 模板已经 Ungroup。
- 层数填写完全正确。
- 填写层数后没有切换菜单。

### 导入效果被截断

模板层数不够。请使用更大的模板，或者用更快/更低质量的配置重新生成 JSON。

## 用户需要打开哪些文件

- `install_dependencies.bat`：安装依赖。
- `check_environment.bat`：检查核心环境是否正常。
- `clean_runtime_data.bat`：发布或重新压缩前清理运行缓存。
- `start_app.bat`：启动软件。
- `1. drag_image_file_here.bat`：可选，把图片拖到这里打开软件。

普通用户不需要直接打开 Python 文件。
