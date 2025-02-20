BEGIN{
    first_paragraph = 1;
    count = 0;
}

# Pass 1: Read and store word indices
PASS == 1 {
    word2idx[$1] = ++count;
    words[count] = $1;
    next;
}

# Pass 2: Read paragraphs, count word occurrences
PASS == 2 {
    RS = "";  # Treat paragraphs as records (empty line delimiter)
    
    if (first_paragraph) {
        # Print header row (top words)
        for (i = 1; i <= count; i++) {
            printf "%s%s", words[i], (i == count ? "\n" : ",");
        }
        first_paragraph = 0;  # Ensure header prints only once
    }

    delete word2cnt;  # Reset word count for the paragraph

    # Count occurrences of words in the paragraph
    for (i = 1; i <= NF; i++) {
        if ($i in word2idx) {
            word2cnt[word2idx[$i]]++;
        }
    }

    # Print frequencies in order
    for (i = 1; i <= count; i++) {
        printf "%d%s", word2cnt[i] + 0, (i == count ? "\n" : ",");
    }
}
