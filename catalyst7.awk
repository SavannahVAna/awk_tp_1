#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    
    trunk_flag = 0;
    encap_flag = 0;
    native_flag=0;
    allowed_flag = 0;
    port_flag = 0;
    began = 0;
}

/^interface /{
    if (began && trunk_flag){
            #test les flags
            if (!(!encap_flag && !native_flag && !allowed_flag && port_flag)){
                print("wrong configuration ", "interface ", vart);
            }
            
        }
        else{
            began =1;
        }
        
        vart = $0;
        
        encap_flag = 0;
        trunk_flag = 0;
        native_flag=0;
        allowed_flag = 0;
        port_flag = 0;
        
}


#ip valide aussi
/^ switchport mode access/{
    trunk_flag = 1;
}

/^ switchport trunk encapsulation/{
    encap_flag = 1;
}

/^ switchport trunk native vlan/{
    native_flag =1;
}

/^ switchport trunk allowed vlan/{
    allowed_flag =1;
}

#n'oublie pas c'est ne pas dans le check ça

/^ switchport port-security/{
    port_flag = 1;
}
    

# pas oublier la derneier ligne
ENDFILE {
    
    if (began && trunk_flag){
        #test les flags
        if (!(!encap_flag && !native_flag && !allowed_flag && port_flag)){
            print("wrong configuration ", "interface ", vart);
        }
            
    }
    
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}



