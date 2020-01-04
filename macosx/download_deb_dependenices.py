import sys
import glob
import subprocess
import argparse
from typing import List
import time


STACK = []
INSTALLED = []
BEFORE = set()


def fetch_installed_debfile() -> set:
    before = set(glob.glob('./*.deb'))
    return before


def install_pkg(already_installed: set, pkg: str):
    if already_installed != set():
        before = already_installed
        print('before : ', before)
        subprocess.call(['apt-get', 'download', pkg])
        after = set(glob.glob('./*.deb'))
        print('after : ', after)
        debfile = list(after - before)[0]
    else:
        subprocess.call(['apt-get', 'download', 'libc6'])
        debfile = glob.glob('./*.deb')[0]
    subprocess.call(['dpkg', '-i', debfile])

    return


def dfs_aptcache_depends(depends: List):
    print('STACK : ', STACK)
    print('depends : ', depends)
    for depend in depends:
        if depend == 'libc6':
            depend = 'libc6-udeb'
        STACK.append(depend)
        next_depend = process_stdout(depend)
        next_depend = [d.replace('libc6', 'libc6-udeb') for d in next_depend]
        print('depend : ', depend)
        print('next_depend : ', next_depend)
        print('STACK : ', STACK)
        print('INSTALLED : ', INSTALLED)
        if depend in INSTALLED:
            # STACK.pop()
            print('**************** already installed ****************')
            continue
        if not next_depend and depend not in INSTALLED:
            # print('installed')
            # download_debfile(depend)
            # print('**************** download **************** ', depend)
            # INSTALLED.append(depend)
            # STACK.pop()
            print('break')
            # print('STACK : ', STACK)
            # print('INSTALLED : ', INSTALLED)
            pass
        if next_depend and all([p in INSTALLED for p in next_depend]) and depend not in INSTALLED:
            print('**************** download **************** ', depend)
            INSTALLED.append(depend)
            STACK.pop()
            print('STACK : ', STACK)
            print('break')
            print('INSTALLED : ', INSTALLED)
            continue
        dfs_aptcache_depends(next_depend)
    else:
        print('STACK : ', STACK)
        parent = STACK.pop()
        if parent not in INSTALLED:
            print('**************** download ****************')
            INSTALLED.append(parent)
        print('**************** finish {} ****************'.format(parent))
        print('**************** add {} ****************'.format(parent))
        print('STACK : ', STACK)
        print('INSTALLED: ', INSTALLED)

    return


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
    depends = process_stdout(pkg)
    STACK.append(pkg)
    dfs_aptcache_depends(depends)
    INSTALLED.append(pkg)

    print('INSTALLED')
    print(INSTALLED)

    replace_installed = [i.replace('libc6-udeb', 'libc6') for i in INSTALLED]
    for idx, pkg in enumerate(replace_installed):
        if idx == 0:
            before = BEFORE
        else:
            before = fetch_installed_debfile()
        install_pkg(before, pkg)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'pkg',
        type=str,
        help='please input deb.package name'
    )
    args = parser.parse_args()
    main(args.pkg)
