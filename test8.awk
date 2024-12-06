#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
    
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    f = 1;
    f110 = 0;
    f2 = 1;
}

/^access-list 110/{
    f110 =1;
    for(i = 5; i <= NF; i++){
        if (i%2 !=0){
            if (!($i ~ /^192\./)){
                f=0;
            }
        }
        else{
            if(!($i ~ /^0\.0\.0\.255/)){
                f2 = 0;
            }
        }
    }
}

ENDFILE {
    if (!(f110 && f && f2)){
        print("pas d'access list 110, ou qui implémente d'autres addresses que celles en 192 type A");
    }
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}

