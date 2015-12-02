#!/bin/bash

# redirect output
exec 3>&1
exec &> "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444/logfile.txt"

# create output folder
mkdir -p "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444"

# see if application needs running
if [ ! -e "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444/OUT.csv" ]; then
  cd "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//run/4444"
  ln -s "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/dbfiles/PalEON_LINKAGES_site_1-650//climate.Rdata" climate.txt
  
  "/home/ecowdery/linkages_package"
  STATUS=$?
  
  # check the status
  if [ $STATUS -ne 0 ]; then
    echo -e "ERROR IN LINKAGES RUN\nLogile is located at '/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444/logfile.txt'" >&3
    exit $STATUS
  fi
  
  cp OUT.csv /home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444
 
  # convert to MsTMIP
  echo "require (PEcAn.LINKAGES)
model2netcdf.LINKAGES('/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444', 42.53, -72.18, '0850/01/01', '2009/12/31')
" | R --vanilla
fi

# copy readme with specs to output
cp  "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//run/4444/README.txt" "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444/README.txt"

# run getdata to extract right variables

# all done
echo -e "LINKAGES FINISHED\nLogile is located at '/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/output//out/4444/logfile.txt'" >&3
