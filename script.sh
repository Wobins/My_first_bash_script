#!/bin/bash


#Ce script cree un nombre de fichiers en fonction du nombre entre en saisie lors de l'execution du script
#Si des fichiers sont deja crees alors il cree de nouveaux en fonction du nombre entre en saisi
#Ces fichiers ont des extensions attribuees aleatoirement
#Les groupes proprietaires de ces fichiers sont attribues suivant leurs extensions


extensions=("csv" "css" "js" "py")

if [ $1 -le 0 ]
then
	echo "Impossible de creer des fichiers."
	echo Veuillez reexecuter le script en entrant un entier positif en saisie.
else

	search=`find . -name 'file*' | wc -l `  #compter le nombre de fichiers existants

	if [ $search -gt 0 ] 	#cas ou les fichiers sont deja crees
	then
		max=$((search + $1))
	       	min=$((search + 1))	
		echo Il existe $search file et le max sera $max
		
		n=$min
		until [ $n -gt $max ]
		do
			x=$RANDOM%4
			ex=${extensions[$x]}

			touch file$n.$ex
			
			((n++))
		done


	else 	#cas ou les fichiers ne sont pas encore crees


		for ((i=1; i <= $1 ; i++))
		do
			x=$RANDOM%4
			ex=${extensions[$x]}

			touch file$i.$ex
		done
	fi
	

	#Attribution des groupes
	ls *csv | xargs chgrp analyst
	find . -name 'file*.css' -exec chgrp designer '{}' \;
	find . -name 'file*.[pj][sy]' -exec chgrp devops '{}' \;


fi
