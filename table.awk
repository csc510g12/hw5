#!/usr/bin/env awk -f

(PASS == 1) {
    words[$1] = 1;
    next;
}

(PASS == 2) {
    if ($0 == "") {
        if (NR > 1) {
            print_table_line();
        }
        delete count;
        next;
    }

    for (i=1; i<=NF; i++) {
        if ($i in words) {
            counts[$i]++;
        }
    }
}

function print_table_line() {
    output = "";
    for (word in words) {
        output = output (output ? "," : "") (counts[word] ? counts[word] : 0);
    }
    print output;
}