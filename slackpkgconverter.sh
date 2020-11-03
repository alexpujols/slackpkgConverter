#!/bin/bash
#: Title	:	slackpkgconverter
#: Date		:	10-28-2020
#: Author	:	"Alex Pujols" <alex.pujols@gmail.com>
#: Version	:	1.0
#: Description  :	Package conversion utility for *.DEB to *.TXZ
#: Options	:	None

########################################################################
# Read in actual kernel image so that we can apply to customize script #
########################################################################

printf "*******************************************************\n"
printf "**                   Warning                         **\n"
printf "*******************************************************\n"
printf "**     This script must be in the same directory     **\n"
printf "**    as the target *.DEB file.  The script must     **\n"
printf "**    be executed by a user with SUDO privledges     **\n"
printf "*****************************************************\n\n"

# Start kernel version entry
printf "What is the name of the DEB package you want to convert to TXZ? \n"
printf "=> "
read package_name
if [ -z "$package_name" ]
then
	echo "No package name entered"
        exit 1 ## Set a failed and return code
fi
# Start confirmation challenge
printf "\n\n"
printf "Are you sure that the package you want to convert is $package_name? (yes/no)\n"
printf "=> "
read answer
if [ -z "$answer" ]
then
        printf "\n\n"
				printf "No confirmation entered"
        exit 1 ## Set a failed and return code
fi

########################################################################
#          Begin kernel build, copy,  and appropriate sorting          #
########################################################################

printf "\n\n"
printf "Making work/pkg directory... \n\n"
mkdir -p work/pkg

printf "Moving into work directory... \n\n"
cd work

printf "Using ar archiver to extract the contents of $package_name... \n\n"
ar -x ../$package_name

printf "Moving into newel extracted pkg directory... \n\n"
cd pkg

printf "Extracting newely created data.tar.gz file... \n\n"
tar xvf ../data.tar.xz

printf "Taking extracted data archive and making new TXZ package...\n\n"
sudo makepkg -l y -c n ../../$package_name.txz

printf "New package named $package_name.txz has been created! \n\n"
