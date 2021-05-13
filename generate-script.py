"""根据文件 config.yml 读取元文件目录 URL 和目标目录 URL 的映射关系并生成 .bat 脚本."""
import os

from ruamel.yaml import YAML

_BAT_URL = 'backup.bat'
_BAT_ENCODING = 'GBK'

_CONF_URL = r'conf\config.yml'
_CONF_ENCODING = 'UTF-16'

_LOG_URL = r'log\backup.log'

_ROBOCOPY_ARGS: str = '/mir /unicode /tee /unilog+:"%s"' % _LOG_URL

if __name__ == '__main__':
    valid_count = 0
    invalid_count = 0

    try:
        with open(_CONF_URL, 'r', encoding=_CONF_ENCODING) as conf_file, open(_BAT_URL, 'w',
                                                                              encoding=_BAT_ENCODING) as bat_file:
            conf = YAML().load(conf_file)
            conf_file.close()

            for group in conf:
                for item in group['dirs']:
                    src = group['root']['src'] + '\\' + item['src']
                    dest = group['root']['dest'] + '\\' + item['dest']

                    if src == '\\' or dest == '\\':
                        invalid_count = invalid_count + 1
                        continue

                    valid_count = valid_count + 1
                    print(('"%s"\n"%s"\n' % (src, dest)).replace('\\\\', '\\').replace('"\\', '"'))

                    cmd = ('robocopy "%s" "%s" %s' % (src, dest, _ROBOCOPY_ARGS)).replace('\\\\', '\\').replace('"\\',
                                                                                                                '"')
                    bat_file.write(cmd + '\n')

            bat_file.write('exit /b 0\n')
            bat_file.close()

            if valid_count == 0:
                os.system('del %s' % _BAT_URL)
    except FileNotFoundError:
        pass

    print('(%d 个合法项, %d 个非法项.)' % (valid_count, invalid_count))

    exit(0)
