#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
    print("BEGIN test");
}

BEGINFILE {
    print("begin processing file: ", FILENAME);
    peer_flag = 0;             
    began = 0;                 
    transform_flag = 0;        
    access_flag = 0;           
    split("", liste);          

    fast_flag = 0;            
    begin2 = 0;                
    vart2 = "";               
    vnb2 = 0;                  
}

/^access-list/ {
    liste[$2] = 1;  
}

/^crypto map / {
    if (began) {
        
        if (!transform_flag) {
            print("Line number:", vnb, "mal configuré at", vart);
        }
        if (!peer_flag) {
            print("Line number:", vnb, "peer not defined at", vart);
        }
        if (!access_flag) {
            print("Line number:", vnb, "access-list not properly configured at", vart);
        }
    } else {
        began = 1;  
    }
    
    
    vart = $0;
    vnb = NR;
    transform_flag = 0;
    peer_flag = 0;
    access_flag = 0;
}

/^ set transform-set/ {
    transform_flag = 1;  
}

/^ set peer ([0-9]{1,3}\.){3}[0-9]{1,3}/ {
    peer_flag = 1;  
}

/^ match address/ {
    if ($3 in liste) {
        access_flag = 1;  
    }
}

/^interface FastEthernet/ {
    if (begin2) {
        
        if (!fast_flag) {
            print("Line number:", vnb2, "crypto map not set for", vart2);
        }
    } else {
        begin2 = 1;  
    }
    
   
    vart2 = $0;
    vnb2 = NR;
    fast_flag = 0;
}

/^[ ]+crypto map/ {
    fast_flag = 1;  
}

ENDFILE {
   
    if (began) {
        if (!transform_flag) {
            print("Line number:", vnb, "mal configuré at", vart);
        }
        if (!peer_flag) {
            print("Line number:", vnb, "peer not defined at", vart);
        }
        if (!access_flag) {
            print("Line number:", vnb, "access-list not properly configured at", vart);
        }
    }
    
    
    if (begin2) {
        if (!fast_flag) {
            print("Line number:", vnb2, "crypto map not set for", vart2);
        }
    }
    
    print("end processing file: ", FILENAME);
}

END {
    print("END test");
}
