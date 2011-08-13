#!/usr/bin/env python
#coding:utf-8

els = "else"

# indent is 4space
def oldmain():
    f = open("test2.bas")
    output = u""
    indent_level = 0
    bindent_level = 0
    for line in f:

        bindent_level = indent_level
        indent_level = return_indent_depth(line)
        if indent_level < bindent_level:
            for i in range(bindent_level - indent_level):
                output = output + "\n" + " " * 4*(bindent_level-i) + "}"
            output = output + "\n"
        if line.rstrip()[-1] == ":":
            output = output + line.rstrip()[:-1]+"{"
        else:
            output = output + line.rstrip()

        if indent_level == bindent_level:
            output = output + ";"
        output = output + "\n"
    print output

def main():
    f = open("test2.bas")
    string = f.read()
    gen_output(string)


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
            output = output + ";"

        if offsideline[-1] < indent_levels[i]:
            offsideline.append(indent_levels[i])





        print offsideline

        if clean_lines[i][-1] == ":":
            output = output + clean_lines[i][:-1] + "{" + "\n" 
        else:
            output = output + clean_lines[i] + "\n"

        if indent_levels[i] > indent_levels[i+1]:
            for j in range(indent_levels[i] - indent_levels[i+1]):
                output = output + " " * 4*(indent_levels[i]-j-1) + "}" + "\n"

    print clean_lines
    print indent_levels
    print output


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
