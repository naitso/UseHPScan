#!/bin/bash
#
#####################################################
#
# autor: naitso
# date: 2014/03/28
# 
# required: hplip
#
# description:
# This script semplify the use of hp-scan utility to
# scan document from linux terminal
#
# Tested with my HP Laserjet M1212nf 
# installed on slackware64 13.37
#
# 20140908 tested on Slackware64 14.1
# 20140908 added ADF mode, note only pdf output is supported
#####################################################


COMMAND="hp-scan"
CWD=$(pwd)
	
	clear
	echo ""
	echo "Write FILENAME and press ENTER"
	echo "(ascii only no fancy character: a-z and - or _)"
	echo ""
	read NAME

	# the SPACE will be replaced by -
	FILENAME=$(echo "$NAME" | sed -e "s/ /-/g" | sed -e "s/[ \t]//g")

OUTPUT=$CWD/$FILENAME

function Resolution() {
# flags: -r
# valid resolutions are 75, 100, 150, 200, 300, 600, 1200 dpi
	while [ RDPI != "0" ]
		do
		clear
		echo ""
		echo "Choose Resolution"
		echo "a) 75dpi"
		echo "b) 100dpi"
		echo "c) 150dpi"
		echo "d) 200dpi"
		echo "e) 300dpi"
		echo "f) 600dpi"
		echo "g) 1200dpi"
		echo "q) quit"
		read RDPI

		case "$RDPI" in 
			a | A )
			COMMAND="$COMMAND -r 75"
			PaperSize
		;;
			b | B )
			COMMAND="$COMMAND -r 100"
			PaperSize
		;;
			c | C )
			COMMAND="$COMMAND -r 150"
			PaperSize
		;;
			d | D )
			COMMAND="$COMMAND -r 200"
			PaperSize
		;;
			e | E )
			COMMAND="$COMMAND -r 300"
			PaperSize
		;;
			f | F )
			COMMAND="$COMMAND -r 600"
			PaperSize
		;;
			g | G )
			COMMAND="$COMMAND -r 1200"
			PaperSize
		;;
			q | Q )
			echo "Quit"
			exit 0
		;;
			* ) clear
			echo "Choose only 'a',b,c,d,e,f,g' or 'q' to exit"
			sleep 2
		esac

		echo "Press ENTER to return menu"
		read key
		done
		exit 0
}

function PaperSize() {
#####################################################
# flags: --size 
#
# <paper size name> is one of: 
# 5x7, photo, a2_env, b4, b5, 3x5, 4x6, higaki, 
# flsa, c6_env, legal, no_10_env, exec, a3, a5, 
# a4, letter, a6, super_b, oufufu-hagaki, dl_env, 
# japan_env_4, japan_env_3
#
#####################################################

	while [ RSIZE != "0" ]
		do
		clear
		echo ""
		echo "Choose paper size"
		echo "a) A6"
		echo "b) A5"
		echo "c) A4"
		echo "d) 5x7"
		echo "e) photo"
		echo "f) letter"
		echo "q) quit"
		read RSIZE
	
		case "$RSIZE" in 
			a | A )
			COMMAND="$COMMAND --size a6"
			FileTipe
		;;
			b | B )
			COMMAND="$COMMAND --size a5"
			FileTipe
		;;
			c | C )
			COMMAND="$COMMAND --size a4"
			FileTipe
		;;
			d | D )
			COMMAND="$COMMAND --size 5x7"
			FileTipe
		;;
			e | E )
			COMMAND="$COMMAND --size photo"
			echo $COMMAND
			FileTipe
		;;
			f | F )
			COMMAND="$COMMAND --size letter"
			FileTipe
		;;
			q | Q )
			echo "Quit"
			exit 0
		;;
			* ) clear
			echo "Choose only 'a,b,c,d,e,f' or 'q' to exit"
			sleep 2
		esac
	
		echo "Press ENTER to return menu"
		read key
		done
		exit 0
}

function FileTipe() {
#####################################################
# flags:-s
#
# <dest_list> is a comma separated list containing 
# one or more of: 'file'*, 'viewer', 'editor', 'pdf', 
# or 'print'. Use only commas between values, no spaces.
#
# viewer: Only JPG (.jpg), PNG (.png) and PDF (.pdf) output files are supported.
#
#####################################################
while [ RTIPE != "0" ]
		do
		clear
		echo ""
		echo "Choose file type"
		echo "a) image (.jpg)"
		echo "b) pdf"
		echo "c) print"
		echo "q) quit"
		read RTIPE
	
		case "$RTIPE" in 
			a | A )
			COMMAND="$COMMAND -s jpg -o $OUTPUT.jpg"
			echo $COMMAND
			$COMMAND
			exit
		;;
			b | B )
			COMMAND="$COMMAND -s pdf -o $OUTPUT.pdf"
			echo $COMMAND
			$COMMAND
			exit
		;;
			c | C )
			COMMAND="$COMMAND -s print"
			echo $COMMAND
			$COMMAND
			exit
		;;
			q | Q )
			echo "Quit"
			exit 0
		;;
			* ) clear
			echo "Choose only 'a,b,c' or 'q' to exit"
			sleep 2
		esac
	
		echo "Press ENTER to return menu"
		read key
		done
		exit 0


}

function ColorMode() {
	while [ RCOLOR != "0" ]
		do
		clear
		echo "Choose scan color mode"
		echo "a) gray"
		echo "b) color"
		echo "c) linear"
		echo "q) quit"
		read RCOLOR
	
		case "$RCOLOR" in 
			a | A )
			COMMAND="$COMMAND -m gray"
			echo $COMMAND
			Resolution
		;;
			b | B )
			COMMAND="$COMMAND -m color"
			echo $COMMAND
			Resolution
		;;
			c | C )
			COMMAND="$COMMAND -m linear"
			echo $COMMAND
			Resolution
		;;
			q | Q )
			echo "Quit"
			exit 0
		;;
			* ) clear
			echo "Choose only 'a,b,c' or 'q' to exit"
			sleep 2
		esac
	
		echo "Press ENTER to return menu"
		read key
		done
		exit 0
}

function InputMode() {
	while [ RMODE != "0" ]
	do
		clear
		echo "HP Linux Imaging and Printing System - Scan Utility"
		echo ""
		echo "Would you like to use ADF mode?"
		echo ""
		echo "a) YES (ONLY pdf output is supported)"
		echo "b) NO"
		echo "q) quit"
		read RMODE

		case "$RMODE" in
			a | A)
				COMMAND="$COMMAND --adf"
				ColorMode
		;;
			b | B) 
				COMMAND="$COMMAND"
				ColorMode
		;;
			q | Q)
				echo "Quit"
				exit 0
		;;
			* ) clear
			echo "Choose only 'a,b' or 'q' to exit"
			sleep 2
		esac
		echo "Press ENTER to return menu"
		read key
	done
	exit 0

}

InputMode
#ColorMode


