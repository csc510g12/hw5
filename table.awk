#!/usr/bin/env awk -f

BEGIN {
    if (PASS == 1) {
        while (getline word < ARGV[1]) {
            words[word] = 1;
        }
        close(ARGV[1]);
    }
}

{
    if (PASS == 2) {
        if ($0 == "") {
            if (NR > 1) {
                print_table_line();
            }
            delete count;
            next;
        }

        for (i=1; i<=NF; i++) {
            if ($i in words) {
                count[$i]++;
            }
        }
    }
}

END {
    if (PASS == 2) {
        print_table_line();
    }
}

function print_table_line() {
    output = "";
    for (word in words) {
        ouput = output + (output ? "," : "") + (counts[word] ? counts[word] : 0);
    }
    print output;
}