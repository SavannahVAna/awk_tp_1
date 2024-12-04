#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    liste = "";
    delete acl_ref;
    delete acl_def;
}

/^access-list/ && $2 != ""{
    acl_ref[$2] = 1; 
    
}

/^ip access-list extended/ && $4 != ""{
    acl_ref[$4] = 1;   
    
}

/^ access-class/ && $2 != ""{
    acl_def[$2] =1;
}

/^ ip access-group/ && $3 != ""{
    acl_def[$3] =1;
}

/^snmp-server/ && $5 != ""{
    acl_def[$5] =1;
}



ENDFILE {
    for (id in acl_def) {
        if(!(id in acl_ref)) {
            print("DEF pas définit ", id);

        }
    }

    for(id in acl_ref) {
        if(!(id in acl_def)) {
            print("REF pas utilisé ", id);
        }
    }
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}
