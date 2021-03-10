"""简化日志文件."""

import os
import re

_LOG_URL: str = 'log/backup.log'
_TMP_URL: str = _LOG_URL + '.tmp'

if __name__ == '__main__':
    with open(_LOG_URL, 'r', errors='ignore') as log:
        with open(_TMP_URL, 'w') as tmp:
            for line in log:
                # 跳过复制进度.
                if re.match('\\s*\\S+%\\s*', line):
                    continue
                tmp.write(line)

    with open(_TMP_URL, 'r', errors='ignore') as tmp:
        with open(_LOG_URL, 'w') as log:
            for line in tmp:
                log.write(line)

    os.remove(_TMP_URL)
    exit(0)
