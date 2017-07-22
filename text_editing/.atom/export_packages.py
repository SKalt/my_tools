#! /usr/bin/python

import os

if __name__ == '__main__':
    with open('import_packages.sh', 'w') as f:
        to_export = [i for i in os.listdir('packages') if 'README' not in i]
        export = '#! /usr/bin/env python\napm install ' + ' '.join(to_export)
        f.write(export)
