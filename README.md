# 文件夹批量备份

将文件夹批量备份，并自动覆盖旧备份中的旧版本文件，删除多余的文件。

# 环境需求

* Python 3
    * ruamel.yaml

# 使用

## 配置文件 *[conf/config.yml](conf/config.yml)*

### 配置共同根目录 `root`

如果待备份的元文件具有共同的根目录（如都处于 `D:` 盘中，则共同根目录为 `D:`）且备份的目标路径有根目录，可将 `root` 组的 `src` 值设为该根目录（如 `"D:"`）；如果元文件的所在目录使用绝对路径，则 `root`
组的 `src` 值留空为 `""`。

目标文件的共同根目录同理，修改 `root` 组的 `dest` 值。

### 配置备份路径组

在 `dirs` 组按以下格式配置元文件目录路径及对应的目标目录路径：

    - src: "元文件目录路径 A"
      dest: "目标目录路径 A"
    - src: "元文件目录路径 B"
      dest: "目标目录路径 B"

### 示例

以下配置方法使元文件目录 `C:\src1` ~ `C:\src6` 分别对应目标目录 `C:\dest1` ~ `C:\dest6`。

在 *[conf/config.yml](conf/config.yml)* 中配置：

    - root:
        src: ""
        dest: ""
      dirs: # 全部使用绝对路径
        - src: "C:\\src1"
          dest: "D:\\dest1"
        - src: "C:\\src2"
          dest: "D:\\dest2"
    
    - root:
        src: "C:\\"
        dest: "D:\\"
      dirs: # 全部使用相对路径
        - src: "src3"
          dest: "dest3"
        - src: "src4"
          dest: "dest4"
    
    - root:
        src: "C:\\"
        dest: ""
      dirs: # 仅目标目录使用绝对路径
        - src: "src5"
          dest: "D:\\dest5"
        - src: "src6"
          dest: "D:\\dest6"

## 执行备份

运行 *[start.bat](start.bat)*。

备份记录（每次运行会被覆盖）保存在 *[log/backup.log](log/backup.log)*。