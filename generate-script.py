"""根据文件读取元目录 URL 和备份目录 URL 的映射关系并生成 .bat 脚本."""

from ruamel.yaml import YAML

_BAT_URL: str = 'backup.bat'

_CONF_URL = r'conf\config.yml'

_MODE_STR: str = 'MODE'
_SRC_ROOT_STR: str = 'SRC_ROOT'
_DEST_ROOT_STR: str = 'DEST_ROOT'

_ENCODING = 'UTF-8'

_ROBOCOPY_ARGS: str = '/mir /unicode'

if __name__ == '__main__':
    with open(_BAT_URL, 'w', encoding=_ENCODING) as bat_file, open(_CONF_URL, 'r', encoding=_ENCODING) as conf_file:
        bat_file.write('@echo off\n')

        conf = YAML().load(conf_file)
        for group in conf:
            for item in group['dirs']:
                cmd = ('robocopy "%s" "%s" %s' % (group['root']['src'] + '\\' + item['src'],
                                                  group['root']['dest'] + '\\' + item['dest'],
                                                  _ROBOCOPY_ARGS)).replace('\\\\', '\\').replace('"\\', '"')
                bat_file.write(cmd + '\n')

        exit(0)
