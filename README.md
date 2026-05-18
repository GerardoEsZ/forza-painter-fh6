# forza-painter FH6

[English](README.md) | [中文](README.zh-CN.md)

Convert images into Forza Horizon 6 Vinyl Group layers.

This app has two jobs:

- Generate a geometry JSON file from a PNG/JPG/BMP image.
- Import that JSON into the currently open FH6 Vinyl Group Editor.

JSON generation uses the GPU/OpenCL geometrize generator. Keep your graphics driver updated; if the generator reports an OpenCL error, fix the GPU driver first.

You do not need to type memory addresses during normal use. For FH6, enter the template layer count and the app will locate the current editable layer group automatically.

## Download And Setup

1. Download this repository as a ZIP and extract it.
2. Install 64-bit Python. Python 3.12 is recommended.
3. Open the extracted folder.
4. Double-click `install_dependencies.bat`.
5. Double-click `start_app.bat`.

The Python app only needs `psutil` and `pywin32`. Image/JSON preview uses optional NumPy/OpenCV packages and is skipped automatically on Python versions where those packages are likely to conflict.

## Generate JSON

1. Open `start_app.bat`.
2. Go to `Generate JSON`.
3. Add a PNG/JPG/BMP image.
4. Choose a quality profile.
5. Optional: enable custom settings if you want to change output layers, resolution, or sample counts.
6. Click `Start generating`.
7. Wait until a `.json` file is generated.

Fast quality profiles finish faster but look rougher. Slow profiles take longer and usually look better.
Custom settings override the selected profile only for the current run.

Generated files are saved next to the source image, for example `image.1000.json`.

## Prepare FH6

1. Start Forza Horizon 6.
2. Open `Create Vinyl Group` / `Vinyl Group Editor`.
3. Load or create a template made from many simple sphere layers.
4. Ungroup the template.
5. Remember the exact layer count shown in the game.
6. Keep this editor open while importing.

Recommended template size: 500 to 3000 layers.

## Import JSON

1. Go to the app's `Import` page.
2. Click `Refresh` and select the running `forzahorizon6.exe` process.
3. Enter the exact template layer count.
4. Add the generated `.json`, or click `Use generated JSON`.
5. Leave advanced address fields empty.
6. Click `Import JSON`.

The app will locate and verify the FH6 layer table before writing. If it cannot verify the target safely, it stops before writing.

## Important Rules

- The template must be ungrouped.
- The layer count in the app must match the game.
- Do not switch menus while importing.
- If you restart the game, reload the template, or change layer count, import again with the new correct count.
- If the JSON is smaller than the template, unused template layers are hidden.
- If the JSON is larger than the template, extra shapes are trimmed.

## Environment Fixes

### `_ARRAY_API not found`, NumPy, Or OpenCV Error

This is a preview dependency problem, not a missing file.

Importing into FH6 can still work without preview. Reinstall the core dependencies first:

```powershell
python -m pip uninstall -y numpy opencv-python
python -m pip install -r requirements.txt
```

If you want preview support, use Python 3.12 and then install the optional preview dependencies:

```powershell
py -3.12 -m pip install -r requirements.txt
py -3.12 -m pip install -r requirements-preview.txt
```

If you are using Python 3.14 and dependency installation fails, install Python 3.12 and run `install_dependencies.bat` again.

### Check Dependencies

Run this in the app folder:

```powershell
check_environment.bat
```

`Core OK` means the Python app dependencies are installed. `Preview is unavailable` only means the built-in preview panel cannot render images in this Python environment.

### GPU Generator Or OpenCL Error

Update the NVIDIA/AMD/Intel graphics driver. The bundled generator is `forza-painter-geometrize-go.exe`; it uses OpenCL and does not depend on Python NumPy/OpenCV.

### Permission Error Or `OpenProcess` Failed

Close the app and run `start_app.bat` as administrator.

Generating JSON does not need administrator permission, but importing into FH6 usually does.

### Game Process Not Found

Make sure FH6 is running. Click `Refresh` in the app. If the process still does not appear, restart the app after the game is open.

### Locator Cannot Find A Safe Template

Check:

- You are in Vinyl Group Editor, not livery/car editor.
- The template is ungrouped.
- The layer count is exact.
- You did not switch menus after entering the count.

### Import Looks Cut Off

The template has too few layers. Use a larger template or generate JSON with a faster/lower-quality profile.

## Files Users Should Open

- `install_dependencies.bat`: install required Python packages.
- `check_environment.bat`: check whether the core environment is ready.
- `clean_runtime_data.bat`: delete runtime cache before publishing or re-zipping.
- `start_app.bat`: start the app.
- `1. drag_image_file_here.bat`: optional shortcut for dragging an image into the app.

Most users should not open the Python files directly.
