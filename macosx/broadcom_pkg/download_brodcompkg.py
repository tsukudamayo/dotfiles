import subprocess
import argparse
from typing import List


MEMORY = []


def download_debfile(package_list: List):
    for l in package_list:
        subprocess.call(['apt-get', 'download', l])

    return


def dfs_aptcache_depends(depends: List):
    for depend in depends:
        print('depend : ', depend)
        if not depend:
            print('break')
            break
        if depend not in MEMORY:
            MEMORY.append(depend)
        else:
            continue
        print('MEMORY : ', MEMORY)
        next_depend = process_stdout(depend)
        print('next_depend : ', next_depend)
        dfs_aptcache_depends(next_depend)


def process_stdout(pkg: str) -> List:
    res = subprocess.run(
        ['apt-cache', 'depends', pkg],
        stdout=subprocess.PIPE
    )
    target = res.stdout.decode().split('\n')
    depends = [t.replace(' ', '').replace('<', '').replace('>', '').split(':')[1]
               for t in target
               if t.find('Depends') >= 0]

    print('process_stdout/pkg : ', pkg)
    print('process_stdout/depends : ', depends)
    return depends


def main(pkg):
    MEMORY.append(pkg)
    depends = process_stdout(pkg)
    dfs_aptcache_depends(depends)

    print('MEMORY')
    print(MEMORY)

    download_debfile(MEMORY)
    


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'pkg',
        type=str,
        help='please input deb.package name'
    )
    args = parser.parse_args()
    main(args.pkg)
