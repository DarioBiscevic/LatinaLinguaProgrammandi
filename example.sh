#!/bin/bash
salve_munde(){
	echo "Salve Munde!";
}

a=5;
b=7;

c=$(expr $a + $b);

salve_munde

if [ $c -eq 12 ]; then
	echo "c est XII";
else
	echo "c non est XII";
fi

if [ $c -gt 10 ]; then
	echo "c magnum datum est, maior quam 10";
fi

read nomen;
echo "Tibi nomen $nomen est";

for ((i = 1; i <= 5; i++)); do
	echo "$i";
done
 