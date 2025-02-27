#!/usr/bin/gawk -f

# Script to remove specific stopwords from a text file

BEGIN {
    # Make matching case-insensitive
    IGNORECASE = 1;
    
    # Initialize array of words to remove
    split("is the in but can a of to that it for on with as this was at by an be from or are", words);
    for (i in words) {
        stopwords[words[i]] = 1;
    }
}

{
    # Store the line
    line = $0;
    result = "";
    
    # Split line into words
    n = split(line, linewords);
    
    # Process each word
    for (i = 1; i <= n; i++) {
        word = linewords[i];
        
        # Convert to lowercase for comparison
        lword = tolower(word);
        
        # If not a stopword, add to result
        if (!(lword in stopwords)) {
            result = result word " ";
        }
    }
    
    # Remove trailing space and print
    sub(/ $/, "", result);
    print result;
}