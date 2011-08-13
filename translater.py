#!/usr/bin/env python
#coding:utf-8

import sys
els = "else"

# indent is 4space

def main():
    f = open(sys.argv[1])
    string = f.read()
    print gen_output(string)


def gen_output(string):
    lines = string.split('\n')
    clean_lines = []
    output = u""
    for line in lines:
        if not line.strip() == "":
            clean_lines.append(line.rstrip())

    indent_levels = []
    for line in clean_lines:
        indent_levels.append(return_indent_depth(line))

    clean_lines.append("")
    indent_levels.append(0)

    offsideline = [-1]

    for i in range(len(clean_lines)-1):
        if offsideline[-1] > indent_levels[i]:
            for l in range(offsideline[-1] - indent_levels[i]):
                offsideline.pop(-1)

        if offsideline[-1] == indent_levels[i]:
            if not clean_lines[i].strip()[0:len(els)] == els:
                output = output + ";"

        if offsideline[-1] < indent_levels[i]:
            offsideline.append(indent_levels[i])



        if clean_lines[i][-1] == ":":
            output = output + clean_lines[i][:-1] + "{" + "\n" 
        else:
            output = output + clean_lines[i] + "\n"

        if indent_levels[i] > indent_levels[i+1]:
            for j in range(indent_levels[i] - indent_levels[i+1]):
                output = output + " " * 4*(indent_levels[i]-j-1) + "}" + "\n"

    return output


def return_indent_depth(line):
    space = 0
    for l in line:
        if l.strip() == "":
            space = space + 1
            pass
        else:
            return space/4


if __name__ == "__main__":
    main()
