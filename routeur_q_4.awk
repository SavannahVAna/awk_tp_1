#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    
    flag = 0;
    flag_ip=0;
    began = 0;
}

/^interface /{
    if (began && flag_ip){
            #test les flags
            if (!flag){
                print("no access group ", "line ", vart, "line number : ", vnb);
            }
            
        }
        else{
            began =1;
        }
        
        vart = $0;
        vnb = NR;
        flag = 0;
        flag_ip=0;
        
}


#ip valide aussi
/^ ip access-group/{
    flag = 1;
}

/^ ip address ([0-9]{1,3}\.){3}[0-9]{1,3}/{
    flag_ip = 1;
}
    

# pas oublier la derneier ligne
ENDFILE {
    
    if(flag_ip){
        if (!flag){
            print("no access group ", "line ", vart, "line number : ", vnb);
        }
    }
    
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}

