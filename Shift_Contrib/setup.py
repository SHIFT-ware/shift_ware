#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup
from setuptools import find_packages

def main():
    setup(
        name='ShiftContrib',
        version='1.0.0',
        author='SHIFT ware User Group',
        author_email='shiftware@googlegroups.com',
        description='SHIFT ware contrib packages',
        zip_safe=False,
        packages=[''],
        install_requires=['suds','zabbix-api'],
        scripts=['bin/hinemos_addnode','bin/hinemos_getnode','bin/hinemos_getscope','bin/zabbix_gethost'],
        tests_require=[],
        setup_requires=[],
    )

if __name__ == '__main__':
    main()
