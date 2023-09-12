#!/bin/bash

filename=$2

echo "#!/usr/bin/perl" > $filename
echo "use strict;" >> $filename
echo "use warnings;" >> $filename
echo "use 5.36.0;" >> $filename

# Variables
printf "%s" "$(cat $1 | sed "s/^\(\s*\)datum\s*\([a-zA-Z0-9]*\)\s*est\s*\"\(.*\)\"/\1my \2=\"\3\"/g")" >> $filename
printf "%s" "$(cat $filename | sed "s/^\(\s*\)datum\s*\([a-zA-Z0-9]*\)\s*est\s*\(.*\)/\1my \$\2 = \3/g")" > $filename

# if statements
printf "%s" "$(cat $filename | sed "s/^\(\s*\)si\s*\([\$a-zA-Z0-9]*\)\(.*\)\s*age/\1if(\2\3\){/g")" > $filename
printf "%s" "$(cat $filename | sed "s/^\(\s*\)aliter si\s*\([\$a-zA-Z0-9]*\)\(.*\)\s*age\(.*\)/\1}elsif(\2\3){/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*(.*\)est maior aut aequum quam\(.*).*\)/\1\>=\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*(.*\)est minor aut aequum quam\(.*).*\)/\1\<=\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*(.*\)est maior quam\(.*).*\)/\1\>\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*(.*\)est minor quam\(.*).*\)/\1\<\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*(.*\)est scriptura\(.*).*\)/\1==\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*(.*\)est\(.*).*\)/\1==\2/g")" > $filename

# print
printf "%s" "$(cat $filename | sed "s/^\(\s*\)nuntia/\1print/g")" > $filename

# reads
printf "%s" "$(cat $filename | sed "s/^\(\s*\)percipe\s*\([^;]*\)/\1my \$\2 = <STDIN>; chomp(\$\2)/g")" > $filename

# block endings
printf "%s" "$(cat $filename | sed "s/^\(\s*\)conclude si/\1}/g")" > $filename
printf "%s" "$(cat $filename | sed "s/^\(\s*\)aliter age/\1}else{/g")" > $filename
printf "%s" "$(cat $filename | sed "s/^\(\s*\)conclude iterationem/\1}\n/g")" > $filename

# for
printf "%s" "$(cat $filename | sed "s/^\s*itera\s*\([\$a-zA-Z0-9]*\)\s*ab\s*\([\$a-zA-Z0-9]*\)\s*ad\s*\([\$a-zA-Z0-9]*\)/for (my \1 = \2; \1 <= \3; \1++){/g")" > $filename

# sum
printf "%s" "$(cat $filename | sed "s/\([\$a-zA-Z0-9]*\)\s*summa\s*\([\$a-zA-Z0-9]*\)/\1 + \2/g")" > $filename

# functions
printf "%s" "$(cat $filename | sed "s/\s*praecepta\s*\([a-zA-Z0-9]*\)/sub \1/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(\s*\)redde\(.*\)/\1return\2/g")" > $filename

printf "%s" "$(cat $filename | sed "s/Variabilis\([0-9]\)*/\$_\[\1\]/g")" > $filename

chmod +x $filename