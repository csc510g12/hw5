#!/usr/bin/env awk -f

BEGIN {
    stop_words["is"]
    stop_words["the"]
    stop_words["in"]
    stop_words["but"]
    stop_words["can"]
    stop_words["a"]
    stop_words["of"]
    stop_words["to"]
    stop_words["that"]
    stop_words["it"]
    stop_words["for"]
    stop_words["on"]
    stop_words["with"]
    stop_words["as"]
    stop_words["this"]
    stop_words["was"]
    stop_words["at"]
    stop_words["by"]
    stop_words["an"]
    stop_words["be"]
    stop_words["from"]
    stop_words["or"]
    stop_words["are"] 
}

{
    for (i = 1; i <= NF; i++) {
        if (!($i in stop_words)) {
            printf "%s ", $i
        }
    }
    print ""
}
