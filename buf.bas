{main=0
;label "powertest" to{
    for i=1 to i is 10 do{
        for j=1 to j is 10 do{
            print i ^ j
;            j=j+1
        }
;        i=i+1
    }
}
;label "plustest" to{
    for i=1 to i is 10 do{
        for j=1 to j is 10 do{
            print i + j
;            j = j + 1
        }
;        i = i + 1
    }
}
;label "main" to{
    goto "powertest"
;    goto "plustest"
}
;goto "main"
}
