#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
}

/^snmp-server/ {
	if (!(($4 ~ /RO/) && NF ==5)){ 
        print_err("mauvaise conf", $0, NR);
    }
    
    #verifier pour chaque ligne snmp-server si il ya bien RO avec acl
}
ENDFILE {
	
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}
