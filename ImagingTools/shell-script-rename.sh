#!/bin/bash

#
# run from inside the jpg folder, with the cr2 folder in the same parent
#	
#	-parent folder
#		--SpecimenOriginalCR2
#		--SpecimenOriginalJpg (Run from here)
#		--SpecimenRenamedCR2
#		--SpecimenRenamedJpgs

for f in *.jpg
do

	c=${f%.*}

	# send output to null to make sips a bit quieter
	#sips -r 90 $f > /dev/null
	echo "
Checking file"

	# run the OCR on the current file, use quiet config file to keep tesseract quiet
	tesseract -psm 1 $f ariz_ocr_text quiet

	# Need to detect WACA, WUPA, SCUR
	npsNumber=`egrep -oh '(WACA|WUPA|SUCR)\ [0-9]*' ariz_ocr_text.txt`
	npsID=${npsNumber:0:5}
	npsIDNumber=${npsNumber:5:12}

	arizAcessionNumber=`egrep -h 'ARIZ\ Accession\ No.\ [0-9]*' ariz_ocr_text.txt`
	arizAcessionNumber=${arizAcessionNumber:19:}

	# Find out how long the number is and pad
	stringLength=${#npsNumber}
	if [ "$stringLength" = "12" ]
		then npsNumber="$npsNumber"
	elif [ "$stringLength" = "11" ]
		then npsNumber=${npsID}0${npsIDNumber}
	elif [ "$stringLength" = "10" ]
		then npsNumber=${npsID}00${npsIDNumber}
	elif [ "$stringLength" = "9" ]
		then npsNumber=${npsID}000${npsIDNumber}
	elif [ "$stringLength" = "8" ]
		then npsNumber=${npsID}0000${npsIDNumber}
	elif [ "$stringLength" = "7" ]
		then npsNumber=${npsID}00000${npsIDNumber}
	fi

	echo $npsNumber

	#npsNumber=${npsNumber:0:5}00${npsNumber:6:11}
	#wacaNumber=`grep -oh WACA\ [0-9][0-9][0-9][0-9][0-9] ariz_ocr_text.txt`
	#wupaNumber=`grep -oh WUPA\ [0-9][0-9][0-9][0-9][0-9] ariz_ocr_text.txt`
	
	#scur only have 4 numbers
	#scurNumber=`grep -oh SCUR\ [0-9][0-9][0-9][0-9] ariz_ocr_text.txt`

	# Find ariz accession number 
	#arizNumber=`grep -oh Acession No.\ [0-9]* ariz_ocr_text.txt`



	if [ "$npsNumber" != "" ]
		then 
		#cp $f "../SpecimenRenamedJpg/$npsNumber.jpg"
		#cp "../SpecimenOriginalCR2/$c.CR2" "../SpecimenRenamedCR2/$npsNumber.CR2"
		echo "$f renamed to $npsNumber.jpg / .CR2"
	else echo "$f didnt have an nps number"
	fi

	# must put quation marks around variable name and but a $ in front of it
	#cp "$f" copy-"$f" #this copies file f and renames it copy-filenameOfF
done
