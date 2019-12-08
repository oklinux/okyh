#!/bin/bash
setupdir="/usr/share/EasyWine"
Xdev="$setupdir/.deman/.lib-Xdialog.so"
username=$USER
homedir=$HOME
tempdir="$homedir/.EasyWine"
if [ ! -e $homedir/.EasyWineLanguage ];then
language="`sed -n '1p' $setupdir/language/.EasyWineLanguage`"
else
language="`sed -n '1p' $homedir/.EasyWineLanguage`"
fi
ok_l="`sed -n '1p' $language`"
cancel_l="`sed -n '2p' $language`"

other_setup()
{
bh_l="`sed -n '351p' $language`"
soft_l="`sed -n '352p' $language`"
othersoft_l="`sed -n '353p' $language`"
$Xdev --title "`sed -n '346p' $language`" \
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
        --menu "`sed -n '347,350p' $language`" 30 50 0 \
  "$bh_l" "$soft_l" \
  'other' "$othersoft_l" 2> /tmp/menuew.tmp
retval=$?

for i in `cat /tmp/menuew.tmp`
do
	choice=$i
done

case $retval in
  0)
#choicechoice

if grep 'other' /tmp/menuew.tmp >& /dev/null;
then
othersoft
fi

;;
  1)
  rm -f /tmp/menuew.tmp
    exit;;
  255)
  rm -f /tmp/menuew.tmp
   exit;;
esac

rm -f /tmp/menuew.tmp
}

othersoft()
{
$Xdev --title "`sed -n '346p' $language`" \
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
        --menu " `sed -n '354,355p' $language` " 11 40 0 \
   "<01>" "Windows 98 `sed -n '356p' $language`" \
   "<02>" "Windows 2000 `sed -n '356p' $language`" 2> /tmp/menu1.tmp

retval=$?

for i in `cat /tmp/menu1.tmp`
do
	choice=$i
done

case $retval in
  0)
if grep '<01>' /tmp/menu1.tmp >& /dev/null;
then
version=win98
fi

if grep '<02>' /tmp/menu1.tmp >& /dev/null;
then
version=win2000
fi

;;
  1)
  rm -f /tmp/menu1.tmp
    other_setup;;
  255)
  rm -f /tmp/menu1.tmp
    other_setup;;
esac

rm -f /tmp/menu1.tmp

if [ "$version" = "win98" ]
then
cp $setupdir/reg/win98.reg $cdrivedir/win98.reg
regedit $cdrivedir/win98.reg
rm $cdrivedir/win98.reg
elif [ "$version" = "win2000" ]
then
cp $setupdir/reg/win2k.reg $cdrivedir/win2k.reg
regedit $cdrivedir/win2k.reg
rm $cdrivedir/win2k.reg
fi
softinstall
cp $setupdir/reg/win98.reg $cdrivedir/win98.reg
regedit $cdrivedir/win98.reg
rm $cdrivedir/win98.reg
}

softinstall()
{
si_l="`sed -n '357p' $language`"
FILE=`$Xdev --stdout --title "$si_l" --fselect $homedir 0 0`
case $? in
	0)
		;;
	1)
		other_setup;;
	255)
		other_setup;;
esac

if [ `which wineserver` ]
then
wineserver -k
else
/usr/lib/wine/wineserver -k
fi

wine $FILE 2>&1 |cat >> $logfile 

wineboot

rm -f $homedir/Desktop/*.lnk
}

if [ ! -z "DISPLAY" ]; then
   if [ $# -eq 0 ]; then
    other_setup
  fi
fi
     
exit 1
