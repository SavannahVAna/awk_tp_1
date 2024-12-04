#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
}



ENDFILE {
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}

