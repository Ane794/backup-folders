# 文件夹批量备份

将文件夹批量备份，并自动覆盖旧备份中的旧版本文件，删除多余的文件。

# 使用

## 修改配置文件

### 修改 *[conf/root.cfg](conf/root.cfg)*

如果待备份的元文件具有共同的根目录（如都处于 <code>D:</code> 盘中，则共同根目录为 <code>D:</code>）且备份的目标路径有根目录，可将 <code>[mode]</code> 下的 <code>
ENABLED</code> 值设为 <code>True</code>。

<code>[code]</code> 下的 <code>SRC_ROOT</code> 值表示元文件的根目录，<code>DEST_ROOT</code> 值表示备份目标的根目录。

### 修改 *[conf/dirs.cfg](conf/dirs.cfg)*

在 *[dirs]* 下添加以下格式的文字：

    "待备份的目录的路径" = "目标的路径"

如果 *[conf/root.cfg](conf/root.cfg)* <code>[mode]</code> 下的 <code>ENABLED</code> 值为 <code>True</code>，则 *[conf/dirs.cfg](conf/dirs.cfg)*
中需要填入相对路径；否则填入绝对路径。

### 示例

要想备份 <code>D:/origin</code> 下的 <code>dirA</code> 目录和 <code>dirB</code> 目录，到 <code>E:/backup</code> 中的对应目录。

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