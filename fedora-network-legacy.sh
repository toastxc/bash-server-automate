DNF=$(ls /etc/ | grep dnf);

if (( $EUID == 0 )); then
		if (( $DNF == "dnf")); then
			
			echo "Fedora Network Fixer"
			echo "This program will set Fedora networking back to legacy (workstation23)\n"
			echo "THIS PROGRAM DOES NOT COME WITH ANY WARRENTY OR WAY TO RESET FEDORA NETWORKING"
			echo "Do you wish to continue? Y/n"

			read YorN
			
			if [ $YorN = "n" ]; then
				exit
			else
				dnf install crypto-policies-scripts -y
				
				update-crypto-policies --set DEFAULT:FEDORA32

			fi
		else
			echo "This script only works on Fedora based systems"
		fi
	else
		echo "This program requres root"
fi
