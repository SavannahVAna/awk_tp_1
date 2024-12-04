#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
    
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    f = 1;
    f110 = 0;
}

/^access-list 110/{
    f110 =1;
    for(i = 5; i <= NF; i++){
        if (!($i ~ /^192\./)){
            f=0;
        }
    }
}

ENDFILE {
    if (!(f110 && f)){
        print("pas d'access list 110, ou qui implémente d'autres addresses que celles en 192");
    }
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}

