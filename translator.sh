#!/bin/bash

rotodec(){
    echo ${1} |
    sed 's/CM/DCD/g' |
    sed 's/M/DD/g' |
    sed 's/CD/CCCC/g' |
    sed 's/D/CCCCC/g' |
    sed 's/XC/LXL/g' |
    sed 's/C/LL/g' |
    sed 's/XL/XXXX/g' |
    sed 's/L/XXXXX/g' |
    sed 's/IX/VIV/g' |
    sed 's/X/VV/g' |
    sed 's/IV/IIII/g' |
    sed 's/V/IIIII/g' |
    tr -d '\n' |
    wc -m
}

filename=$2

echo "#!/bin/bash" > $filename

# Variables
printf "%s" "$(cat $1 | sed "s/^\s*datum\s*\([a-zA-Z0-9]*\)\s*est\s*\"\(.*\)\"/\1=\"\2\"/g")" >> $filename
printf "%s" "$(cat $filename | sed "s/^\s*datum\s*\([a-zA-Z0-9]*\)\s*est\s*\(.*\)/\1=\2/g")" > $filename

# if statements
printf "%s" "$(cat $filename | sed "s/^\s*si\s*\(\$[a-zA-Z]*\)\(.*\)age/if \[ \1\2\]; then/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*\[.*\)est maior aut aequum quam\(.*\].*\)/\1\-ge\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*\[.*\)est minor aut aequum quam\(.*\].*\)/\1\-e\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*\[.*\)est maior quam\(.*\].*\)/\1\-gt\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*\[.*\)est minor quam\(.*\].*\)/\1\-lt\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*\[.*\)est scriptura\(.*\].*\)/\1=\2/g")" > $filename
printf "%s" "$(cat $filename | sed "s/\(.*\[.*\)est\(.*\].*\)/\1-eq\2/g")" > $filename

# echos
printf "%s" "$(cat $filename | sed "s/^\(\s*\)nuntia/\1echo/g")" > $filename

# reads
printf "%s" "$(cat $filename | sed "s/^\(\s*\)percipe/\1read/g")" > $filename

# block endings
printf "%s" "$(cat $filename | sed "s/^\s*conclude si/fi/g")" > $filename
printf "%s" "$(cat $filename | sed "s/^\s*aliter si\(.*\)/elif \1/g")" > $filename
printf "%s" "$(cat $filename | sed "s/^\s*aliter/else/g")" > $filename
printf "%s" "$(cat $filename | sed "s/^\s*conclude iteratio/done\n/g")" > $filename

# for
printf "%s" "$(cat $filename | sed "s/^\s*itera\s*\([a-zA-Z0-9]*\)\s*ab\s*\([\$a-zA-Z0-9]*\)\s*ad\s*\([\$a-zA-Z0-9]*\)/for ((\1 = \2; i <= \3; \1++)); do/g")" > $filename

# sum
printf "%s" "$(cat $filename | sed "s/\([\$a-zA-Z0-9]*\)\s*summa\s*\([\$a-zA-Z0-9]*\)/\$(expr \1 + \2)/g")" > $filename

# functions
printf "%s" "$(cat $filename | sed "s/\s*praecepta\s*\([a-zA-Z0-9]*\)/\1/g")" > $filename

chmod +x $filename