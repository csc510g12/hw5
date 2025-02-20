BEGIN {
    stopwords = "(^|[^a-zA-Z0-9_])(is|the|in|but|can|a|of|to|that|it|for|on|with|as|this|was|at|by|an|be|from|or|are)([^a-zA-Z0-9_]|$)";
}{
    while (gsub(stopwords, " ", $0));
    print $0;
}
