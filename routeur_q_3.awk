#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    
    flag_in = 0;
    flag_out=0;
    began = 0;
}

{
    if($0 ~ /line/) {
        if (began){
            #test les flags
            if (!flag_in){
                print("missing access class in ", "line ", vart, "line number : ", vnb);
            }
            if (!flag_out){
                print("missing access class out ", "line ", vart, "line number : ", vnb);
            }
        }
        else{
            began =1;
        }
        
        vart = $0;
        vnb = NR;
        flag_in = 0;
        flag_out=0;
    }

    if(began){
        if($1 ~ /access-class/){
            if($3 ~ /in/){
                flag_in = 1;
            }
            if($3 ~ /out/){
                flag_out =1;
            }
        }
    }
}
# pas oublier la derneier ligne
ENDFILE {
    if (began){
        #test les flags
        if (!flag_in){
            print("missing access class in ", "line ", vart, "line number : ", vnb);
        }
        if (!flag_out){
            print("missing access class out ", "line ", vart, "line number : ", vnb);
        }
    }
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}

