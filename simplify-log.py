"""简化日志文件."""

import os
import re

_LOG_URL = 'log/backup.log'
_TMP_URL = _LOG_URL + '.tmp'
_ENCODING = 'UTF-16'

if __name__ == '__main__':
    with open(_LOG_URL, 'r', errors='ignore', encoding=_ENCODING) as log:
        with open(_TMP_URL, 'w', encoding=_ENCODING) as tmp:
            for line in log:
                # 跳过复制进度.
                if re.match('\\s*\\S+%\\s*', line):
                    continue
                tmp.write(line)

    os.remove(_LOG_URL)
    os.rename(_TMP_URL, _LOG_URL)

    exit(0)
