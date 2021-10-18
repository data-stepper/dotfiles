import sys
import os
from os.path import expanduser, join
import argparse


def main(dirname):

    file_path = dirname

    if len(sys.argv) > 1:
        file_path = sys.argv[1]
    
    files = [x for x in sorted(os.listdir(file_path)) if x.endswith(('jpg', 'jpeg','gif', 'png'))]
    
    if len(files) % 2 != 0:
        print("Odd number of files in directory %s, results might be off." % (file_path))
    
    with open(expanduser('~/anki_cards.tsv'), 'w') as output_file:

        for filename in files:
            output_file.write('<img src="%s" />%s' % (filename, os.linesep))


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument('dirname', type=str)

    return parser.parse_args()


if __name__ == '__main__':

    args = parse_args()
    main(args.dirname)
