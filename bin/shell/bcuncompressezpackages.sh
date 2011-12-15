#!/bin/bash

# File containing the bcuncompressezpackages.sh script.
# Copyright: Copyright (C) 1999 - 2011 Brookins Consulting. All rights reserved.
# License: http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2 (or later)
# Version: 0.0.4
# Package: bcuncompressezpackages
#
# Description: Uncompress All eZ Packages correctly in current working directory.
# Note: This script provides no validation and is intended only as a last resort, properly executed.
#

# Define default vendor package repository directory path
PKGREPORELPATH=var/storage/packages/eZ-systems;

# Test if directory exists
if [ -d "$PKGREPORELPATH" ]; then
    cd "$PKGREPORELPATH";
fi;

# Test if current directory is package repository directory 
if [[ `pwd` == *$PKGREPORELPATH* ]]; then
    for PKGFILENAME in `ls *.ezpkg`; do 
        PKGFILENAMELENGTH=`expr length $PKGFILENAME - 6`;
        PKGEXTRACTDIRECTORYNAME=${PKGFILENAME:0:$PKGFILENAMELENGTH};
	# Test if package extraction directory already exists
        if [ ! -d "$PKGEXTRACTDIRECTORYNAME" ]; then
            mkdir $PKGEXTRACTDIRECTORYNAME;
            echo "Created package directory: $PKGEXTRACTDIRECTORYNAME"; echo "";
	    echo "Extracting package files into directory: $PKGEXTRACTDIRECTORYNAME"; echo "";
	    # Extract package contents into package extraction directory
	    tar -zxf $PKGFILENAME -C $PKGEXTRACTDIRECTORYNAME;
        else
            echo "Warning! Package directory '$PKGEXTRACTDIRECTORYNAME' already exists. Overwriting existing content with package contents."; echo "";
	    # Extract package contents into package extraction directory
            tar -zxf $PKGFILENAME -C $PKGEXTRACTDIRECTORYNAME;
        fi;
        echo "";
        sleep 0.2;
    done;
    # Alert user to script execution completion. Does not indicate success
    echo "";
    echo "Package extraction complete. Please review directories and contents before proceeding.";
else
    # Alert user to the directory usage problem. They ran script outside eZ Publish directory
    echo "Could not change directory to $PKGREPORELPATH. Consider changing directory first to your eZ Publish root directory before running this script.";
    echo "";
fi;

# Exit script normally
exit 0;
