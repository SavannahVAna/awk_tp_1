#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
	f= 0;
}

/service password-encryption/ {
	f=1;
}
ENDFILE {
	if(f==0){
		print("no password encryption fond");
	}
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}

