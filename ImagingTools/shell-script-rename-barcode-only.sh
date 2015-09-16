#!/bin/bash

#
# run from inside the jpg folder, with the cr2 folder in the same parent
#	
#	-parent folder
#		--SpecimenOriginalJpg (Run from here)

mkdir SpecimenRenamedJpg

for f in *.JPG
do

	c=${f%.*}

	# send output to null to make sips a bit quieter
	sips -r 90 $f > /dev/null

	echo "
Checking file"

	catNum=`zbarimg -q --raw --set *.disable --set code39.enable $f`

	if [ "$catNum" != "" ]
		then 
		cp $f "SpecimenRenamedJpg/ARIZ$catNum.jpg"
		echo "$f renamed to ARIZ$catNum.jpg"
	else echo "$f didnt have a readable barcode"
	fi

	# must put quotion marks around variable name and put a $ in front of it
	#cp "$f" copy-"$f" #this copies file f and renames it copy-filenameOfF
done
