#!/usr/bin/gawk -f

@include "common.awk"

BEGIN {
	print("BEGIN test");
}

BEGINFILE {
	print("begin processing file: ", FILENAME);
    peer_flag = 0;
    began = 0;#crypto mazp
    transform_flag= 0;
    access_flag = 0;
    split("",liste);

}

/^access-list/{
    liste[$2] = 1;
}
/^crypto map /{
    if (began){
        #test les flags
        if (!transform_flag){
            print("no ipsec policy ", "at ", vart, "line number : ", vnb);
        }
        if(!peer_flag){
            print("no peer defined ", "at ", vart, "line number : ", vnb);
        }
        if(!access_flag){
            print("filtrage d'adresse mal configuré ", "at ", vart, "line number : ", vnb);
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
/^ set transform-set/{
    transform_flag =1;
}

/^ set peer ([0-9]{1,3}\.){3}[0-9]{1,3}/{
    peer_flag =1;
}

/^ match address/{#faudra regarder pour faire une liste d'acl
    if($3 in liste){
        access_flag = 1;
    }
}


    

# pas oublier la derneier ligne
ENDFILE {
    
    if (began){
        #test les flags
        if (!transform_flag){
            print("no ipsec policy ", "at ", vart, "line number : ", vnb);
        }
        if(!peer_flag){
            print("no peer defined ", "at ", vart, "line number : ", vnb);
        }
        if(!access_flag){
            print("filtrage d'adresse mal configuré ", "at ", vart, "line number : ", vnb);
        }
        
    }
    
	print("end processing file: ", FILENAME);
}

END {
	
	print("END test");
}
#dans la consigne il manque un mot du coup j'ai controlé le format de l'adresse ip et que l'acl ait bien été vérifé
#dans les fichiers de test elle est toujours écrite après la définition des crypto map donc cela print un message d'erreur
#et je pense que c'est comme ça dan la vraie vie car ces fichiers de conf dont comme des règles iptables ou autre
#c'est de haut en bas
