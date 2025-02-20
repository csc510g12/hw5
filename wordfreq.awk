BEGIN{
    RS=" "
}{
    for (i=1; i<=NR; i++){
        word2cnt[$i] += 1
    }
}
END{
    for (i in word2cnt){
        print word2cnt[i], i
    }
}