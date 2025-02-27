BEGIN {
    # Initialize variables
    num_top_words = 0;
    paragraph_started = 0;
}

# Read top words from the first file (PASS=1)
PASS == 1 {
    # Store the top word
    top_words[$0] = 1;
    all_top_words[++num_top_words] = $0;
}

# Process the cleaned file (PASS=2)
PASS == 2 && FNR == 1 {
    # Print the header row with top words
    for (i = 1; i <= num_top_words; i++) {
        printf("%s%s", all_top_words[i], (i < num_top_words ? "," : ""));
    }
    printf("\n");
    
    # Initialize paragraph counter and word counts
    paragraph = 1;
    for (i = 1; i <= num_top_words; i++) {
        word_count[all_top_words[i], paragraph] = 0;
    }
}

# Process each line of the cleaned file
PASS == 2 {
    if (NF == 0) {
        # Empty line indicates end of paragraph
        if (paragraph_started) {
            # Print the word counts for the current paragraph
            for (i = 1; i <= num_top_words; i++) {
                printf "%d%s", word_count[all_top_words[i], paragraph], (i < num_top_words ? "," : "");
            }
            printf "\n";
            
            # Move to next paragraph and reset word counts
            paragraph++;
            for (i = 1; i <= num_top_words; i++) {
                word_count[all_top_words[i], paragraph] = 0;
            }
            
            paragraph_started = 0;
        }
    } else {
        paragraph_started = 1;
        
        # Process each word in the line
        for (i = 1; i <= NF; i++) {
            if ($i in top_words) {
                word_count[$i, paragraph]++;
            }
        }
    }
}

END {
    if (PASS == 2 && paragraph_started) {
        # Print word counts for the last paragraph
        for (i = 1; i <= num_top_words; i++) {
            printf "%d%s", word_count[all_top_words[i], paragraph], (i < num_top_words ? "," : "");
        }
        printf "\n";
    }
}