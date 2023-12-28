import std/[tables, strutils, re]

var
    nums = {"one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9"}.toTable
    wordfile = readFile("list.txt")
    lineseq: seq[int]

proc seq_sum(s: seq[int]): int =
    for i in s:
        result += i

proc nums_replace(s: string): string =
    result = s
    for k, v in nums:
        result = result.replace("t", "tt").replace("on", "oon").replace("ei", "eei")
        result = replace(result, k, v)

proc regex_line(s: string): int =
    result = 0
    var tmp:string  = ""

    for m in findAll(s, re"\d+") :
        tmp = tmp & m
    
    if tmp.len > 0:
        tmp = tmp[0] & tmp[^1]   
    result = parseInt(tmp)

try:
    for line in wordfile.split("\n"):
        if line.len > 0:
            var l = regex_line(nums_replace(line))
            lineseq.add(l)

    echo seq_sum(lineseq)
    
except:
    echo "Cannot read file"


