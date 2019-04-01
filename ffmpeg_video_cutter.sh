#!/bin/bash
#Script that makes using FFMPEG easier to use to clip videos without recoding them.
#Kevin Mostert
#28/03/2019

#Make sure that FFMPEG is installed with apt, else it wont work
if [[ ! -e /usr/bin/ffmpeg ]]
then
	echo "Please use apt to install ffmpeg, this script relies on it."
	return 1
fi

#The -e flag allows autocompetion when using read
read -e -p "Input file:" ifile
#Read the real path instead of sumbolic links
realipath=$(eval realpath -e "$ifile")
#echo "$realipath"

read -e -p "Output file:" realopath
#realopath=$(eval realpath -e "$ofile")
#echo "$realopath"

read -r -p "Time to start the clipping - (D)efault: 00:00:00  " time_s
if [[ "$time_s" =~ [dD(efault)*] ]]
then
	time_s=00:00:00
fi

#read -r -p "Time to end the clip  " time_e
time_e=00:01:00

#read -r "You are about to cut "$realipath" from "$time_s" to "$time_e" - Is this correct (Y/N)?" confirmation
#if [[ $confirmation =~ [yY(es)*] ]]
#then	#Codec copy will copy the codecs as is.
	#Please note that the time mention after -ss operator will be the starting time of the new video from the loaded video. And also note that the time mention after -t operator is the duration of the new video. for example the above command will cut a portion of video from the cut1.mp4 from the time 00 hour,05Minute, and 00sec for a duration of 04 Minute and 25 sec and put it in a new file called cut2.mp4. On otherwise it will cut from 00:05:00 to 00:09:25.
	eval ffmpeg -i $realipath -ss "$time_s" -codec copy -t "$time_e" $realopath
#else
#	echo "Please try again"
#	return 1
#fi
return 0
