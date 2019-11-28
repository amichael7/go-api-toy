#/usr/bin/env python3

import argparse
import re

def main():
    parser = argparse.ArgumentParser(prog='dockerfile_template.py')

    # get the filename for the dockerfile
    parser.add_argument('-f','--filename',
                    dest='filename',
                    required=True,
                    help='the dockerfile containing the templates')
    args = parser.parse_known_args()
    filename = args[0].filename

    # read the dockerfile
    dockerfile = open(filename,'r').read()

    # find all bracketed values
    matches = re.finditer(r'{{(.*?)}}', dockerfile)

    # get all strings to replace
    if not matches: return
    matches = [m[0] for m in matches]
    template = list(set(matches))

    # get the variables from the dockerfile as arguments
    for variable in template:
        name = variable[2:-2]
        parser.add_argument(f'--{name}',
                        dest=f'{name}',
                        required=True,
                        help=f'provide a variable for {name}')
    args = parser.parse_args()

    # use the arguments to parse the name 
    for variable in template:
        value = vars(args)[variable[2:-2]]
        dockerfile = dockerfile.replace(variable, value)

    # output the result to standard out to be consumed
    # by docker build.
    print(dockerfile)


if __name__ == '__main__':
    main()
