#!/bin/bash

declare -i area=1
space="/home/${LOGNAME}"
cd ${space}

declare -a select=()
declare -i countselect=0

#배경
background() {

clear
tput cup 0 0
echo [46m[30m"File Explorer                                                                      "[0m
echo [47m[30m"-----------------------------------------------------------------------------------"
echo [47m[30m"|                                                                                 |"[0m
echo [47m[30m"-----------------------------------------------------------------------------------"[0m
for (( i=0; i<20; i++ ))
do
	echo [47m[30m"|                                        |                                        |"[0m
done

echo [47m[30m"-----------------------------------------------------------------------------------"[0m
echo [47m[30m"|                                                                                 |"[0m
echo [47m[30m"-----------------------------------------------------------------------------------"[0m
}

info() {

for dir in `ls -a | sort -f`
do
	if [ -d "${dir}" ]
	then
		dirarr[$countdir]=${dir}
		countdir=$countdir+1
		wholearr[$countwhole]=${dir}
		countwhole=$countwhole+1
	fi
done

touch storeinfo.txt
toush store.txt
for file in `ls -a | find -name '*.c' | sort -f`
do
	echo "${file}" >> storeinfo.txt
done
cut -d "/" -f 2 storeinfo.txt >& store.txt
carr=(`cat store.txt | grep -w ".*\.c"`)
countc=${#carr[@]}
rm -rf storeinfo.txt
rm -rf store.txt

for (( i=0; i<${countc}; i++ ))
do
	wholearr[$countwhole]=${carr[i]}
	countwhole=$countwhole+1
done
	
touch storeinfo.txt
touch store.txt
for file in `ls -a | find -name '*.h' | sort -f`
do
	echo "${file}" >> storeinfo.txt
done
cut -d "/" -f 2 storeinfo.txt >& store.txt
harr=(`cat store.txt | grep -w ".*\.h"`)
counth=${#harr[@]}
rm -rf storeinfo.txt
rm -rf store.txt

for (( i=0; i<${counth}; i++ ))
do
	wholearr[$countwhole]=${harr[i]}
	countwhole=$countwhole+1
	
done
}

printinfo() {

background

tput cup 2 1
echo [47m[30m"Current path: ${PWD}"

tput cup 25 5
echo [47m[30m"C file : ${countc}"
tput cup 25 25
echo [47m[30m"Header : ${counth}"

declare -i first=$1
declare -i last=$2
declare -i yy=4

touch storeinfo.txt
touch store.txt

for (( i=${first}; i<${last}; i++ ))
do
	tput cup $yy 1
	if [ $i -lt ${countdir} ]
	then
		echo [47m[34m"${wholearr[$i]}"

		if [ "${wholearr[$i]}" = "." ]
		then
			namei -m ${wholearr[$i]} >& storeinfo.txt
			tail -1 storeinfo.txt >& store.txt
			info=`cut -d " " -f 2 store.txt`
			tput cup $yy 17
			echo "${info}"
			tput cup $yy 35
			echo "-"
		elif [ "${wholearr[$i]}" = ".." ]
		then
			namei -m ${wholearr[i]} >& storeinfo.txt
			tail -1 storeinfo.txt >& store.txt
			info=`cut -d " " -f 2 store.txt`
			tput cup $yy 17
			echo "${info}"
			tput cup $yy 35
			echo "-"
		else
			size=`du -hs ${wholearr[$i]} | cut -f 1`
			namei -m ${wholearr[i]} >& storeinfo.txt
			tail -1 storeinfo.txt >& store.txt
			info=`cut -d " " -f 2 store.txt`
			tput cup $yy 17
			echo ${info}
			tput cup $yy 35
			echo ${size}
		fi
	elif [ $i -lt ${cc} ]
	then
		echo [47m[32m"${wholearr[$i]}"
		size=`du -hs ${wholearr[$i]} | cut -f 1`
		namei -m ${wholearr[i]} >& storeinfo.txt
		tail -1 storeinfo.txt >& store.txt
		info=`cut -d " " -f 2 store.txt`
		tput cup $yy 17
		echo ${info}
		tput cup $yy 35
		echo ${size}
	else
		echo [47m[30m"${wholearr[$i]}"
		size=`du -hs ${wholearr[$i]} | cut -f 1`
		namei -m ${wholearr[i]} >& storeinfo.txt
		tail -1 storeinfo.txt >& store.txt
		info=`cut -d " " -f 2 store.txt`
		tput cup $yy 17
		echo ${info}
		tput cup $yy 35
		echo ${size}
	fi
	yy=$yy+1
done

rm -rf storeinfo.txt
rm -rf store.txt
}

# 글자색 반대로 뒤집는거
printrev() {

touch storeinfo.txt
touch store.txt

if [ $1 -lt ${countdir} ]
then	
	tput cup $2 1
	echo [44m"|                                       "[0m
	tput cup $2 1
	echo [44m[37m"${wholearr[$1]}"

	if [ "${wholearr[$1]}" = "." ]
	then
		namei -m ${wholearr[$1]} >& storeinfo.txt
		tail -1 storeinfo.txt >& store.txt
		info=`cut -d " " -f 2 store.txt`
		tput cup $2 17
		echo "${info}"
		tput cup $2 35
		echo "-"[0m
	elif [ "${wholearr[$1]}" = ".." ]
	then
		namei -m ${wholearr[$1]} >& storeinfo.txt
		tail -1 storeinfo.txt >& store.txt
		info=`cut -d " " -f 2 store.txt`
		tput cup $2 17
		echo "${info}"
		tput cup $2 35
		echo "-"[0m
	else
		size=`du -hs ${wholearr[$1]} | cut -f 1`
		namei -m ${wholearr[$1]} >& storeinfo.txt
		tail -1 storeinfo.txt >& store.txt
		info=`cut -d " " -f 2 store.txt`
		tput cup $2 17
		echo ${info}
		tput cup $2 35
		echo ${size}[0m
	fi
elif [ $1 -lt ${cc} ]
then
	tput cup $2 1
	echo [42m"|                                       "[0m
	tput cup $2 1
	echo [42m[37m"${wholearr[$1]}"
	size=`du -hs ${wholearr[$1]} | cut -f 1`
	namei -m ${wholearr[$1]} >& storeinfo.txt
	tail -1 storeinfo.txt >& store.txt
	info=`cut -d " " -f 2 store.txt`
	tput cup $2 17
	echo ${info}
	tput cup $2 35
	echo ${size}[0m
else
	tput cup $2 1
	echo [40m"|                                       "[0m
	tput cup $2 1
	echo [40m[37m"${wholearr[$1]}"
	size=`du -hs ${wholearr[$1]} | cut -f 1`
	namei -m ${wholearr[$1]} >& storeinfo.txt
	tail -1 storeinfo.txt >& store.txt
	info=`cut -d " " -f 2 store.txt`
	tput cup $2 17
	echo ${info}
	tput cup $2 35
	echo ${size}[0m
fi

rm -rf storeinfo.txt
rm -rf store.txt
}

selectfile() {

touch storeinfo.txt
touch store.txt

orderarr=()
order=0

mainarr=()
countm=0

ccarr=()
ccount=0

hharr=()
hcount=0

for (( i=0; i<${countselect}; i++ ))
do
	grep -l "int main()" ${PWD}/${select[i]} >& storeinfo.txt
	rev storeinfo.txt >& store.txt
	cut -d "/" -f 1 store.txt >& storeinfo.txt
	file=`rev storeinfo.txt`
	if [ "${file}" = "${select[i]}" ]
	then
		mainarr[$countm]=${file}
		countm=$countm+1
	else
		for (( j=0; j<${countc}; j++ ))
		do	
			if [ "${select[i]}" = "${carr[j]}" ]
			then
				ccarr[$ccount]=${select[i]}
				ccount=$ccount+1
			fi
		done

		for (( j=0; j<${counth}; j++ ))
		do
			if [ "${select[i]}" = "${harr[j]}" ]
			then
				hharr[$hcount]=${select[i]}
				hcount=$hcount+1
			fi
		done
	fi
done

for (( i=0; i<$countm; i++ ))
do
	orderarr[$order]=${mainarr[i]}
	order=$order+1
done

for (( i=0; i<$ccount; i++ ))
do
	orderarr[$order]=${ccarr[i]}
	order=$order+1
done

for (( i=0; i<$hcount; i++ ))
do
	orderarr[$order]=${hharr[i]}
	order=$order+1
done

if [ ${order} -gt 20 ]
then
	start2=0
	finish2=20
	count_fi2=21
	line2=23
	version2=1
else
	start2=0
	finish2=${order}
	count_fi2=${order}+1
	line2=${order}+3
	version2=2
fi

rm -rf storeinfo.txt
rm -rf store.txt
}

printselect() {

declare -i bb=${countm}+${ccount}
declare -i yp=4

for (( i=$1; i<$2; i++ ))
do
	if [ $i -lt ${countm} ]
	then	
		tput cup $yp 42
		echo [31m"${orderarr[$i]}"
	elif [ $i -lt ${bb} ]
	then
		tput cup $yp 42
		echo [32m"${orderarr[$i]}"
	else
		tput cup $yp 42
		echo [30m"${orderarr[$i]}"
	fi
	yp=$yp+1
done
}

selectrev() {

declare -i dd=${countm}+${ccount}

if [ $1 -lt ${countm} ]
then	
	tput cup $2 42
	echo [41m"|                                       "[0m
	tput cup $2 42
	echo [41m[37m"${orderarr[$1]}"[0m
elif [ $1 -lt ${dd} ]
then
	tput cup $2 42
	echo [42m"|                                       "[0m
	tput cup $2 42
	echo [42m[37m"${orderarr[$1]}"[0m
else
	tput cup $2 42
	echo [40m"|                                       "[0m
	tput cup $2 42
	echo [40m[37m"${orderarr[$1]}"[0m
fi
}

keyboard() {

declare -a dirarr=()
declare -i countdir=0

declare -a carr=()
declare -i countc=0

declare -a harr=()
declare -i counth=0

declare -a wholearr=()
declare -i countwhole=0

declare -i a=0
declare -i b=0
declare -i c=0
declare -i d=0
declare -i ff=0
declare -i overlap=0
declare -i exist=0

declare -a orderarr=()
declare -i order=0

declare -a mainarr=()
declare -i countm=0

declare -a ccarr=()
declare -i ccount=0

declare -a hharr=()
declare -i hcount=0

info

declare -i cc=${countdir}+${countc}

declare -i ypoint=4
declare -i index=0
declare -i index2=0

if [ ${countwhole} -gt 20 ]
then
	declare -i start=0
	declare -i finish=20
	declare -i count_fi=21
	declare -i line=23
	declare -i version=1
else
	declare -i start=0
	declare -i finish=${countwhole}
	declare -i count_fi=${countwhole}+1
	declare -i line=${countwhole}+3
	declare -i version=2
fi

declare -i start2=0
declare -i finish2=20
declare -i count_fi2=21
declare -i line2=23
declare -i version2=1

printinfo $start $finish
selectfile
printselect $start2 $finish2
printrev $index $ypoint
tput cup $ypoint 0 
while true
do
	read -sN1 key_1
	if [ "${key_1}" = "" ]
	then
		read -sN2 key_2

		if [ "${key_2}" = "[A" ]
		then
			if [ ${area} -eq 1 ]
			then
				if [ ${ypoint} -eq 4 ]
				then
					if [ ${start} -gt 0 ]
					then
						start=${start}-1
						finish=${finish}-1
						count_fi=${count_fi}-1
						index=$index-1
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						printrev $index $ypoint
					else
						if [ ${version} -eq 1 ]
						then
							count_fi=${countwhole}+1
							index=${countwhole}-1
							ypoint=23
							finish=$countwhole
							start=${finish}-20
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							printrev $index $ypoint
						else
							index=${countwhole}-1
							ypoint=${countwhole}+3
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							printrev $index $ypoint
						fi
					fi
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					ypoint=$ypoint-1
					index=$index-1
					printrev $index $ypoint
				fi
			elif [ ${area} -eq 2 ]
			then
				if [ ${ypoint} -eq 4 ]
				then
					if [ ${start2} -gt 0 ]
					then
						start2=${start2}-1
						finish2=${finish2}-1
						count_fi2=${count_fi2}-1
						index2=$index2-1
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						selectrev $index2 $ypoint
					else
						if [ ${version2} -eq 1 ]
						then
							count_fi2=${order}+1
							index2=${order}-1
							ypoint=23
							finish2=$order
							start2=${finish2}-20
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							selectrev $index2 $ypoint
						else
							index2=${order}-1
							ypoint=${order}+3
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							selectrev $index2 $ypoint
						fi
					fi
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					ypoint=$ypoint-1
					index2=$index2-1
					selectrev $index2 $ypoint
				fi

			fi
		elif [ "${key_2}" = "[B" ]
		then
			if [ ${area} -eq 1 ]
			then
				if [ ${ypoint} -eq ${line} ]
				then
					if [ ${countwhole} -ge ${count_fi} ]
					then
						start=${start}+1
						finish=${finish}+1
						count_fi=$count_fi+1
						index=$index+1
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						printrev $index $ypoint
					else
						if [ ${version} -eq 1 ]
						then
							count_fi=21
							index=0
							ypoint=4
							start=0
							finish=20
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							printrev $index $ypoint
						else
							index=0
							ypoint=4
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							printrev $index $ypoint
						fi
					fi
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					ypoint=$ypoint+1
					index=$index+1
					printrev $index $ypoint
				fi
			elif [ ${area} -eq 2 ]
			then
				if [ ${ypoint} -eq ${line2} ]
				then
					if [ ${order} -ge ${count_fi2} ]
					then
						start2=${start2}+1
						finish2=${finish2}+1
						count_fi2=$count_fi2+1
						index2=$index2+1
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						selectrev $index2 $ypoint
					else
						if [ ${version2} -eq 1 ]
						then
							count_fi2=21
							index2=0
							ypoint=4
							start2=0
							finish2=20
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							selectrev $index2 $ypoint
						else
							index2=0
							ypoint=4
							printinfo $start $finish
							selectfile
							printselect $start2 $finish2
							selectrev $index2 $ypoint
						fi
					fi
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					ypoint=$ypoint+1
					index2=$index2+1
					selectrev $index2 $ypoint
				fi

			fi
		elif [ "${key_2}" = "[D" ]
		then
			if [ ${area} -eq 1 ]
			then
				if [ ${order} -eq 0 ]
				then
					continue
				else
					area=2
					if [ ${ypoint} -lt ${line2} ]
					then
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						index2=${start2}+${ypoint}-4
						selectrev $index2 $ypoint
					else
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						index2=${start2}+${order}-1
						ypoint=${line2}
						selectrev $index2 $ypoint
					fi
				fi
				
			elif [ ${area} -eq 2 ]
			then
				area=1
				if [ ${ypoint} -lt ${line} ]
				then
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					index=${start}+${ypoint}-4
					printrev $index $ypoint
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					index=${start}+${countwhole}-1
					ypoint=${line}
					printrev $index $ypoint
					
				fi
			fi
		elif [ "${key_2}" = "[C" ]
		then
			if [ ${area} -eq 1 ]
			then
				if [ ${order} -eq 0 ]
				then
					continue
				else
					area=2
					if [ ${ypoint} -lt ${line2} ]
					then
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						index2=${start2}+${ypoint}-4
						selectrev $index2 $ypoint
					else
						printinfo $start $finish
						selectfile
						printselect $start2 $finish2
						index2=${start2}+${order}-1
						ypoint=${line2}
						selectrev $index2 $ypoint
					fi
				fi
			elif [ ${area} -eq 2 ]
			then
				area=1
				if [ ${ypoint} -lt ${line} ]
				then
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					index=+${start2}+${ypoint}-4
					printrev $index $ypoint
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					index=${start}+${countwhole}-1
					ypoint=$line
					printrev $index $ypoint
					
				fi
			fi
		fi
	elif [ "${key_1}" = "" ]
	then
		if [ ${area} -eq 1 ]
		then
			if [ -d ${wholearr[$index]} ]
			then
				if [ "${wholearr[$index]}" = "." ]
				then
					continue
				elif [ "${wholearr[$index]}" = ".." ]
				then
					cd ${wholearr[$index]}
					keyboard
				else
					cd ${wholearr[$index]}
					keyboard
				fi
			elif [ -f ${wholearr[$index]} ]
			then
				overlap=0

				for (( a=0; a<${countselect}; a++ ))
				do
					if [ "${wholearr[$index]}" = "${select[$a]}" ]
					then
						overlap=1
						break
					fi
				done
				if [ ${overlap} -eq 0 ]
				then
					select[$countselect]=${wholearr[$index]}
					countselect=$countselect+1
				fi
				printinfo $start $finish
				selectfile
				printselect $start2 $finish2
				printrev $index $ypoint
			fi
		fi
	elif [ "${key_1}" = "d" ]
	then
		if [ ${area} -eq 2 ]
		then
			b=${order}-1
			for (( i=$index2; i<${b}; i++ ))
			do
				c=${i}+1
				orderarr[i]="${orderarr[$c]}"
			done
			order=${order}-1
			for (( i=0; i<$order; i++ ))
			do
				select[i]=${orderarr[i]}
			done
			countselect=$order
			
			if [ $countselect -eq 0 ]
			then
				area=1
				printinfo $start $finish
				selectfile
				index=${start}+${ypoint}-4
				printrev $index $ypoint
			else
				if [ $ypoint -eq $line2 ]
				then
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					ypoint=${ypoint}-1
					index2=${index2}-1
					selectrev $index2 $ypoint	
				else
					printinfo $start $finish
					selectfile
					printselect $start2 $finish2
					selectrev $index2 $ypoint
				fi
			fi
		fi
	elif [ "${key_1}" = "m" ]
	then
		exist=0
		if [ ${countm} -eq 0 ]
		then
			exist=1
		fi

		if [ ${exist} -eq 0 ]
		then
			touch Makefile

			echo -n "2019204034.out : " >> Makefile
			for (( i=0; i<${countm}; i++ ))
			do
				echo -n "${mainarr[i]/.c/.o} " >> Makefile
			done
			for (( i=0; i<${ccount}; i++ ))
			do
				echo -n "${ccarr[i]/.c/.o} " >> Makefile
			done
			echo " " >> Makefile
			echo -n "	gcc " >> Makefile
			for (( i=0; i<${countm}; i++ ))
			do
				echo -n "${mainarr[i]/.c/.o} " >> Makefile
			done
			for (( i=0; i<${ccount}; i++ ))
			do
				echo -n "${ccarr[i]/.c/.o} " >> Makefile
			done
			echo "-o 2019204034.out" >> Makefile
			
			for (( i=0; i<${countm}; i++ ))
			do
				echo -n "${mainarr[i]/.c/.o} : " >> Makefile
				echo -n "${mainarr[i]} " >> Makefile
				ff=${ccount}+1
				for (( j=${ff}; j<${order}; j++ ))
				do
					echo -n "${orderarr[j]} " >> Makefile
				done
				echo " " >> Makefile
				echo "	gcc -c ${mainarr[i]}" >> Makefile
			done

			for (( i=0; i<${ccount}; i++ ))
			do
				echo -n "${ccarr[i]/.c/.o} : " >> Makefile
				echo -n "${ccarr[i]} " >> Makefile
				for (( j=0; j<${hcount}; j++ ))
				do
					file=`grep -l "${hharr[j]}" ${ccarr[i]}`
					if [ -n "${file}" ]
					then
						echo -n "${hharr[j]} " >> Makefile
					fi
				done
				echo " " >> Makefile
				echo "	gcc -c ${ccarr[i]}" >> Makefile
			done

			echo "clean :" >> Makefile
			echo "	rm -f *.o" >> Makefile

			tput cup 27 0
			exit 0
		fi
	fi
done
}

tput smcup
tput civis

keyboard

tput cnorm
tput rmcup
