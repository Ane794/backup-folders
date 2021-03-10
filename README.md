# 文件夹批量备份

将文件夹批量备份，并自动覆盖旧备份中的旧版本文件，删除多余的文件。

# 使用

## 修改配置文件

### 修改 *[conf/root.cfg](conf/root.cfg)*

如果待备份的元文件具有共同的根目录（如都处于 `D:` 盘中，则共同根目录为 `D:`）且备份的目标路径有根目录，可将 `[mode]` 下的 `ENABLED` 值设为 `True`。

`[code]` 下的 `SRC_ROOT` 值表示元文件的根目录，`DEST_ROOT` 值表示备份目标的根目录。

### 修改 *[conf/dirs.cfg](conf/dirs.cfg)*

在 *[dirs]* 下添加以下格式的文字：

    "待备份的目录的路径" = "目标的路径"

如果 *[conf/root.cfg](conf/root.cfg)* `[mode]` 下的 `ENABLED` 值为 `True`，则 *[conf/dirs.cfg](conf/dirs.cfg)*
中需要填入相对路径；否则填入绝对路径。

### 示例

要想备份 `D:/origin` 下的 `dirA` 目录和 `dirB` 目录，到 `E:/backup` 中的对应目录。

#### 使用相对路径的方法

在 *[conf/root.cfg](conf/root.cfg)* 中编辑：

    [mode]
    ENABLED = True

    [roots]
    SRC_ROOT = D:/origin
    DEST_ROOT = E:/backup

在 *[conf/dirs.cfg](conf/dirs.cfg)* 中编辑：

    [dirs]
    "dirA" = "dirA"
    "dirB" = "dirB"

#### 使用绝对路径的方法

在 *[conf/root.cfg](conf/root.cfg)* 中编辑：

    [mode]
    ENABLED = False

在 *[conf/dirs.cfg](conf/dirs.cfg)* 中编辑：

    [dirs]
    "D:/origin/dirA" = "E:/backupdirA"
    "D:/origin/dirB" = "E:/backupdirB"

## 执行备份

运行 *[start.bat](start.bat)*。

备份记录（每次运行会被覆盖）保存在 *[log/backup.log](log/backup.log)*。