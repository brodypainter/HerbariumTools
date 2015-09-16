#!/bin/bash

#
# run from inside the jpg folder, with the cr2 folder in the same parent
#	
#	-parent folder
#		--SpecimenOriginalCR2
#		--SpecimenOriginalJpg (Run from here)
#		--SpecimenRenamedCR2
#		--SpecimenRenamedJpg
#		--SpecimenRenamedArizJpg

for f in *.jpg
do

	# send sips output to null to make sips a bit quieter
	#sips -r 90 $f > /dev/null
	echo "
Checking file"

	# run the OCR on the current file, use quiet config file to keep tesseract quiet
	tesseract $f ariz_ocr_text quiet

	# Need to detect accession number
	arizAcessionNumber=`egrep -h 'ARIZ\ Accession\ No.\ [0-9]*' ariz_ocr_text.txt`
	arizAcessionNumber=${arizAcessionNumber:19:26}

	echo $arizAcessionNumber

	if [ "$arizAcessionNumber" != "" ]
		then 
		cp $f "../SpecimenRenamedArizJpg/ariz$arizAcessionNumber.jpg"
		echo "$f renamed to ariz$arizAcessionNumber.jpg"
	else echo "$f didnt have an Acession number"
	fi

	# must put quation marks around variable name and but a $ in front of it
	#cp "$f" copy-"$f" #this copies file f and renames it copy-filenameOfF
done
