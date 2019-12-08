#!/bin/sh
PATH=.:/bin:/usr/bin:/usr/local/bin:/sbin:$PATH
export PATH
today=`date +%y%m%d%H%M`
username=$USER
homedir=$HOME
setupdir="/usr/share/okyh/EasyWine"
tempdir="$homedir/.EasyWine"
EWVER="EasyWine 3.0 RC2 for OKYH"
cs="EW"
if [ ! -e $homedir/.EasyWineLanguage ];then
language="`sed -n '1p' $setupdir/language/.EasyWineLanguage`"
else
language="`sed -n '1p' $homedir/.EasyWineLanguage`"
fi
yhm=""
yhmm=""
Xdev="$setupdir/.deman/.lib-Xdialog.so"

label="EasyWine" 
cdrivedir=""
logfile="$homedir/.wine/EasyWine/wcs.log"
ok_l="`sed -n '1p' $language`"
cancel_l="`sed -n '2p' $language`"
pv_l="`sed -n '3p' $language`"
ne_l="`sed -n '4p' $language`"
qx_l="`sed -n '186p' $language`"

xh=1
if [ ! -e $Xdev ];then
  echo "There is not graphics library"
  exit
elif [ "OK$DISPLAY" = "OK" ]; then
  echo "Now you are not on Desktop"
  exit
else
   SFTX=Y
fi

txwk()
{
$Xdev --ok-label "$ok_l" --stdout --title "$EWVER" --$1 "$2" 0 0
ok=$?
}

while [ $# -gt 0 ] ; do
  case "$1" in
ewmenu)  cs="ewmenu"; shift 1 ;;
  esac
done

if [ $cs = "ewmenu" ]; then
EWCONFIG="none"
fi

if [ -f $homedir/.EasyWineConfig ] ; then
$Xdev --wrap \
      --title "$EWVER" \
	 --ok-label "`sed -n '5p' $language`" \
	--cancel-label "`sed -n '6p' $language`" \
      --yesno "`sed -n '7,8p' $language`" 0 0
 
 case $? in
	0)rm -r -f $homedir/.EasyWineConfig;;
	1);;
	255) exit;;
esac
fi

if [ -f $homedir/.EasyWineConfig ] ; then
for i in `cat $homedir/.EasyWineConfig`
do
	input=$i
done
  if [ "$input" = "" ]
  then
   cdrivedir="$homedir/.wine_c"
  else
   cdrivedir="$input"
  fi
else

if [  ! -e $tempdir ] 
then
mkdir $tempdir
fi

$Xdev --title "`sed -n '9p' $language`" \
	 --ok-label "$ok_l" \
	--cancel-label "`sed -n '10p' $language`" \
--inputbox "`sed -n '11,14p' $language`

$homedir/.wine_c \n 

`sed -n '15p' $language`" 16 50 2> $homedir/.EasyWineConfig

retval=$?

for i in `cat $homedir/.EasyWineConfig`
do
	input=$i
done

case $retval in
  0)
    ;;
  1)
    exit;;
  255)
    exit;;
esac


  if [ "$input" = "" ]
  then
   cdrivedir="$homedir/.wine_c"
  else
   cdrivedir="$input"
  fi
fi

EasyWine_setup()
{
rm -f $homedir/.wine/tmp/menu.tmp

if [ $language = "$setupdir/language/en_US.txt" ];then
$Xdev --title "$EWVER" \
      --icon $setupdir/xpm/ew.xpm \
      --cancel-label "Exit" \
      --ok-label "OK" \
      --menu "\n" 0 0 0 \
   "<01>" "Initialize Wine configuration" \
   "<02>" "Internet Exploer 6.0 Install Guide" \
   "<03>" "Install QQ2005 Beta2" \
   "<04>" "Install other Windows software" \
   "<05>" "Wine Install Guide from source" \
   "<06>" "EasyWine Deluxe Options" \
   "<07>" "About EasyWine" 2> /tmp/menu.tmp.$$
else
$Xdev --title "$EWVER" \
      --icon $setupdir/xpm/ew.xpm \
      --cancel-label "`sed -n '10p' $language`" \
      --ok-label "$ok_l" \
      --menu "\n" 0 0 0 \
   "<01>" "`sed -n '16p' $language`" \
   "<02>" "`sed -n '17p' $language`" \
   "<03>" "`sed -n '18p' $language`" \
   "<04>" "`sed -n '19p' $language`" \
   "<05>" "`sed -n '20p' $language`" \
   "<06>" "`sed -n '21p' $language`" \
   "<07>" "`sed -n '22p' $language`" 2> /tmp/menu.tmp.$$
fi

retval=$?

for i in `cat /tmp/menu.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menu.tmp.$$ >& /dev/null;
then
if [ -f "$logfile" ] ; then
$Xdev --wrap \
      --title "$EWVER" \
	 --ok-label "`sed -n '23p' $language`" \
	--cancel-label "`sed -n '24p' $language`" \
      --yesno "$username `sed -n '25,28p' $language`" 0 0

case $? in
  0)
rm -f /tmp/menu.tmp.$$
    EasyWine_1;;
  1)
rm -f /tmp/menu.tmp.$$
    EasyWine_setup;;
255)
rm -f /tmp/menu.tmp.$$
    EasyWine_setup;;
esac
fi
rm -f /tmp/menu.tmp.$$
EasyWine_1
fi

if grep "<02>" /tmp/menu.tmp.$$ >& /dev/null;
then
rm -f /tmp/menu.tmp.$$
warn1
EasyWine_2
fi

if grep "<03>" /tmp/menu.tmp.$$ >& /dev/null;
then
rm -f /tmp/menu.tmp.$$
warn1
EasyWine_4
fi

if grep "<04>" /tmp/menu.tmp.$$ >& /dev/null;
then
rm -f /tmp/menu.tmp.$$
warn1
EasyWine_5
fi

if grep "<05>" /tmp/menu.tmp.$$ >& /dev/null;
then
rm -f /tmp/menu.tmp.$$
EasyWine_9
fi

if grep "<06>" /tmp/menu.tmp.$$ >& /dev/null;
then
rm -f /tmp/menu.tmp.$$
EasyWine_20
fi

if grep "<07>" /tmp/menu.tmp.$$ >& /dev/null;
then
rm -f /tmp/menu.tmp.$$
EasyWine_7
fi

;;
  1)
  rm -f /tmp/menu.tmp.$$
    exit 1;;
  255)
  rm -f /tmp/menu.tmp.$$
    exit 1;;
esac

rm -f /tmp/menu.tmp.$$
}

EasyWine_1()
{
if [ ! `which wine` ]
then
  txwk msgbox "`sed -n '29,30p' $language`"
 EasyWine_setup
fi

localegu

echo "`wine --version`" >/tmp/wineversion.tmp.$$
wineversionl="`sed -n '/Wine/=' /tmp/wineversion.tmp.$$`"
if [ "$wineversionl" = "1" ]
then
wineversion="`sed -n '1p' /tmp/wineversion.tmp.$$`"
else
wineversion="`sed -n '2p' /tmp/wineversion.tmp.$$`"
fi
rm -f /tmp/wineversion.tmp.$$

if  [ "$wineversion" = "Wine 20050830" ] || [ "$wineversion" = "Wine 20050930" ] || [ "$wineversion" = "Wine 0.9" ] || [ "$wineversion" = "Wine 0.9.1" ] || [ "$wineversion" = "Wine 0.9.2" ] || [ "$wineversion" = "Wine 0.9.3" ]
then
winec=new
elif [ "$wineversion" = "Wine 0.9.4" ] || [ "$wineversion" = "Wine 0.9.5" ] || [ "$wineversion" = "Wine 0.9.6" ] || [ "$wineversion" = "Wine 0.9.7" ] || [ "$wineversion" = "Wine 0.9.8" ] || [ "$wineversion" = "Wine 0.9.9" ] || [ "$wineversion" = "Wine 0.9.10" ]
then
winec=094
elif [ "$wineversion" = "Wine 0.9.11" ] || [ "$wineversion" = "Wine 0.9.12" ] || [ "$wineversion" = "Wine 0.9.13" ] || [ "$wineversion" = "Wine 0.9.14" ] || [ "$wineversion" = "Wine 0.9.15" ] || [ "$wineversion" = "Wine 0.9.16" ] || [ "$wineversion" = "Wine 0.9.17" ] || [ "$wineversion" = "Wine 0.9.18" ] || [ "$wineversion" = "Wine 0.9.19" ] || [ "$wineversion" = "Wine 0.9.20" ]
then
winec=911
else
winec=old
fi

if [ ! `which wineserver` ] && [ ! -e /usr/lib/wine/wineserver ]
then
 txwk msgbox "`sed -n '31p' $language`"
 exit 1
fi

if [ ! -e $setupdir/wineconfig ] || [ ! -e $setupdir/inf ]
then
 txwk msgbox " `sed -n '32p' $language`"
 exit 1
fi

if [ "$DISPLAY" = "" ]
then

 txwk msgbox "`sed -n '33p' $language`"
 
 exit 1
fi

if [ -e ~/.wine ]
 then
 if [ `which wineserver` ]
 then
  wineserver -k
 else
  /usr/lib/wine/wineserver -k
 fi
else
 mkdir ~/.wine
 if [ `which wineserver` ]
 then
  wineserver -k
 else
  /usr/lib/wine/wineserver -k
 fi
 rm -rf ~/.wine
fi

if [ -e ~/.wine ]
then
if [ -n "$cdrivedir" -a -e "$cdrivedir" ]
then
$Xdev --backtitle "`sed -n '34p' $language`" \
	--title "`sed -n '16p' $language`" \
	 --ok-label "$ne_l" \
	--cancel-label "`sed -n '35p' $language`" \
        --checklist "`sed -n '36p' $language` $wineversion.
`sed -n '37,38p' $language`" 0 0 0 \
        "buw"    "`sed -n '40p' $language`" off \
        "buc"  "`sed -n '41p' $language`" off 2> /tmp/checklist.tmp.$$

retval=$?

case $retval in
  0)
;;
  1)
rm -f /tmp/checklist.tmp.$$
    EasyWine_setup;;
  255)
rm -f /tmp/checklist.tmp.$$
    EasyWine_setup;;
esac
else
$Xdev --backtitle "`sed -n '34p' $language`" \
	--title "`sed -n '16p' $language`" \
	 --ok-label "$ne_l" \
	--cancel-label "`sed -n '35p' $language`" \
        --checklist "`sed -n '36p' $language` $wineversion.
`sed -n '42,43p' $language`" 0 0 0 \
        "buw"    "`sed -n '40p' $language`" off 2> /tmp/checklist.tmp.$$

retval=$?

case $retval in
  0)
;;
  1)
rm -f /tmp/checklist.tmp.$$
    EasyWine_setup;;
  255)
rm -f /tmp/checklist.tmp.$$
    EasyWine_setup;;
esac
fi
fi

if grep "buw" /tmp/checklist.tmp.$$ >& /dev/null;
then
mv ~/.wine ~/.wine.$today
else
rm -r -f ~/.wine
fi

if grep "buc" /tmp/checklist.tmp.$$ >& /dev/null;
then
mv $cdrivedir $cdrivedir.$today
else
rm -r -f $cdrivedir
fi

rm -f /tmp/checklist.tmp.$$

if [ ! -e $tempdir/plug ]
then
$Xdev --backtitle "`sed -n '44p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ne_l" \
	--cancel-label "`sed -n '24p' $language`" \
        --radiolist "`sed -n '46,47p' $language`" 0 0 0 \
   "<01>" " `sed -n '48p' $language` " on \
   "<02>" " `sed -n '49p' $language`" off \
   "<03>" " `sed -n '50p' $language`"  off 2> /tmp/menuconfig.tmp.$$ 

retval=$?

for i in `cat /tmp/menuconfig.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menuconfig.tmp.$$ >& /dev/null;
then
down=001
fi

if grep "<02>" /tmp/menuconfig.tmp.$$ >& /dev/null;
then
down=002
fi

if grep "<03>" /tmp/menuconfig.tmp.$$ >& /dev/null;
then
down=003
fi

;;
  1)
  rm -f /tmp/menuconfig.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menuconfig.tmp.$$
    EasyWine_setup;;
esac
fi
rm -f /tmp/menuconfig.tmp.$$

if grep "zh_CN.txt" $homedir/.EasyWineLanguage >& /dev/null;
then
if [ "$lc"="zh_CN.GB" ]
then
lclink="gblink.txt"
elif [ "$lc"="zh_CN.UTF8" ]
then
lclink="utf8link.txt"
fi
elif grep "zh_TW.txt" $homedir/.EasyWineLanguage >& /dev/null;
then
if [ "$lc"="zh_CN.UTF8" ]
then
lclink="TWutf8link.txt"
else
lclink="enlink.txt"
fi
else
lclink="enlink.txt"
fi

(
echo "1" ; sleep 1
echo "XXX" ; echo "`sed -n '51p' $language`" ; echo "\\n" ; echo "`sed -n '52p' $language`"; echo "XXX"
rm -rf $homedir/.kde/share/applnk/Wine
rm -rf $homedir/.kde2/share/applnk/Wine
rm -rf $homedir/.kde3/share/applnk/Wine
rm -rf $homedir/.gnome/apps/Wine
linkname1="`sed -n '10p' $setupdir/language/$lclink`"
linkname2="`sed -n '11p' $setupdir/language/$lclink`"
linkname3="`sed -n '12p' $setupdir/language/$lclink`"
linkname4="`sed -n '13p' $setupdir/language/$lclink`"
linkname5="`sed -n '14p' $setupdir/language/$lclink`"
linkname6="`sed -n '15p' $setupdir/language/$lclink`"
rm -f "$homedir/Desktop/$linkname1"
rm -f "$homedir/Desktop/$linkname2"
rm -f "$homedir/Desktop/$linkname3"
rm -f "$homedir/Desktop/$linkname4"
rm -f "$homedir/Desktop/$linkname5"
rm -f "$homedir/Desktop/$linkname6"
rm -f $homedir/Desktop/Internet\ Explorer.desktop

echo "5" ; sleep 1
echo "XXX" ; echo "`sed -n '53p' $language`" ; echo "\\n" ; echo "`sed -n '54p' $language`"; echo "XXX"

mkdir ~/.wine
mkdir ~/.wine/dosdevices
mkdir ~/.wine/EasyWine

echo "10" ; sleep 1
echo "XXX" ; echo "`sed -n '55p' $language`" ; echo "\\n" ; echo "`sed -n '56p' $language`"; echo "XXX"

rm -f plug.tar.bz2
rm -f plug.zip

if [  ! -e $tempdir ] 
then
mkdir $tempdir
fi

if [ ! -e $tempdir/plug ]
then
if [ "$down" = "001" ]
then
 dload="http://software.lupaworld.com/pub/deman/plug.tar.bz2"
 sysname="plug.tar.bz2"
 dlsize="4949069"
ewdown
if [ ! -e plug.tar.bz2 ]
then
 txwk msgbox "`sed -n '57p' $language`"
exit 1
fi
tar xjvf plug.tar.bz2 -C $tempdir 2>&1 |cat >> $logfile
rm -f plug.tar.bz2
elif [ "$down" = "002" ]
then
 dload="http://skyerce.googlepages.com/plug.tar.bz2"
 sysname="plug.tar.bz2"
 dlsize="4949069"
ewdown
if [ ! -e plug.tar.bz2 ]
then
 txwk msgbox "`sed -n '57p' $language`"
exit 1
fi
tar xjvf plug.tar.bz2 -C $tempdir 2>&1 |cat >> $logfile
rm -f plug.tar.bz2
elif [ "$down" = "003" ]
then
downp_l="`sed -n '58p' $language`"
FILE=`$Xdev --stdout --title "$downp_l" --fselect $homedir 0 0`
case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_setup
		fi;;
	1)
		EasyWine_setup;;
	255)
		EasyWine_setup;;
esac
tar xjvf $FILE -C $tempdir 2>&1 |cat >> $logfile
else
 EasyWine_setup
fi
fi

if [ ! -e $tempdir/plug ]
then
 txwk msgbox "`sed -n '59,62p' $language`"
 EasyWine_setup
fi


if [ "$winec" = "old" ]
then
cp $setupdir/wineconfig/configstart ~/.wine/config
fi
echo "15" ; sleep 1
echo "XXX" ; echo "`sed -n '63p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

# This part is from wineprefixcreate script

CROOT=$cdrivedir
mkdir $cdrivedir

for i in \
    "$CROOT/My Documents" \
    "$CROOT/My Documents/My Music" \
    "$CROOT/My Documents/My Pictures" \
    "$CROOT/My Documents/My Video" \
    "$CROOT/Program Files" \
    "$CROOT/Program Files/Common Files" \
    "$CROOT/windows" \
    "$CROOT/windows/All Users" \
    "$CROOT/windows/Application Data" \
    "$CROOT/windows/Cookies" \
    "$CROOT/windows/Desktop" \
    "$CROOT/windows/Favorits" \
    "$CROOT/windows/History" \
    "$CROOT/windows/NetHood" \
    "$CROOT/windows/Recent" \
    "$CROOT/windows/SendTo" \
    "$CROOT/windows/ShellNew" \
    "$CROOT/windows/Temporary Internet Files" \
    "$CROOT/windows/command" \
    "$CROOT/windows/fonts" \
    "$CROOT/windows/inf" \
    "$CROOT/windows/profiles" \
    "$CROOT/windows/profiles/Administrator" \
    "$CROOT/windows/Start Menu" \
    "$CROOT/windows/Application Data" \
    "$CROOT/windows/Start Menu/Programs" \
    "$CROOT/windows/Start Menu/Programs/Startup" \
    "$CROOT/windows/system" \
    "$CROOT/windows/system32" \
    "$CROOT/windows/temp" \
    "$CROOT/windows/web"
do

    [ -d "$i" ] || mkdir "$i"
done

if [ ! -e $cdrivedir/windows ]
then
 txwk msgbox "`sed -n '65,67p' $language`"
 exit 1
fi

echo "20" ; sleep 1
echo "XXX" ; echo "`sed -n '68p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"
ln -s $cdrivedir ~/.wine/dosdevices/c\:
ln -s ~/ ~/.wine/dosdevices/d\:
ln -s `pwd` ~/.wine/dosdevices/x\:
ln -s $setupdir ~/.wine/dosdevices/y\:
ln -s $tempdir ~/.wine/dosdevices/z\:

if [ -e /mnt/cdrom ]
then
 ln -s /mnt/cdrom ~/.wine/dosdevices/e\:
elif [ -e /media/cdrom ]
then
 ln -s /media/cdrom ~/.wine/dosdevices/e\:
else [ -e /cdrom ]
 ln -s /cdrom ~/.wine/dosdevices/e\:
fi

if [ -e /mnt/cdrom1 ]
then
 ln -s /mnt/cdrom1 ~/.wine/dosdevices/f\:
elif [ -e /media/cdrom1 ]
then
 ln -s /media/cdrom1 ~/.wine/dosdevices/f\:
else [ -e /cdrom1 ]
 ln -s /cdrom1 ~/.wine/dosdevices/f\:
fi

 ln -s / ~/.wine/dosdevices/g\:

echo "30" ; sleep 1
echo "XXX" ; echo "`sed -n '69p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

dotfont=y
if [ "$dotfont" = "y" ]
then
 if [ ! -e ~/.fonts ]
 then
  mkdir ~/.fonts
 fi
 rm -rf $cdrivedir/windows/fonts
 ln -s ~/.fonts $cdrivedir/windows/fonts
fi

cp $setupdir/fonts/*.ttf $cdrivedir/windows/fonts

echo "32" ; sleep 1
echo "XXX" ; echo "`sed -n '70p' $language`" ; echo "\\n" ; echo "`sed -n '360p' $language`"; echo "XXX"

echo >> $logfile
echo "-- wine inf --">> $logfile
if [ "$winec" = "911" ]
then
cp $setupdir/inf/wine.inf $cdrivedir/windows/inf/wine.inf
else
 if [ -e /usr/local/share/wine/wine.inf ]
then
cp /usr/local/share/wine/wine.inf $cdrivedir/windows/inf/wine.inf
elif [ -e /usr/share/wine/wine.inf ]
then
cp /usr/share/wine/wine.inf $cdrivedir/windows/inf/wine.inf
else
wineinf=`find /usr -name wine.inf`
cp $wineinf $cdrivedir/windows/inf/wine.inf
fi
fi
wine rundll32 setupapi.dll,InstallHinfSection DefaultInstall 128 wine.inf 2>&1 |cat >> $logfile

echo "40" ; sleep 1
echo "XXX" ; echo "`sed -n '71p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

echo >> $logfile
echo "--  wcs.inf --">> $logfile
cp $setupdir/inf/wcs.inf $cdrivedir/windows/inf/wcs.inf
wine rundll32 setupapi.dll,InstallHinfSection DefaultInstall 128 wcs.inf 2>&1 |cat >> $logfile

echo "50" ; sleep 1
echo "XXX" ; echo "`sed -n '72p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

echo >> $logfile
echo "--wcscn.inf   --">> $logfile
cp $setupdir/inf/wcscn.inf $cdrivedir/windows/inf/wcscn.inf
wine rundll32 setupapi.dll,InstallHinfSection DefaultInstall 128 wcscn.inf 

echo "53" ; sleep 1
echo "XXX" ; echo "`sed -n '73p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

if [ -e /usr/local/lib/wine ]
then
 echo " prefix is /usr/local/lib/wine"
 echo >> $logfile
 echo "prefix is /usr/local/lib/wine">> $logfile
 instprefix="/usr/local/lib/wine"
elif [ -e /usr/lib/wine ]
then
 echo "prefix is /usr/lib/wine"
 echo >> $logfile
 echo "prefix is /usr/lib/wine">> $logfile
 instprefix="/usr/lib/wine"
else
 txwk msgbox "`sed -n '74,75p' $language`"
 instprefix=""
fi

dlldir=$instprefix

# This part is from wineprefixcreate script
# Create the application symlinks

link_app()
{
   rm -f "$2" && ln -s "$dlldir/$1.exe.so" "$2" || echo "Warning: failed to create $2"
}

if [ ! "$instprefix" = "" ]
then
 link_app start		"$CROOT/windows/command/start.exe"
 link_app notepad	"$CROOT/windows/notepad.exe"
 link_app regedit	"$CROOT/windows/regedit.exe"
 link_app rundll32	"$CROOT/windows/rundll32.exe"
 link_app wcmd		"$CROOT/windows/system32/wcmd.exe"
 link_app control	"$CROOT/windows/system32/control.exe"
 link_app winefile	"$CROOT/windows/system32/fileman.exe"
 #link_app winhelp	"$CROOT/windows/system32/help.exe"
 #link_app msiexec	"$CROOT/windows/system32/msiexec.exe"
 link_app notepad	"$CROOT/windows/system32/notepad.exe"
 link_app progman	"$CROOT/windows/system32/progman.exe"
 #link_app regsvr32	"$CROOT/windows/system32/regsvr32.exe"
 link_app taskmgr	"$CROOT/windows/system32/taskman.exe"
 link_app winemine	"$CROOT/windows/system32/winmine.exe"
 link_app winver	"$CROOT/windows/system32/winver.exe"
 link_app uninstaller	"$CROOT/windows/uninstall.exe"
 #link_app winhelp	"$CROOT/windows/winhelp.exe"
 #link_app winhelp	"$CROOT/windows/winhlp32.exe"
 link_app winebrowser	"$CROOT/windows/winebrowser.exe"
 link_app winecfg	"$CROOT/windows/winecfg.exe"
fi

link_dll()
{
   rm -f "$2" && ln -s "$dlldir/$1.dll.so" "$2" || echo "Warning: failed to create $2"
}

if [ ! "$instprefix" = "" ]
then
if [ "$winec" = "911" ] || [ "$winec" = "094" ] || [ "$winec" = "new" ]
then
 link_dll d3d8		"$CROOT/windows/system32/d3d8.dll"
 link_dll d3d9		"$CROOT/windows/system32/d3d9.dll"
else
 link_dll d3d8		"$CROOT/windows/system/d3d8.dll"
 link_dll d3d9		"$CROOT/windows/system/d3d9.dll"
fi
fi

#------------w32codecs------------------

echo "65" ; sleep 1
echo "XXX" ; echo "`sed -n '76p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

if [ -e /usr/lib/win32 ]
 then
  w32codecsdir="/usr/lib/win32"
 elif [ -e /usr/local/lib/win32 ]
 then
  w32codecsdir="/usr/local/lib/win32"
 fi
if [ -e /usr/lib/win32 ] || [ -e /usr/local/lib/win32 ]
 then
 echo >> $logfile
 echo "--  w32codec  --">> $logfile
if  [ "$winec" = "911" ] || [ "$winec" = "094" ] || [ "$winec" = "new" ]
then
 ln -s $w32codecsdir/ir41_32.dll $cdrivedir/windows/system32/ir41_32.dll
 ln -s $w32codecsdir/iccvid.dll $cdrivedir/windows/system32/iccvid.dll
 ln -s $w32codecsdir/ir32_32.dll $cdrivedir/windows/system32/ir32_32.dll
 ln -s $w32codecsdir/ir50_32.dll $cdrivedir/windows/system32/ir50_32.dll
 ln -s $w32codecsdir/msvidc32.dll $cdrivedir/windows/system32/msvidc32.dll
 ln -s $w32codecsdir/msrle32.dll $cdrivedir/windows/system32/msrle32.dll
 ln -s $w32codecsdir/tsd32.dll $cdrivedir/windows/system32/tsd32.dll
 ln -s $w32codecsdir/imaadp32.acm $cdrivedir/windows/system32/imaadp32.acm
 ln -s $w32codecsdir/lhacm.acm $cdrivedir/windows/system32/lhacm.acm
 ln -s $w32codecsdir/msadp32.acm $cdrivedir/windows/system32/msadp32.acm
 ln -s $w32codecsdir/msgsm32.acm $cdrivedir/windows/system32/msgsm32.acm
 ln -s $w32codecsdir/tssoft32.acm $cdrivedir/windows/system32/tssoft32.acm
else
 ln -s $w32codecsdir/ir41_32.dll $cdrivedir/windows/system/ir41_32.dll
 ln -s $w32codecsdir/iccvid.dll $cdrivedir/windows/system/iccvid.dll
 ln -s $w32codecsdir/ir32_32.dll $cdrivedir/windows/system/ir32_32.dll
 ln -s $w32codecsdir/ir50_32.dll $cdrivedir/windows/system/ir50_32.dll
 ln -s $w32codecsdir/msvidc32.dll $cdrivedir/windows/system/msvidc32.dll
 ln -s $w32codecsdir/msrle32.dll $cdrivedir/windows/system/msrle32.dll
 ln -s $w32codecsdir/tsd32.dll $cdrivedir/windows/system/tsd32.dll
 ln -s $w32codecsdir/imaadp32.acm $cdrivedir/windows/system/imaadp32.acm
 ln -s $w32codecsdir/lhacm.acm $cdrivedir/windows/system/lhacm.acm
 ln -s $w32codecsdir/msadp32.acm $cdrivedir/windows/system/msadp32.acm
 ln -s $w32codecsdir/msgsm32.acm $cdrivedir/windows/system/msgsm32.acm
 ln -s $w32codecsdir/tssoft32.acm $cdrivedir/windows/system/tssoft32.acm
fi
 cp $setupdir/inf/w32codecs.inf $cdrivedir/windows/inf/w32codecs.inf
 wine rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 128 w32codecs.inf 2>&1 |cat >> $logfile
 fi
#------------w32codecs------------------

echo "73" ; sleep 1
echo "XXX" ; echo "`sed -n '77p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

#------------explorer------------------
cp $tempdir/plug/shelllink/*.exe $cdrivedir/windows

echo "78" ; sleep 1
echo "XXX" ; echo "`sed -n '78p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

if [ "$winec" = "094" ] || [ "$winec" = "new" ]
then
cp $tempdir/plug/rosexplorer/*.exe $cdrivedir/windows
cp $tempdir/plug/rosexplorer/*.dll $cdrivedir/windows/system32
elif [ "$winec" = "old" ]
then
cp $tempdir/plug/rosexplorer/*.exe $cdrivedir/windows
cp $tempdir/plug/rosexplorer/*.dll $cdrivedir/windows/system
fi

#------------explorer------------------

echo "82" ; sleep 1
echo "XXX" ; echo "`sed -n '79p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

if [ -e $cdrivedir/windows/.wine911 ]
then
wineshelllink --menu --link "`sed -n '1p' $setupdir/language/$lclink`" --path c:/windows/explorer.exe --icon $setupdir/xpm/computer.xpm
wineshelllink --menu --link "`sed -n '3p' $setupdir/language/$lclink`" --path c:/windows/system/control.exe --icon $setupdir/xpm/config.xpm
wineshelllink --menu --link "`sed -n '4p' $setupdir/language/$lclink`" --path c:/windows/uninstall.exe --icon $setupdir/xpm/setup.xpm
wineshelllink --menu --link "`sed -n '5p' $setupdir/language/$lclink`" --path c:/windows/winecfg.exe --icon $setupdir/xpm/wineconfig.xpm
wineshelllink --menu --link "`sed -n '6p' $setupdir/language/$lclink`" --path c:/windows/system/taskmgr.exe --icon $setupdir/xpm/Manager.xpm
wineshelllink --menu --link "`sed -n '7p' $setupdir/language/$lclink`" --path c:/windows/notepad.exe --icon $setupdir/xpm/note.xpm
wineshelllink --menu --link "`sed -n '8p' $setupdir/language/$lclink`" --path c:/windows/regedit.exe --icon $setupdir/xpm/regedit.xpm
wineshelllink --menu --link "`sed -n '9p' $setupdir/language/$lclink`" --path c:/windows/winmine.exe --icon $setupdir/xpm/game.xpm
else
wineshelllink --menu --link "`sed -n '1p' $setupdir/language/$lclink`" --path c:/windows/system32/fileman.exe --icon $setupdir/xpm/computer.xpm
wineshelllink --menu --link "`sed -n '2p' $setupdir/language/$lclink`" --path c:/windows/system32/progman.exe
wineshelllink --menu --link "`sed -n '3p' $setupdir/language/$lclink`" --path c:/windows/system32/control.exe --icon $setupdir/xpm/config.xpm
wineshelllink --menu --link "`sed -n '4p' $setupdir/language/$lclink`" --path c:/windows/uninstall.exe --icon $setupdir/xpm/setup.xpm
wineshelllink --menu --link "`sed -n '5p' $setupdir/language/$lclink`" --path c:/windows/winecfg.exe --icon $setupdir/xpm/wineconfig.xpm
wineshelllink --menu --link "`sed -n '6p' $setupdir/language/$lclink`" --path c:/windows/system32/taskmgr.exe --icon $setupdir/xpm/Manager.xpm
wineshelllink --menu --link "`sed -n '7p' $setupdir/language/$lclink`" --path c:/windows/notepad.exe --icon $setupdir/xpm/note.xpm
wineshelllink --menu --link "`sed -n '8p' $setupdir/language/$lclink`" --path c:/windows/regedit.exe --icon $setupdir/xpm/regedit.xpm
wineshelllink --menu --link "`sed -n '9p' $setupdir/language/$lclink`" --path c:/windows/winmine.exe --icon $setupdir/xpm/game.xpm
fi

if [ `which wineserver` ]
then
 wineserver -w
else
 /usr/lib/wine/wineserver -w
fi

echo "90" ; sleep 1
echo "XXX" ; echo "`sed -n '80p' $language`" ; echo "\\n" ; echo "`sed -n '81p' $language`"; echo "XXX"

if [ "$winec" = "old" ]
then
cp $setupdir/wineconfig/configEasyWine ~/.wine/config
fi

echo "95" ; sleep 1
echo "XXX" ; echo "`sed -n '82p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

if [ -e $tempdir/plug/soft/mfc40.dll ]
then
if [ "$winec" = "911" ] || [ "$winec" = "094" ] || [ "$winec" = "new" ]
then
  cp $tempdir/plug/soft/mfc40.dll $cdrivedir/windows/system32/mfc40.dll
else
  cp $tempdir/plug/soft/mfc40.dll $cdrivedir/windows/system/mfc40.dll
fi
fi

echo "98" ; sleep 1
echo "XXX" ; echo "`sed -n '83p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"

rm -f ~/.wine/dosdevices/x\:
rm -f ~/.wine/dosdevices/y\:
rm -f ~/.wine/dosdevices/z\:
rm -f $homedir/Desktop/*.lnk

wineboot 2>&1 |cat >> $logfile
wineboot

if [ "$winec" = "911" ]
then
mkdir $cdrivedir/windows/.wine911
cp $setupdir/reg/ie6setup.reg $cdrivedir/ie6setup.reg
regedit $cdrivedir/ie6setup.reg
rm -f $cdrivedir/ie6setup.reg
fi

if [ "$winec" = "094" ]
then
mkdir $cdrivedir/windows/.wine094
fi

if [ "$winec" = "new" ]
then
mkdir $cdrivedir/windows/.winenew
fi

if [ "$winec" = "old" ]
then
mkdir $cdrivedir/windows/.wineold
fi

cp $setupdir/reg/bdefix.reg $cdrivedir/bdefix.reg
regedit $cdrivedir/bdefix.reg
rm -f $cdrivedir/bdefix.reg

echo "100" ; sleep 1
echo "XXX" ; echo "`sed -n '84p' $language`" ; echo "\\n" ; echo "`sed -n '85p' $language`"; echo "XXX"

) |
$Xdev --title "`sed -n '84p' $language`" --gauge "`sed -n '51p' $language`" 8 40

if [ "$?" = 255 ] ; then
	echo ""
	echo "Box closed !"
	exit 1
fi
EasyWine_setup
}


EasyWine_2()
{
if [ -e $cdrivedir/windows/.wine094 ] || [ -e $cdrivedir/windows/.wine911 ]
then
if [ -d $cdrivedir/windows/system32/dcom98 ] || mkdir $cdrivedir/windows/system32/dcom98
then
echo
cp $tempdir/plug/dcom98/*.txt $cdrivedir/windows/system32/dcom98/
cp $tempdir/plug/dcom98/*{dll,tlb,exe} $cdrivedir/windows/system32/
cp $tempdir/plug/dcom98/dcom98.inf $cdrivedir/windows/inf/
fi
cp $tempdir/plug/InstMsiA/*.* $cdrivedir/windows/system32/
fi

if [ -e $cdrivedir/windows/.winenew ]
then
cp $tempdir/plug/InstMsiA/*.* $cdrivedir/windows/system32/
fi

if [ -e $cdrivedir/windows/.wineold ]
then
if [ -d $cdrivedir/windows/system/dcom98 ] || mkdir $cdrivedir/windows/system/dcom98
then
cp $tempdir/plug/dcom98/*.txt $cdrivedir/windows/system/dcom98/
cp $tempdir/plug/dcom98/*{dll,tlb,exe} $cdrivedir/windows/system/
cp $tempdir/plug/dcom98/dcom98.inf $cdrivedir/windows/inf/
fi
cp $tempdir/plug/InstMsiA/*.* $cdrivedir/windows/system/
fi

if [ -e $cdrivedir/windows/system32/msiexec.exe ] || [ -e $cdrivedir/windows/system/msiexec.exe ] || [ -e $cdrivedir/windows/inf/dcom98.inf ]

then
rm -f /tmp/menuie.tmp.$$

$Xdev --backtitle "`sed -n '86p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
        --radiolist "`sed -n '87,90p' $language`" 0 0 3 \
   "<01>" " `sed -n '91p' $language` " on \
   "<02>" " `sed -n '92p' $language`"  off 2> /tmp/menuie.tmp.$$

retval=$?

for i in `cat /tmp/menuie.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menuie.tmp.$$ >& /dev/null;
then
iedown=01
fi

if grep "<02>" /tmp/menuie.tmp.$$ >& /dev/null;
then
rm -f $tempdir/ie6setup.exe
iedir_l="`sed -n '93p' $language`"
DIR=`$Xdev  --ok-label "$ne_l"  --cancel-label "$cancel_l" --stdout --title "$iedir_l" --dselect $homedir 0 0`

case $? in
	0)
		if [ "$DIR" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_setup
		fi;;
	1)
		EasyWine_setup;;
	3)
		moshi;;
	255)
		EasyWine_setup;;
esac
fi

;;
  1)
  rm -f /tmp/menuie.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menuie.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menuie.tmp.$$

$Xdev --backtitle "`sed -n '86p' $language`" \
	--title "`sed -n '94p' $language`" \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
        --checklist "`sed -n '95,97p' $language`" 0 0 0 \
        "auto"  "`sed -n '98p' $language`" on \
	"patch" "`sed -n '99p' $language`" off \
        "xunlei"  "`sed -n '100p' $language`" off 2> /tmp/menu3.tmp.$$

retval=$?

for i in `cat /tmp/menu3.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "auto" /tmp/menu3.tmp.$$ >& /dev/null;
then
ie6=simple
fi

if grep "patch" /tmp/menu3.tmp.$$ >& /dev/null;
then
patch=ok
fi

if grep "xunlei" /tmp/menu3.tmp.$$ >& /dev/null;
then
mini=ok
fi

;;
  1)
  rm -f /tmp/menu3.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menu3.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menu3.tmp.$$

# Setup

(
echo "1" ; sleep 1
echo "XXX" ; echo "`sed -n '101p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"
if [ "$patch" = "ok" ]
then
if [ ! -e $tempdir/249973USA8.exe ]
then
rm -f 249973USA8.exe
 dload="http://download.microsoft.com/download/win98SE/Update/5072/W98/EN-US/249973USA8.exe"
 sysname="249973USA8.exe"
 dlsize="838328"
ewdown
mv 249973USA8.exe $tempdir
fi
if [  -e $tempdir/249973USA8.exe ]
then
wine $tempdir/249973USA8.exe
wineboot
else
txwk msgbox "`sed -n '57p' $language`"
exit 1
fi
fi

echo "5" ; sleep 1
echo "XXX" ; echo "`sed -n '102p' $language`" ; echo "\\n" ; echo "`sed -n '64p' $language`"; echo "XXX"
if [ "$iedown" = "01" ]
then
if [ ! -e $tempdir/ie6setup.exe ] || [ -e $tempdir/IE6SETUP.EXE ]
then
rm -f ie6setup.exe
 dload="http://download.microsoft.com/download/ie6sp1/finrel/6_sp1/W98NT42KMeXP/cn/ie6setup.exe"
 sysname="ie6setup.exe"
 dlsize="484088"
ewdown
if [ ! -e ie6setup.exe ]
then
 txwk msgbox "`sed -n '57p' $language`"
exit 1
fi
if [ -d $tempdir ] || mkdir $tempdir
then
mv ie6setup.exe $tempdir/ie6setup.exe
fi
fi
fi

echo "10" ; sleep 1
echo "XXX" ; echo "`sed -n '95p' $language`" ; echo "\\n" ; echo "`sed -n '103p' $language`"; echo "XXX"
rm -f $DIR/iebatch.txt 2>&1 |cat >> $logfile
rm -f $tempdir/iebatch.txt 2>&1 |cat >> $logfile
ie6install=y
if [ "$ie6install" = "y" ]
then
if [ "$ie6" = "simple" ]
then
 if [ -e $tempdir/ie6setup.exe ] || [ -e $tempdir/IE6SETUP.EXE ]
 then
cp $setupdir/iebatch/iebatch_wmp6.txt $tempdir/iebatch.txt
else
cp $setupdir/iebatch/iebatch_wmp6.txt $DIR/iebatch.txt
fi
fi
echo >> $logfile
echo "--  闂傚倸鍊峰ù鍥敋瑜嶉湁闁绘垼妫勭粻鐘绘煙閹冩闁搞儺鍓欑粻顕�鏌涢幘宕囦虎妞わ妇鏁诲顐﹀箻鐠鸿櫣绛忛梺璺ㄥ枔闁憋拄1�7-">> $logfile

echo "20" ; sleep 1
echo "XXX" ; echo "`sed -n '94p' $language`" ; echo "\\n" ; echo "`sed -n '104p' $language`"; echo "XXX"

declare -i counter
counter=0

while [ ! -e $cdrivedir/Program\ Files/Internet\ Explorer/IEXPLORE.EXE ]
 do {

 if [ -e $tempdir/ie6setup.exe ] || [ -e $tempdir/IE6SETUP.EXE ]
 then
  WINEDLLOVERRIDES="advpack,urlmon=n" wine $tempdir/ie6setup.exe 2>&1 |cat >> $logfile
 else
  WINEDLLOVERRIDES="advpack,urlmon=n" wine $tempdir/ie6setup_CN.exe 2>&1 |cat >> $logfile
fi

 if [ -e $DIR/ie6setup.exe ] || [ -e $DIR/IE6SETUP.EXE ]
 then
  WINEDLLOVERRIDES="advpack,urlmon=n" wine $DIR/ie6setup.exe 2>&1 |cat >> $logfile
 else
  WINEDLLOVERRIDES="advpack,urlmon=n" wine $DIR/ie6setup_CN.exe 2>&1 |cat >> $logfile
 fi
 
  if [ `which wineserver` ]
  then
   wineserver -w 2>&1 |cat >> $logfile
  else
   /usr/lib/wine/wineserver -w 2>&1 |cat >> $logfile
  fi
 
 counter=$counter+1
 if [ "$counter" = "5" ]
 then
  txwk msgbox "`sed -n '105,106p' $language`"
  exit 1
 fi
 }
done

if [ ! -e $cdrivedir/windows/system/mfc40.dll ]
then
echo "65" ; sleep 1
echo "XXX" ; echo "`sed -n '107p' $language`" ; echo "\\n" ; echo "`sed -n '108p' $language`"; echo "XXX"

 mv $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX \
 $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX.bak
 cp $tempdir/plug/true/trueocx.ocx $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX
fi

echo "72" ; sleep 1
echo "XXX" ; echo "`sed -n '107p' $language`" ; echo "\\n" ; echo "`sed -n '109p' $language`"; echo "XXX"
wineboot 2>&1 |cat >> $logfile
wineboot 2>&1 |cat >> $logfile


wine shelllink mkdir __startmenu__\\Programs\\
wine shelllink c:\\Program\ Files\\Internet\ Explorer\\IEXPLORE.EXE __startmenu__\\Internet\ Explorer.lnk

 wine shelllink c:\\Program\ Files\\Internet\ Explorer\\IEXPLORE.EXE __desktop__\\Internet\ Explorer.lnk

if [ -e $cdrivedir/Program\ Files/Windows\ Media\ Player/mplayer2.exe ]
then
 wine shelllink c:\\Program\ Files\\Windows\ Media\ Player\\mplayer2.exe __startmenu__\\Programs\\Windows\ Media\ Player\ 6.4.lnk
fi

if [ `which fc-cache` ]
then
echo "75" ; sleep 1
echo "XXX" ; echo "`sed -n '107p' $language`" ; echo "\\n" ; echo "`sed -n '110p' $language`"; echo "XXX"
 fc-cache
fi

if [ -e $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX.bak ]
then
echo "80" ; sleep 1
echo "XXX" ; echo "`sed -n '107p' $language`" ; echo "\\n" ; echo "`sed -n '111p' $language`"; echo "XXX"

 rm -f $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX
 mv $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX.bak \
 $cdrivedir/Program\ Files/Common\ Files/Microsoft\ Shared/MSInfo/IEINFO5.OCX
fi
fi

echo "85" ; sleep 1
echo "XXX" ; echo "`sed -n '112p' $language`" ; echo "\\n" ; echo "`sed -n '113p' $language`"; echo "XXX"

if [ -e $cdrivedir/Program\ Files/Internet\ Explorer/IEXPLORE.EXE ]
then
 ln -s $cdrivedir/Program\ Files/Internet\ Explorer/IEXPLORE.EXE $cdrivedir/windows/iexplore.exe
fi

rm -f ~/.wine/dosdevices/x\:
rm -f ~/.wine/dosdevices/y\:
rm -f ~/.wine/dosdevices/z\:
rm -f $homedir/Desktop/*.lnk

if [ -e $cdrivedir/windows/.wine911 ]
then
cp $setupdir/reg/ie6sp1.reg $cdrivedir/ie6sp1.reg
regedit $cdrivedir/ie6sp1.reg
rm -f $cdrivedir/ie6sp1.reg
else
cp $setupdir/reg/ie.reg $cdrivedir/ie.reg
regedit $cdrivedir/ie.reg
rm -f $cdrivedir/ie.reg
fi

if [ -e $cdrivedir/windows/.wineold ]
then
cp $tempdir/plug/soft/mfc42.dll $cdrivedir/windows/system/mfc42.dll
else
cp $tempdir/plug/soft/mfc42.dll $cdrivedir/windows/system32/mfc42.dll
fi

if [ -e $cdrivedir/windows/.winenew ]
then
if [ -d $cdrivedir/windows/system32/dcom98 ] || mkdir $cdrivedir/windows/system32/dcom98
then
cp $tempdir/plug/dcom98/*.txt $cdrivedir/windows/system32/dcom98/
cp $tempdir/plug/dcom98/*{dll,tlb,exe} $cdrivedir/windows/system32/
cp $tempdir/plug/dcom98/dcom98.inf $cdrivedir/windows/inf/
fi
fi

 if [ `which wineserver` ]
 then
  wineserver -w 2>&1 |cat >> $logfile
 else
  /usr/lib/wine/wineserver -w 2>&1 |cat >> $logfile
 fi

if [ -e $cdrivedir/windows/.wineold ]
then
cp $setupdir/reg/1.reg $cdrivedir/1.reg
cp $setupdir/reg/2.reg $cdrivedir/2.reg
regedit $cdrivedir/1.reg
regedit $cdrivedir/2.reg
rm -f $cdrivedir/1.reg
rm -f $cdrivedir/2.reg
cp $tempdir/plug/soft/odbccp32.dll $cdrivedir/windows/system/odbccp32.dll
cp $tempdir/plug/soft/odbcint.dll $cdrivedir/windows/system/odbcint.dll
cp $tempdir/plug/soft/msvcirt.dll $cdrivedir/windows/system/msvcirt.dll
fi

if [ -e $cdrivedir/windows/.winenew ]
then
cp $tempdir/plug/soft/odbccp32.dll $cdrivedir/windows/system32/odbccp32.dll
cp $tempdir/plug/soft/odbcint.dll $cdrivedir/windows/system32/odbcint.dll
cp $tempdir/plug/soft/msvcirt.dll $cdrivedir/windows/system32/msvcirt.dll
fi

echo "95" ; sleep 1
echo "XXX" ; echo "`sed -n '114p' $language`" ; echo "\\n" ; echo "`sed -n '115p' $language`"; echo "XXX"

if [ -e $cdrivedir/Program\ Files/Internet\ Explorer/IEXPLORE.EXE ]
then

 echo >> $logfile
 echo "--  open ie6 --">> $logfile
	
	wine iexplore http://www.linuxgame.org 2>&1 |cat >> $logfile
fi

echo "98" ; sleep 1
echo "XXX" ; echo "`sed -n '116p' $language`" ; echo "\\n" ; echo "`sed -n '117p' $language`"; echo "XXX"

if [ "$mini" = "ok" ]
then
if [ ! -e $tempdir/ThunderMini.exe ]
then
rm -f ThunderMini.exe
 dload="http://software.lupaworld.com/pub/deman/ThunderMini.exe"
 sysname="ThunderMini.exe"
 dlsize="643072"
ewdown
if [ ! -e ThunderMini.exe ]
then
 txwk msgbox "`sed -n '57p' $language`"
fi
mv ThunderMini.exe $tempdir/ThunderMini.exe
fi
wine $tempdir/ThunderMini.exe 2>&1 |cat >> $logfile
fi

echo "100" ; sleep 1
echo "XXX" ; echo "`sed -n '94p' $language`" ; echo "\\n" ; echo "`sed -n '118p' $language`"; echo "XXX"

) |
$Xdev --title "`sed -n '94p' $language`" --gauge "`sed -n '86p' $language`" 8 40

if [ "$?" = 255 ] ; then
        echo ""
	echo "Box closed !"
	exit 1
fi

if [ -e $cdrivedir/Program\ Files/Internet\ Explorer/IEXPLORE.EXE ]
then
rm -f $DIR/iebatch.txt 2>&1 |cat >> $logfile
txwk msgbox "`sed -n '107p' $language`"
else
txwk msgbox "`sed -n '119,123p' $language`"

fi

else
txwk msgbox "`sed -n '114,128p' $language`"
fi
EasyWine_setup
}

EasyWine_4()
{
if [ -e $cdrivedir/Program\ Files/Internet\ Explorer/IEXPLORE.EXE ]
then

$Xdev --backtitle "`sed -n '129p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
        --radiolist "`sed -n '130,133p' $language`" 0 0 3 \
   "<01>" " `sed -n '134p' $language` " on \
   "<02>" " `sed -n '135p' $language`"  off 2> /tmp/menuqqs.tmp.$$

retval=$?

for i in `cat /tmp/menuqqs.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menuqqs.tmp.$$ >& /dev/null;
then
downqq=1
fi

if grep "<02>" /tmp/menuqqs.tmp.$$ >& /dev/null;
then
downqq=2
fi

;;
  1)
  rm -f /tmp/menuqqs.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menuqqs.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menuqqs.tmp.$$

$Xdev --backtitle "`sed -n '129p' $language`" \
	--title "`sed -n '129p' $language` " \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
        --checklist "`sed -n '136,138p' $language`" 0 0 0 \
        "DL"  "`sed -n '139p' $language`" on \
        "GX"  "`sed -n '140p' $language`" on 2> /tmp/qq2005beta2.tmp.$$

retval=$?

for i in `cat /tmp/qq2005beta2.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "DL" /tmp/qq2005beta2.tmp.$$ >& /dev/null;
then
qq2005beta2="download"
fi

if grep "GX" /tmp/qq2005beta2.tmp.$$ >& /dev/null;
then
QGX="YES"
fi

;;
  1)
  rm -f /tmp/qq2005beta2.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/qq2005beta2.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/qq2005beta2.tmp.$$

if [ "$downqq" = "1" ]
then
if [ ! -e $tempdir/qq2005beta2.exe ]
then
rm -f qq2005beta2.exe
 dload="http://software.lupaworld.com/pub/deman/qq2005beta2.exe"
 sysname="qq2005beta2.exe"
 dlsize="20251979"
ewdown
if [ ! -e qq2005beta2.exe ]
then
 txwk msgbox "`sed -n '57p' $language`"
exit 1
fi
mv qq2005beta2.exe $tempdir/qq2005beta2.exe
fi
else
rm -f $tempdir/qq2005beta2.exe
qqf_l="`sed -n '141p' $language`"
FILE=`$Xdev --stdout  --ok-label "$ne_l" --cancel-label"$cancel_l" --title "$qqf_l" --fselect $homedir 0 0`

case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_setup
		fi
		;;
	1)
		EasyWine_setup;;
	255)
		EasyWine_setup;;
esac
fi

if [ -e $tempdir/qq2005beta2.exe ]
then
wine $tempdir/qq2005beta2.exe  2>&1 |cat >> $logfile

else
wine "$FILE" 2>&1 |cat >> $logfile

fi


if [  "$QGX"="YES" ]
then
if [ ! -e $tempdir/QQGroupDisk_Update_0200.exe ]
then
rm -f QQGroupDisk_Update_0200.exe
 dload="http://disk.qq.com/QQGroupDisk_Update_0200.exe"
 sysname="QQGroupDisk_Update_0200.exe"
 dlsize="188214"
ewdown
if [ ! -e QQGroupDisk_Update_0200.exe ]
then
 txwk msgbox "`sed -n '57p' $language`"
fi
mv QQGroupDisk_Update_0200.exe $tempdir/QQGroupDisk_Update_0200.exe
wine $tempdir/QQGroupDisk_Update_0200.exe 2>&1 |cat >> $logfile
fi

if [  qq2005beta2="download" ]
then
if [ ! -e $tempdir/QQ.exe ]
then
rm -f QQ.exe
 dload="http://software.lupaworld.com/pub/deman/QQ.exe"
 sysname="QQ.exe"
 dlsize="1150976"
ewdown
if [ ! -e QQ.exe ]
then
 txwk msgbox "`sed -n '57p' $language`"
fi
mv QQ.exe $tempdir/QQ.exe
fi
fi

if [ -e $cdrivedir/Program\ Files/Tencent/QQ.exe ]
then
cp $tempdir/QQ.exe $cdrivedir/Program\ Files/Tencent/QQ.exe
fi

if [ -e $cdrivedir/Program\ Files/Tencent/qq.exe ]
then
cp $tempdir/QQ.exe $cdrivedir/Program\ Files/Tencent/qq.exe
fi

if [ -e $cdrivedir/Program\ Files/Tencent/QQ/qq.exe ]
then
cp $tempdir/QQ.exe $cdrivedir/Program\ Files/Tencent/QQ/qq.exe
fi
 
if [ -e $cdrivedir/Program\ Files/Tencent/QQ/QQ.exe ]
then
cp $tempdir/QQ.exe $cdrivedir/Program\ Files/Tencent/QQ/QQ.exe
fi

fi

if [ -e $cdrivedir/windows/.wine911 ]
then
cp $setupdir/reg/newqq.reg $cdrivedir/newqq.reg
regedit $cdrivedir/newqq.reg
rm $cdrivedir/newqq.reg
else
if [ -e $cdrivedir/Program\ Files/Tencent/npkcrypt.sys ]
then
cp $setupdir/reg/qqrc.reg $cdrivedir/qqrc.reg
regedit $cdrivedir/qqrc.reg
rm $cdrivedir/Program\ Files/Tencent/npkcrypt.sys
rm $cdrivedir/qqrc.reg
elif [ -e $cdrivedir/Program\ Files/Tencent/QQ/npkcrypt.sys ]
then
cp $setupdir/reg/qqrc.reg $cdrivedir/qqrc.reg
regedit $cdrivedir/qqrc.reg
rm $cdrivedir/Program\ Files/Tencent/QQ/npkcrypt.sys
rm $cdrivedir/qqrc.reg
mv $cdrivedir/Program\ Files/Tencent/QQ/Riched32.dll $cdrivedir/Program\ Files/Tencent/QQ/Riched32.dll.bak
mv $cdrivedir/Program\ Files/Tencent/QQ/riched20.dll $cdrivedir/Program\ Files/Tencent/QQ/Riched20.dll.bak
elif [ -e $cdrivedir/Program\ Files/Tencent/QQ/npkcrypt.sys ]
then
cp $setupdir/reg/qqrc.reg $cdrivedir/qqrc.reg
regedit $cdrivedir/qqrc.reg
rm $cdrivedir/Program\ Files/Tencent/qq/npkcrypt.sys
rm $cdrivedir/qqrc.reg
mv $cdrivedir/Program\ Files/Tencent/qq/Riched32.dll $cdrivedir/Program\ Files/Tencent/qq/Riched32.dll.bak
mv $cdrivedir/Program\ Files/Tencent/qq/riched20.dll $cdrivedir/Program\ Files/Tencent/qq/Riched20.dll.bak
else
cp $setupdir/reg/qq98.reg $cdrivedir/qq98.reg
regedit $cdrivedir/qq98.reg
rm $cdrivedir/qq98.reg
if [ -e $cdrivedir/Program\ Files/Tencent/QQ ]
then
mv $cdrivedir/Program\ Files/Tencent/QQ/Riched32.dll $cdrivedir/Program\ Files/Tencent/QQ/Riched32.dll.bak
mv $cdrivedir/Program\ Files/Tencent/QQ/riched20.dll $cdrivedir/Program\ Files/Tencent/QQ/Riched20.dll.bak
else
mv $cdrivedir/Program\ Files/Tencent/Riched32.dll $cdrivedir/Program\ Files/Tencent/Riched32.dll.bak
mv $cdrivedir/Program\ Files/Tencent/riched20.dll $cdrivedir/Program\ Files/Tencent/Riched20.dll.bak
fi
fi
fi
if [ -e $cdrivedir/Program\ Files/Tencent/QQ.exe ] || [ -e $cdrivedir/Program\ Files/Tencent/qq/QQ.exe ] || [ -e $cdrivedir/Program\ Files/Tencent/QQ/QQ.exe ]
then
rm -f $homedir/Desktop/*.lnk

txwk msgbox "`sed -n '142p' $language`"

else
txwk msgbox "`sed -n '143,150p' $language`"

fi
else
txwk msgbox "`sed -n '151,155p' $language`"
fi
EasyWine_setup
}

EasyWine_5()
{
if [ $language = "$setupdir/language/en_US.txt" ];then
$Xdev --title "`sed -n '156p' $language`" \
         --ok-label "$ok_l" --cancel-label "$cancel_l" \
	--left \
        --menu "`sed -n '157,161p' $language`" 20 80 0 \
   "<01>" "Windows software Support list"\
   "<02>" "Add EasyWine Configurable Plug-in"\
   "<03>" "Educe EasyWine Configurable Plug-in" \
   "<04>" "Reset software Support list" 2> /tmp/menuother.tmp.$$
else
$Xdev --title "`sed -n '156p' $language`" \
         --ok-label "$ok_l" --cancel-label "$cancel_l" \
	--left \
        --menu "`sed -n '157,161p' $language`" 16 50 0 \
   "<01>" " `sed -n '162p' $language`"\
   "<02>" "`sed -n '163p' $language`"\
   "<03>" "`sed -n '164p' $language`" \
   "<04>" "`sed -n '165p' $language`" 2> /tmp/menuother.tmp.$$
fi
retval=$?

for i in `cat /tmp/menuother.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menuother.tmp.$$ >& /dev/null;
then
if [  ! -e $tempdir/EasyWinePlug.sh ] 
then
cp $setupdir/EasyWinePlug.sh $tempdir/EasyWinePlug.sh
fi
sh $tempdir/EasyWinePlug.sh
fi

if grep "<02>" /tmp/menuother.tmp.$$ >& /dev/null;
then
if [  ! -e $tempdir/EasyWinePlug.sh ] 
then
cp $setupdir/EasyWinePlug.sh $tempdir/EasyWinePlug.sh
fi
EasyWine_in
fi

if grep "<03>" /tmp/menuother.tmp.$$ >& /dev/null;
then
EasyWine_out
fi

if grep "<04>" /tmp/menuother.tmp.$$ >& /dev/null;
then
cp $setupdir/EasyWinePlug.sh $tempdir/EasyWinePlug.sh
EasyWine_5
fi
;;
  1)
  rm -f /tmp/menuother.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menuother.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menuother.tmp.$$
EasyWine_setup
}

EasyWine_6()
{
$Xdev --wrap --ok-label "$ok_l" --cancel-label "$cancel_l" --yesno "`sed -n '166,167p' $language`" 0 0
 case $? in
	0);;
	1) EasyWine_20;;
	255) EasyWine_20;;
esac

fonts_l="sed -n '168p' $language"
FILE=`$Xdev --stdout --ok-label "$ok_l" --cancel-label "$cancel_l" --title "$fonts_l" --fselect $homedir 0 0`

case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_setup
		fi
		;;
	1)
		EasyWine_setup;;
	255)
		EasyWine_setup;;
esac

cp $FILE $homedir/.fonts/SIMSUN.TTF 2>&1 |cat >> $logfile

rm -f $homedir/.fonts/ARIALBI.TTF
rm -f $homedir/.fonts/ARIAL.TTF
rm -f $homedir/.fonts/ARIALBD.TTF
rm -f $homedir/.fonts/ARIALI.TTF
cp $setupdir/reg/font.reg $cdrivedir/font.reg
regedit $cdrivedir/font.reg
rm -f $cdrivedir/font.reg

txwk msgbox "`sed -n '169,171p' $language`
[Desktop]
menufontsize=13
messagefontsize=13
statusfontsize=13
IconTitleSize=13"

EasyWine_20
}

EasyWine_7()
{
$Xdev --wrap --title "$EWVER"  --backtitle " `sed -n '172p' $language`"\
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
 --textbox "$setupdir/copyright.txt" 455x480 0

case $? in
  0)
    ;;
  1)
    EasyWine_setup;;
  255)
    EasyWine_setup;;
esac
EasyWine_setup
}

EasyWine_9()
{
if [ `whoami` = 'root' ]
then

$Xdev --backtitle "`sed -n '173p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
        --radiolist "`sed -n '174,177p' $language`" 18 48 3 \
   "<01>" " `sed -n '178p' $language` Wine 0.9.10 " on \
   "<02>" " `sed -n '179p' $language`"  off 2> /tmp/menu2.tmp.$$

retval=$?

for i in `cat /tmp/menu2.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menu2.tmp.$$ >& /dev/null;
then
ot=net
fi

if grep "<02>" /tmp/menu2.tmp.$$ >& /dev/null;
then
ot=nation
fi

;;
  1)
  rm -f /tmp/menu2.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menu2.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menu2.tmp.$$

if [ "$ot" = "nation" ]
then
wined_l="`sed -n '180p' $language`"
DIR=`$Xdev --stdout  --ok-label "$ok_l" --cancel-label "$cancel_l"  --title "$wined_l" --dselect /etc 0 0`

case $? in
	0)
		if [ "$DIR" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_setup
		fi
		;;
	1)
		EasyWine_setup;;
	255)
		EasyWine_setup;;
esac
cd $DIR
if [ -e $DIR/tools ]
then
EasyWine_install
else
txwk msgbox "`sed -n '181p' $language`"
EasyWine_setup
fi
elif [ "$ot" = "net" ]
then
txwk msgbox "`sed -n '182p' $language`"
EasyWine_install
else
EasyWine_setup
fi


else
txwk msgbox "`sed -n '183,184p' $language`"
EasyWine_setup
fi
}

EasyWine_install()
{
TITLE="`sed -n '185p' $language`"
MAKE="/tmp/make.$$"
TEMP="/tmp/wine.log"

echo >$TEMP
/bin/ln -s /usr/bin/make $MAKE

$Xdev --wrap --ok-label "$ok_l" --cancel-label "$qx_l" --title "$TITLE" --yesno "`sed -n '187p' $language`" 0 0
 case $? in
	0) ;;
	1) exit;;
	255) exit;;
esac
(

#--- defaults (change these if you are a packager)
CONFARGS=""                   # configure args, e.g. --prefix=/usr
prefix=/usr/local             # installation prefix
bindir=$prefix/bin            # where winelib apps will be (or are) installed
libdir=$prefix/lib            # where libwine.so will be (or is) installed
BINDIST=no                    # whether called from a binary package config script

# functions

function std_sleep {
  sleep 1
}

function conf_question {
  # parameters: $1 = importance, $2 = question-id, $3+ = message lines
  # the first two parameters can be used by e.g. debconf in debian packages
  # but here we just print the message
  shift 2
  echo
  local LINE="$1"
  while [ $# -gt 0 ] && shift
  do {
    echo "$LINE"
    LINE="$1"
  }
  done
}

function conf_reset_question {
  # parameters: $1 = question-id
  # this is used to flush any cached answers and "already-displayed" flags
  shift # dummy command
}

function conf_yesno_answer {
  unset ANSWER
$Xdev --buttons-style text --yesno "`sed -n '188p' $language`" 0 0 
 case $? in
	0) ANSWER=yes ;;
	1) ANSWER=no ;;
	255)  ;;
esac
  while [ "$ANSWER" != 'yes' ] && [ "$ANSWER" != 'no' ]
  do {
    echo -n "$1"
    read ANSWER
  }
  done
}

function conf_string_answer {

  echo -n "$1"
  read ANSWER
}

# startup...

echo "`sed -n '189p' $language`"
echo
echo "           http://www.linuxgame.org"
echo "***************************************"
if [ "$ot" = "net" ]
then
echo
rm Wine-0.9.10.tar.bz2
 dload="http://ibiblio.org/pub/linux/system/emulators/wine/Wine-0.9.10.tar.bz2"
 sysname="Wine-0.9.10.tar.bz2"
 dlsize="10618613"
ewdown
echo
tar xjvf Wine-0.9.10.tar.bz2 -C $homedir/ 2>&1 |cat >> $logfile
cd $homedir/Wine-0.9.10
fi

if [ "$BINDIST" = 'no' ]
then {

  if ! [ -f configure ]
  then {
    if [ -f ../configure ]
    then {
      pushd ..
    }
    else {
      echo "`sed -n '191p' $language`"
      echo "`sed -n '192p' $language`"
      echo
      echo "`sed -n '190p' $language`"
      exit 1
    }
    fi
  }
  fi

  if [ ! -w . ]
  then {
    echo "`sed -n '193p' $language`"
    echo "`sed -n '194p' $language`"
    echo
    echo "`sed -n '190p' $language`"
    exit 1
  }
  fi

  # check whether RPM installed, and if it is, remove any old wine rpm.
  hash rpm &>/dev/null
  RET=$?
  if [ $RET -eq 0 ]; then
    if [ -n "`rpm -qi wine 2>/dev/null|grep "^Name"`" ]; then
      echo "`sed -n '195p' $language`"
      conf_yesno_answer #"(yes/no) "
      if [ "$ANSWER" = 'yes' ]; then
        echo "`sed -n '196p' $language`"
        echo
        echo 闂傚倷娴囬褏锟芥稈鏅犻、娆撳冀椤撶偤妫峰銈嗙墱閸嬫稓绮婚婊愭嫹閻熸澘顏鐟邦儔�1�7�劑鎳為妷锝勭盎闂佸搫鍟崐鐢稿箯閿熺姵鐓曢幖娣灩婵洭鏌嶇憴鍕伌妞ゃ垺绋戦～婵嬪硄1�7閻愰潧骞楅梺璇叉唉椤煤閳哄啯顫曢柡鍥╁Т閸ㄦ繈鏌嶉崫鍕1�7櫤闁稿鐗楅妵鍕敂閸♀晜顥�RPM
        su -c "rpm -e wine; RET=$?"
        if [ $RET -eq 0 ]; then
          echo 闂傚倸鍊峰ù鍥敋瑜嶉湁闁绘垼妫勭粻鐘绘煙閹规劦鍤欓悗姘槹閵囧嫰骞掗幋婵愪患闂佹悶鍔岄崐鍧楀蓟閵娾晜鍋嗛柛灞剧☉椤忥拄1�7      else
          echo "`sed -n '197,198p' $language`"
        fi
      else
        echo "`sed -n '199,202p' $language`"
        echo
        echo "`sed -n '190p' $language`"
        exit 1
      fi
    fi
  fi

  # check whether wine binary still available
  if [ -n "`which wine 2>/dev/null|grep '/wine'`" ]; then
    echo "`sed -n '203,210p' $language`"
    conf_yesno_answer #"(yes/no) "
    UNINSTALL="$ANSWER"
    if [ "$UNINSTALL" = "yes" ]
    then
    echo
    else
    echo
    echo "`sed -n '190p' $language`"
    exit 1
    fi
  fi

  # run the configure script, if necessary

  if [ -f config.cache ] && [ -f Makefile ] && [ Makefile -nt configure ]
  then {
    echo
    echo "`sed -n '211p' $language`"
    std_sleep
    # load configure results
    . ./config.cache
  }
  else {
    echo "`sed -n '212p' $language`"
    echo
    if ! ./configure -C $CONFARGS --prefix=$prefix
    then {
      echo
      echo "`sed -n '213p' $language`"
      rm -f config.cache
      echo
      echo "`sed -n '190p' $language`"
      exit 1
    }
    fi
    # load configure results
    . ./config.cache
    # make sure X was found
    eval "$ac_cv_have_x"
    if [ "$have_x" != "yes" ]
    then {
      echo "`sed -n '214p' $language`"
      rm -f config.cache
      echo
      echo "`sed -n '190p' $language`"
      exit 1
    }
    fi
  }
  fi


  if [ `whoami` = 'root' ]
  then {

    ROOTINSTALL="yes"

    if [ "$ROOTINSTALL" = "yes" ]
    then {

      sucommand="make install"

      if [ -f /etc/ld.so.conf ]
      then
        if ! grep -s "$libdir" /etc/ld.so.conf >/dev/null 2>&1
        then {
          echo
          echo "$libdir `sed -n '215,216p' $language`"
          sucommand="$sucommand;echo $libdir>>/etc/ld.so.conf"
        }
        fi

        sucommand="$sucommand;$ac_cv_path_LDCONFIG"
      fi
    }
    fi 

    echo

    echo "`sed -n '217,218p' $language`"
    echo
    std_sleep

    if ! { make; }
    then {
      if ! { make depend && make; }
      then {
        echo
        echo "`sed -n '219p' $language`"
        echo
        echo "`sed -n '190p' $language`"
        exit 1
      }
      fi
    }
    fi

    if [ "$ROOTINSTALL" = "yes" ]
    then {
      echo

      echo "`sed -n '220p' $language`"

      std_sleep

      if ! su root -c "$sucommand"
      then {
      	if ! su root -c "$sucommand"
        then {
      	     echo
             echo "`sed -n '225p' $language`"
             echo "`sed -n '226p' $language` '$sucommand'."
             echo "`sed -n '221,224p' $language`"
             echo
             echo "`sed -n '190p' $language`"
             exit 1
         }
         fi
       }
      fi

      echo

      if [ ! `which wine` ]
      then
        echo "`sed -n '227,228p' $language`"
        echo
        echo "`sed -n '190p' $language`"
        exit 1;
      fi

      WINEINSTALLED=yes
    }
    else {
      WINEINSTALLED=no
    }
    fi 
  }
  fi 

}
fi 

if [ "$WINEINSTALLED" = 'no' ]
then
    tools/wineprefixcreate --use-Wine-tree .
else
    wineprefixcreate
fi
echo



echo
echo "`sed -n '229,234p' $language`"
echo
echo "`sed -n '190p' $language`"

exit 0

) | /bin/cat >$TEMP &

PID=$!

$Xdev --title "$TITLE" --no-button --smooth --tailbox $TEMP 20 80
/usr/bin/killall $MAKE 2>/dev/null
kill $PID 2>/dev/null
/bin/rm -f $MAKE
echo >$TEMP
}

EasyWine_8()
{
$Xdev --backtitle "`sed -n '235p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
        --radiolist "`sed -n '361,363p' $language`" 16 40 0 \
   "<01>" "`sed -n '236p' $language`" on \
   "<02>" "`sed -n '237p' $language`" off  2> /tmp/menuF.tmp.$$

retval=$?

for i in `cat /tmp/menuF.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menuF.tmp.$$ >& /dev/null;
then
FG=win2000
fi

if grep "<02>" /tmp/menuF.tmp.$$ >& /dev/null;
then
FG=Wine
fi

;;
  1)
  rm -f /tmp/menuF.tmp.$$
    EasyWine_20;;
  255)
  rm -f /tmp/menuF.tmp.$$
    EasyWine_20;;
esac

rm -f /tmp/menuF.tmp.$$

if [ "$FG" = "win2000" ]
then
cp $setupdir/reg/win2kcolor.reg $cdrivedir/win2kcolor.reg
regedit $cdrivedir/win2kcolor.reg
rm $cdrivedir/win2kcolor.reg
elif [ "$FG" = "Wine" ]
then
cp $setupdir/reg/keramikcolor.reg $cdrivedir/keramikcolor.reg
regedit $cdrivedir/keramikcolor.reg
rm $cdrivedir/keramikcolor.reg
else
EasyWine_20
fi
EasyWine_20
}

warn1()
{
if [ ! -f $logfile ] ; then
$Xdev --wrap \
      --title "$EWVER" \
      --yesno "$username `sed -n '238,239p' $language`" 0 0

case $? in
  0)
    EasyWine_1;;
  1)
 exit 0;;
  255)
 exit 0;;
esac
fi
}

winelinkfix()
{
localegu
if [ "$lc" = "zh_CN.GB" ]
then
if [ ! `which magic_locale_to_utf8.sh` ]
then
iw=`which wineshelllink`
diff1=`diff -q $setupdir/shelllink/wineshelllink $iw`
if [ "$diff1" = "Files $setupdir/shelllink/wineshelllink and $iw differ" ]
then
if [ `whoami` = 'root' ]
then
cp $iw $tempdir
cp $setupdir/shelllink/wineshelllink $iw
chmod +x $iw
txwk msgbox "`sed -n '240p' $language`"
EasyWine_20
else
txwk msgbox "`sed -n '241,243p' $language`"
EasyWine_20
fi
fi
fi
else
iw=`which wineshelllink`
diff1=`diff -q $setupdir/shelllink/wineshelllink $iw`
if [ "$diff1" = "Files $setupdir/shelllink/wineshelllink and $iw differ" ]
then
if [ `whoami` = 'root' ]
then
cp $iw $tempdir
cp $setupdir/shelllink/oldshelllink $iw
chmod +x $iw
txwk msgbox "`sed -n '240p' $language`"
EasyWine_20
else
txwk msgbox "`sed -n '241,243p' $language`"
EasyWine_20
fi
fi
fi
txwk msgbox "`sed -n '337p' $language`"
}

EasyWine_20()
{
if [ $language = "$setupdir/language/en_US.txt" ];then
$Xdev --title "$EWVER" \
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
        --menu "`sed -n '244p' $language`" 17 55 0 \
   "<01>" "Configurate Wine Fonts as simsun"\
   "<02>" "Chage Wine interface style"\
   "<03>" "Debug Windows software"\
   "<04>" "Load REG register file"\
   "<05>" "Load INF configuration files"\
   "<06>" "Register DLL file to Wine configuration"\
   "<07>" "Fix Wineshelllink bug"\
   "<08>" "Select EasyWine language"\
   "<09>" "Online update EasyWine" 2> /tmp/menu20.tmp.$$
else
$Xdev --title "$EWVER" \
	 --ok-label "$ok_l" \
	--cancel-label "$cancel_l" \
        --menu "`sed -n '244p' $language`" 17 41 0 \
   "<01>" "`sed -n '245p' $language`"\
   "<02>" "`sed -n '246p' $language`"\
   "<03>" "`sed -n '247p' $language`"\
   "<04>" "`sed -n '248p' $language`"\
   "<05>" "`sed -n '249p' $language`"\
   "<06>" "`sed -n '250p' $language`"\
   "<07>" "`sed -n '39p' $language`"\
   "<08>" "`sed -n '251p' $language`"\
   "<09>" "`sed -n '252p' $language`" 2> /tmp/menu20.tmp.$$
fi
retval=$?

for i in `cat /tmp/menu20.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menu20.tmp.$$ >& /dev/null;
then
EasyWine_6
fi

if grep "<02>" /tmp/menu20.tmp.$$ >& /dev/null;
then
EasyWine_8
fi

if grep "<03>" /tmp/menu20.tmp.$$ >& /dev/null;
then
debugwine
fi

if grep "<04>" /tmp/menu20.tmp.$$ >& /dev/null;
then
regin
fi

if grep "<05>" /tmp/menu20.tmp.$$ >& /dev/null;
then
infin
fi

if grep "<06>" /tmp/menu20.tmp.$$ >& /dev/null;
then
zcdll
fi

if grep "<07>" /tmp/menu20.tmp.$$ >& /dev/null;
then
winelinkfix
fi

if grep "<08>" /tmp/menu20.tmp.$$ >& /dev/null;
then
langures
fi

if grep "<09>" /tmp/menu20.tmp.$$ >& /dev/null;
then
update
fi
;;
  1)
  rm -f /tmp/menu20.tmp.$$
    EasyWine_setup;;
  255)
  rm -f /tmp/menu20.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menu20.tmp.$$
EasyWine_setup
}

regin()
{
regin_l="`sed -n '253p' $language`"
FILE=`$Xdev --stdout --ok-label "$ok_l" --cancel-label "$cancel_l" --title "$regin_l" --fselect $homedir 0 0`
case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		regin
		fi
		regedit $FILE;;
	1)
		EasyWine_20;;
	255)
		EasyWine_20;;
esac
  txwk msgbox "`sed -n '254p' $language`"
EasyWine_20
}

infin()
{
infin_l="`sed -n '255p' $language`"
FILE=`$Xdev --stdout --ok-label "$ok_l" --cancel-label "$cancel_l" --title "$infin_l" --fselect $homedir 0 0`
case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		infin
		fi
wine rundll32 setupapi.dll,InstallHinfSection DefaultInstall 128 $FILE 2>&1 |cat >> $logfile;;
	1)
		EasyWine_20;;
	255)
		EasyWine_20;;
esac
  txwk msgbox "`sed -n '256p' $language`"
EasyWine_20
}

zcdll()
{
$Xdev --title "`sed -n '257p' $language`" \
--ok-label "$ok_l" \
--cancel-label "$cancel_l" \
        --inputbox "`sed -n '258,259p' $language`" 20 45 2> /tmp/dllbox1.tmp.$$

retval=$?

REGDLLFILES=`cat /tmp/dllbox1.tmp.$$`
rm -f /tmp/dllbox1.tmp.$$

case $retval in
  0)
regsvr32 $REGDLLFILES
;;
  1)
    EasyWine_20;;
  255)
    EasyWine_20;;
esac
  txwk msgbox "`sed -n '260p' $language`"
EasyWine_20
}

debugwine()
{
debug_l="`sed -n '261p' $language`"
FILE=`$Xdev --stdout --ok-label "$ok_l" --cancel-label "$cancel_l" --title "$debug_l" --fselect $homedir 0 0`
case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		debugwine
		fi
		debugwine0;;
	1)
		EasyWine_20;;
	255)
		EasyWine_20;;
esac
}

debugwine0()
{
debug_l="`sed -n '262p' $language`"
debug_l1="`sed -n '264p' $language`"
debug_l2="`sed -n '265p' $language`"
debug_l3="`sed -n '266p' $language`"
DLL=`$Xdev	--stdout --separator "|" \
		--title "$debug_l" \
--wizard \
--cancel-label "$qx_l" \
		--2inputsbox "$debug_l1" 0 0 \
			     "$debug_l2" "" \
			     "$debug_l3" "" `

ret=$?

case $ret in
	0)
		ndll=`echo $DLL | awk --source 'BEGIN { FS="|" }' --source '{ print $1 }'`
		bdll=`echo $DLL | awk --source 'BEGIN { FS="|" }' --source '{ print $2 }'`
		debugwine1
		;;
	1)
		EasyWine_setup
		;;
	3)
		debugwine
		;;
	255)
		EasyWine_setup
		;;
esac
}

debugwine1()
{
debug_l4="`sed -n '263p' $language`"
debug_l5="`sed -n '267p' $language`"
debug_l6="`sed -n '268,269p' $language`"
debug_l7="`sed -n '270,271p' $language`"
DLL1=`$Xdev	--stdout --separator "|" \
		--title "$debug_l4" \
--wizard \
--cancel-label "$qx_l" \
		--2inputsbox "$debug_l5" 0 0 \
			     "$debug_l6" "" \
			     "$debug_l7" "" `

ret=$?

case $ret in
	0)
		nbdll=`echo $DLL1 | awk --source 'BEGIN { FS="|" }' --source '{ print $1 }'`
		bndll=`echo $DLL1 | awk --source 'BEGIN { FS="|" }' --source '{ print $2 }'`
		debugwine2
		;;
	1)
		EasyWine_setup
		;;
	3)
		debugwine0
		;;
	255)
		EasyWine_setup
		;;
esac
}

debugwine2()
{
$Xdev --title "$EWVER" \
--backtitle "`sed -n '272p' $language`" \
--wizard \
--cancel-label "$qx_l" \
--radiolist "`sed -n '273,274p' $language`" 20 50 0 \
   "<01>" "Microsoft Windows 2.0" off \
   "<02>" "Microsoft Windows 3.0" off \
   "<03>" "Microsoft Windows 3.1" off \
   "<04>" "Microsoft Windows NT 3.51" off \
   "<05>" "Microsoft Windows NT 4.0" off \
   "<06>" "Microsoft Windows 95" off \
   "<07>" "Microsoft Windows 98" on \
   "<08>" "Microsoft Windows ME" off \
   "<09>" "Microsoft Windows 2000" off \
   "<10>" "Microsoft Windows XP" off \
   "<11>" "Microsoft Windows 2003" off 2> /tmp/menuwv.tmp.$$

retval=$?

for i in `cat /tmp/menuwv.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win20"
fi

if grep "<02>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win30"
fi

if grep "<03>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win31"
fi

if grep "<04>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="nt351"
fi

if grep "<05>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="nt40"
fi

if grep "<06>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win95"
fi

if grep "<07>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win98"
fi

if grep "<08>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="winme"
fi

if grep "<09>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win2k"
fi

if grep "<10>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="winxp"
fi

if grep "<11>" /tmp/menuwv.tmp.$$ >& /dev/null;
then
version1="win2k3"
fi
;;
  1)
  rm -f /tmp/menumv.tmp.$$
    EasyWine_setup;;
  3)
    debugwine1;;
  255)
  rm -f /tmp/menumv.tmp.$$
    EasyWine_setup;;
esac

rm -f /tmp/menumv.tmp.$$

if [ `which wineserver` ]
then
wineserver -k
else
/usr/lib/wine/wineserver -k
fi

WINEDEBUG=+loaddll Version="$version1"  WINEDLLOVERRIDES="$bdll=b ,$ndll=n, $bndll=b,n ,$nbdll=n,b" wine  "$FILE" 2>&1 |cat > /tmp/debugwine.log.$$

wineboot


echo "
*******************************************************************
`sed -n '275p' $language`
*******************************************************************
" > $tempdir/debugwine.log
sed -n '/loaddll/p' /tmp/debugwine.log.$$ >>$tempdir/debugwine.log
echo "
*******************************************************************
`sed -n '276p' $language`
*******************************************************************
" >> $tempdir/debugwine.log
sed -n '/Try setting Windows version/p' /tmp/debugwine.log.$$ >>$tempdir/debugwine.log
echo "
*******************************************************************
`sed -n '277,278p' $language`
*******************************************************************
" >> $tempdir/debugwine.log
sed -n '/could not load L/p' /tmp/debugwine.log.$$ >>$tempdir/debugwine.log
echo "
*******************************************************************
`sed -n '279p' $language`
*******************************************************************
" >> $tempdir/debugwine.log
sed -n '/Unloaded module/p' /tmp/debugwine.log.$$ >>$tempdir/debugwine.log
echo "
*******************************************************************
`sed -n '280p' $language`
*******************************************************************
" >> $tempdir/debugwine.log
sed -n '/err:/p' /tmp/debugwine.log.$$ >>$tempdir/debugwine.log
echo "
*******************************************************************
`sed -n '281,282p' $language`
*******************************************************************
" >> $tempdir/debugwine.log
 sed -e '1,/WineDbg starting/d' "$0" |sed -e '1,/WineDbg starting/d' /tmp/debugwine.log.$$ >>$tempdir/debugwine.log

$Xdev --title "TEXT BOX" \
	 --ok-label "`sed -n '283p' $language`" \
	--cancel-label "`sed -n '284p' $language`" \
	--textbox "$tempdir/debugwine.log" 0 0
case $? in
  0)
save_l="`sed -n '285p' $language`"
    DIR=`$Xdev --stdout --cancel-label "$qx_l" --ok-label "$ok_l"  --title "$save_l" --dselect $homedir 0 0`
case $? in
	0)
		if [ "$DIR" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_setup
		fi
		cp $tempdir/debugwine.log $DIR/debugwine.log;;
	1)
		EasyWine_20;;
	255)
		EasyWine_20;;
esac;;
  1)
    EasyWine_20;;
  255)
    EasyWine_20;;
esac
EasyWine_20
}

EasyWine_in()
{
ewin_l="`sed -n '286p' $language`"
FILE=`$Xdev --ok-label "$ok_l" --cancel-label "$cancel_l" --stdout --title "$ewin_l" --fselect $homedir 0 0`
case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_in
		fi;;
	1)
		EasyWine_5;;
	255)
		EasyWine_5;;
esac
code="`sed -n '1p' $FILE`"
name="`sed -n '2p' $FILE`"
progame4="`sed -n '4p' $FILE`"
progame5="`sed -n '5p' $FILE`"
progame6="`sed -n '6p' $FILE`"
progame7="`sed -n '7p' $FILE`"
progame8="`sed -n '8p' $FILE`"
progame9="`sed -n '9p' $FILE`"
line="`sed -n '$p' $FILE`"
fh=" \\\\"
if [ -d "$tempdir/$code" ] || mkdir "$tempdir/$code"
then
sed -n -e '/REGEDIT4/,/;; Regedit-END/p' $FILE >  $tempdir/$code/setup.reg
if [ ! "$line" = ";; Regedit-END" ]
then
sed -e '1,/;; Regedit-END/d' "$0" |sed -e '1,/;; Regedit-END/d' $FILE > $tempdir/$code/plugdll.tar.bz2
cd $tempdir/$code/
tar xjvf plugdll.tar.bz2
rm -f plugdll.tar.bz2
cd
fi
sed '/$othersoft_l/'i\ "'${code}' '${name} '${fh}" $tempdir/EasyWinePlug.sh > /tmp/tmp2.tmp.$$
sed '/#choice/'i\ "${progame4}" /tmp/tmp2.tmp.$$ > /tmp/program.4
sed '/#choice/'i\ "${progame5}" /tmp/program.4 > /tmp/program.5
sed '/#choice/'i\ "${progame6}" /tmp/program.5 > /tmp/program.6
sed '/#choice/'i\ "${progame7}" /tmp/program.6 > /tmp/program.7
if [ $progame9 = "REGEDIT4" ]
then
sed '/#choice/'i\ "${progame8}" /tmp/program.7 > $tempdir/EasyWinePlug.sh
elif [ $progame9 = "fi" ]
then
sed '/#choice/'i\ "${progame8}" /tmp/program.7 > /tmp/program.8
sed '/#choice/'i\ "${progame9}" /tmp/program.8 > $tempdir/EasyWinePlug.sh
rm -f /tmp/program.8
fi
rm -f /tmp/program.4
rm -f /tmp/program.5
rm -f /tmp/program.6
rm -f /tmp/program.7
rm -f /tmp/tmp2.tmp.$$
fi
EasyWine_5
}

EasyWine_out()
{
save_l="`sed -n '285p' $language`"
    DIRL=`$Xdev --stdout --cancel-label "$qx_l" --ok-label "$ok_l"  --title "$save_l" --dselect $homedir 0 0`
case $? in
	0)
		if [ "$DIRL" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		EasyWine_5
		fi
programname
;;
	1)
		EasyWine_5;;
	255)
		EasyWine_5;;
esac
}

programname()
{
rm -f /tmp/ewout*.tmp
intitle_l="`sed -n '287p' $language`"
inbox_l="`sed -n '288p' $language`"
inbox_l1="`sed -n '289,290p' $language`"
inbox_l2="`sed -n '291p' $language`"
inbox_l3="`sed -n '292,294p' $language`"
pname=`$Xdev --stdout --separator "|" \
		--title "$intitle_l" \
		--ok-label "$ne_l" \
		--cancel-label "$cancel_l" \
		--left \
		--3inputsbox "$inbox_l
		" 0 0 \
			 "$inbox_l1" "" \
			"
			$inbox_l2" "" \
			"
			$inbox_l3" "" `

ret=$?

case $ret in
	0)
		pname1=`echo $pname | awk --source 'BEGIN { FS="|" }' --source '{ print $1 }'`
		pname2=`echo $pname | awk --source 'BEGIN { FS="|" }' --source '{ print $2 }'`
		pname3=`echo $pname | awk --source 'BEGIN { FS="|" }' --source '{ print $3 }'`
		;;
	1)
		EasyWine_out
		;;
	3)
		EasyWine_5
		;;
	255)
		EasyWine_5
		;;
esac

		if [ "$pname1" = "" ] || [ "$pname2" = "" ]
		then
		txwk msgbox "`sed -n '339p' $language`"
		programname
		fi

#闂傚倸鍊风粈渚�骞栭位鍥敍閻愭潙浜辨繝鐢靛Т濞层�1�7�绮绘导瀛樼厵闂傚�1�7�顕ˇ锕傛煟椤撶噥娈滈柡灞剧洴閸╁嫰宕橀浣割潓闂備胶绮幖顐﹀箯閻戣姤鐓熼幖杈剧磿閻ｎ參鏌涙惔鈥宠埞閻撱�1�7�鏌曟繛鐐珔闁告垹濞�閺屾稑鐣濋敓浠嬪磻濞戞氨妫憸鏃堝蓟閿濆绠ｆ繝闈涙祩濡偤姊虹拠鑼闁哥姵鍔楅幑銏犫槈閵忕姴鑰块梺褰掑亰閸撴稒绂掗崜褏纾藉ù锝嚽归敓钘夋贡閺侇噣鏁撻悩鍙夌�梺鍦濠㈡﹢鎮欐繝鍥ㄧ厓閺夌偞濯介崗灞矫归悪鍛echo "$pname1" > /tmp/ewout1.tmp

#闂傚倸鍊风粈渚�骞栭位鍥敍閻愭潙浜辨繝鐢靛Т濞层�1�7�绮绘导瀛樼厵闂傚�1�7�顕ˇ锕傛煟椤撶噥娈滈柡灞剧洴閸╁嫰宕橀浣割潓闂備胶绮幖顐﹀箯閻戣姤鐓熼幖杈剧磿閻ｎ參鏌涙惔鈥宠埞閻撱�1�7�鏌曟繛鐐珔闁告垹濞�閺屾稑鐣濋敓浠嬪磻濞戞氨妫憸鏃堝蓟閿濆绠ｆ繝闈涙祩濡偤姊虹拠鑼闁哥姵鍔楅幑銏犫槈閵忕姴鑰块梺褰掑亰閸撴稒�1�7�奸崼銉﹄1�7�甸悷娆忓绾炬悂鏌涙惔銊ゆ喚妞ゃ垺蓱缁虹晫绮欑捄銊ワ拷鐐烘⒑缁洘顫婇柛妯兼櫕閿熻姤姘ㄩ顦塰o "$pname2" >> /tmp/ewout1.tmp

  if [ "$pname3" = "" ]
  then
   regsvrdll="#"
  else
    regsvrdll="regsvr32 $pname3"
  fi

echo "
if grep '$pname1' /tmp/menuew.tmp >& /dev/null;then
regedit $tempdir/$pname1/setup.reg
$regsvrdll
softinstall
fi" >> /tmp/ewout1.tmp
regedit_setup
}

regedit_setup()
{
$Xdev --title "$intitle_l" \
--wizard \
--left \
--cancel-label "$qx_l" \
--inputbox "`sed -n '295,300p' $language`" 20 45 2> /tmp/exebox.tmp.$$

retval=$?

EXEFILE=`cat /tmp/exebox.tmp.$$`
rm -f /tmp/exebox.tmp.$$

if [ "$EXEFILE" = "" ]
then
echo "REGEDIT4" > /tmp/ewout2.tmp
reg_edit
dll
else
exeregfile="Software.*Wine.*AppDefaults.*$EXEFILE]"
exeregfile1="Software.*Wine.*AppDefaults.*$EXEFILE.*DllOverrides"

case $retval in
  0)
if [  ! -e /tmp/ewout2.tmp ] 
then
echo "REGEDIT4" > /tmp/ewout2.tmp
fi
sed -n -e "/$exeregfile/,/Software.*Wine/p" /root/.wine/user.reg > /tmp/8.tmp.$$
sed -e 's/Software/HKEY_CURRENT_USER\\Software/' /tmp/8.tmp.$$ > /tmp/9.tmp.$$
sed -e '$d' /tmp/9.tmp.$$ >>/tmp/ewout2.tmp
sed -n -e "/$exeregfile1/,/Software.*Wine/p" /root/.wine/user.reg > /tmp/81.tmp.$$
sed -e 's/Software/HKEY_CURRENT_USER\\Software/' /tmp/81.tmp.$$ > /tmp/91.tmp.$$
sed -e '$d' /tmp/91.tmp.$$ >>/tmp/ewout2.tmp
rm -f /tmp/8.tpm.$$
rm -f /tmp/9.tpm.$$
rm -f /tmp/81.tpm.$$
rm -f /tmp/91.tpm.$$
;;
  1)
    EasyWine_5;;
  3)
   programname;;
  255)
    EasyWine_5;;
esac

$Xdev --wrap  --ok-label "`sed -n '301p' $language`" --cancel-label "$ne_l"  --title "$EWVER" --buttons-style text --yesno "`sed -n '302,304p' $language`" 0 0
 
 case $? in
	0)regedit_setup;;
	1)reg_edit
	   dll;;
	255) EasyWine_5;;
esac
fi
}

reg_edit()
{
cat << EOF >  /tmp/editbox.tmp.$$
`sed -n '1,$p' /tmp/ewout2.tmp`
EOF

$Xdev --title "$intitle_l"  \
--left \
--backtitle "`sed -n '358,359p' $language`" \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
	--editbox  /tmp/editbox.tmp.$$ 30 110 2>/tmp/ewout2.tmp

case $? in
  0)
    ;;
  1)
rm -f /tmp/ewout2.tmp
rm -f /tmp/editbox.tmp.$$
    regedit_setup
    ;;
  255)
rm -f /tmp/ewout2.tmp
rm -f /tmp/editbox.tmp.$$
    EasyWine_5
    ;;
esac
rm -f /tmp/editbox.tmp.$$
}

dll()
{
$Xdev --wizard \
--cancel-label "`sed -n '6p' $language`" \
 --title "$EWVER" \
--left \
--yesno "`sed -n '305,312p' $language`" 0 0
 
 case $? in
	0)
echo ";; Regedit-END" >>/tmp/ewout2.tmp
dllmain;;
	1)
echo ";; Regedit-END" >>/tmp/ewout2.tmp
cat /tmp/ewout1.tmp /tmp/ewout2.tmp > $DIRL/$pname1.ew 
rm -f /tmp/ewout1.tmp
rm -f /tmp/ewout2.tmp
EasyWine_5;;
        3)regedit_setup;;
	255) EasyWine_5;;
esac
}

dllmain()
{
$Xdev --backtitle "`sed -n '313p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
        --radiolist "`sed -n '314,315p' $language`" 30 50 0 \
   "<01>" " `sed -n '316p' $language` " on \
   "<02>" " `sed -n '317p' $language`"  off 2> /tmp/dll.tmp.$$

retval=$?

for i in `cat /tmp/dll.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/dll.tmp.$$ >& /dev/null;
then
dll1
cd $tempdir
tar -jcvf $tempdir/plugdll.tar.bz2 plugdll
cd /root/Desktop
rm -f $tempdir/plugdll/*.*
if [ -e $cdrivedir/windows/.wineold ]
then
dlldriver="$cdrivedir/windows/system"
else
dlldriver="$cdrivedir/windows/system32"
fi
sed '/if grep/'a\ "cp $tempdir/$pname1/plugdll/*.* $dlldriver" /tmp/ewout1.tmp > /tmp/ewout0.tmp
cat /tmp/ewout0.tmp /tmp/ewout2.tmp $tempdir/plugdll.tar.bz2 > $DIRL/$pname1.ew
rm -f $tempdir/plugdll.tar.bz2
rm -f /tmp/ewout0.tmp
fi

if grep "<02>" /tmp/dll.tmp.$$ >& /dev/null;
then
dll2
cd $tempdir
tar -jcvf $tempdir/plugdll.tar.bz2 plugdll
cd /root/Desktop
rm -f $tempdir/plugdll/*.*
if [ -e $cdrivedir/windows/.wineold ]
then
dlldriver="$cdrivedir/windows/system"
else
dlldriver="$cdrivedir/windows/system32"
fi
sed '/if grep/'a\ "cp $tempdir/$pname1/plugdll/*.* $dlldriver" /tmp/ewout1.tmp > /tmp/ewout0.tmp
cat /tmp/ewout0.tmp /tmp/ewout2.tmp $tempdir/plugdll.tar.bz2 > $DIRL/$pname1.ew
rm -f $tempdir/plugdll.tar.bz2
rm -f /tmp/ewout0.tmp
fi

;;
  1)
  rm -f /tmp/dll.tmp.$$
    dll;;
  255)
  rm -f /tmp/dll.tmp.$$
    EasyWine_setup;;
esac
rm -f /tmp/dll.tmp.$$
rm -f /tmp/ewout1.tmp
rm -f /tmp/ewout2.tmp
rm -f /tmp/ewout.tmp.$$
EasyWine_5
}

dll1()
{
dllfile_l1="`sed -n '318p' $language`"
FILE=`$Xdev --stdout --title "$dllfile_l1" --fselect $cdrivedir/windows 0 0`
case $? in
	0)
		if [ "$FILE" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		dll1
		fi
		if [ -d $tempdir/plugdll ] || mkdir $tempdir/plugdll
		then
		cp "$FILE" $tempdir/plugdll
		fi;;
	1)
		EasyWine_5;;
	255)
		EasyWine_5;;
esac
$Xdev --title "$EWVER" --cancel-label "`sed -n '319p' $language`" --ok-label "`sed -n '320p' $language`"  --left --buttons-style text --yesno "`sed -n '321,326p' $language`" 0 0
 
 case $? in
	0)dll1;;
	1);;
	255) EasyWine_5;;
esac
}

dll2()
{
dllfile_l2="`sed -n '327p' $language`"
DIR=`$Xdev --stdout --cancel-label "$qx_l" --ok-label "$ok_l"  --title "$dllfile_l2" --dselect $homedir 0 0`

case $? in
	0)
		if [ "$DIR" = "" ]
		then
		txwk msgbox "`sed -n '338p' $language`"
		dll2
		fi
		if [ -d $tempdir/plugdll ] || mkdir $tempdir/plugdll
		then
		cp $DIR/*.* $tempdir/plugdll
		fi;;
	1)
		EasyWine_setup;;
	255)
		EasyWine_setup;;
esac
}

update()
{
if [ `whoami` = 'root' ]
then
rm -f ewver.txt
wget http://software.lupaworld.com/pub/deman/ewver.txt
if [ ! -e ewver.txt ];then
txwk msgbox "`sed -n '57p' $language`"
EasyWine_20
fi
EWVERN="`sed -n '1p' ewver.txt`"
if [ "$EWVERN" = "$EWVER" ]; then
txwk msgbox "$EWVER `sed -n '340p' $language`"
rm -f ewver.txt
EasyWine_20
else
$Xdev --wrap \
      --title "`sed -n '252p' $language`" \
	 --ok-label "`sed -n '341p' $language`" \
	--cancel-label "`sed -n '342p' $language`" \
      --yesno "`sed -n '343p' $language` $EWVERN" 0 0
 
 case $? in
	0);;
	1)rm -f ewver.txt
	EasyWine_20;;
	255) rm -f ewver.txt
	EasyWine_setup;;
esac
 dload="`sed -n '2p' ewver.txt`"
 sysname="`sed -n '3p' ewver.txt`"
 dlsize="`sed -n '4p' ewver.txt`"
ewdown
  sed -e '1,/#EasyWineBIN/d' "$0" |sed -e '1,/#EasyWineBIN/d' $sysname > /tmp/EasyWine.tar.bz2
  cd /
  tar xjvf /tmp/EasyWine.tar.bz2>tmp/EasyWine
cd
txwk msgbox "`sed -n '344p' $language`"
exit 1
fi
else
txwk msgbox "`sed -n '345p' $language`"
fi
}

langures()
{
$Xdev --backtitle "`sed -n '333p' $language`" \
	--title "$EWVER" \
	 --ok-label "$ne_l" \
	--cancel-label "$cancel_l" \
        --radiolist "`sed -n '334,335p' $language`" 0 0 0 \
   "<01>" " `sed -n '336p' $language`"  on \
   "<02>" " `sed -n '364p' $language`"  off \
   "<03>" " `sed -n '365p' $language`"  off 2> /tmp/menulan.tmp.$$ 

retval=$?

for i in `cat /tmp/menulan.tmp.$$`
do
	choice=$i
done

case $retval in
  0)
if grep "<01>" /tmp/menulan.tmp.$$ >& /dev/null;
then
echo "$setupdir/language/zh_CN.txt" > $homedir/.EasyWineLanguage
language="`sed -n '1p' $homedir/.EasyWineLanguage`"
fi

if grep "<02>" /tmp/menulan.tmp.$$ >& /dev/null;
then
echo "$setupdir/language/zh_TW.txt" > $homedir/.EasyWineLanguage
language="`sed -n '1p' $homedir/.EasyWineLanguage`"
fi

if grep "<03>" /tmp/menulan.tmp.$$ >& /dev/null;
then
echo "$setupdir/language/en_US.txt" > $homedir/.EasyWineLanguage
language="`sed -n '1p' $homedir/.EasyWineLanguage`"
fi

;;
  1)
  rm -f /tmp/menulan.tmp.$$
    EasyWine_20;;
  255)
  rm -f /tmp/menulan.tmp.$$
    EasyWine_20;;
esac
rm -f /tmp/menulan.tmp.$$
}

localegu()
{
echo "$LANG" >/tmp/lg.tmp.$$

if grep "zh_CN" /tmp/lg.tmp.$$ >& /dev/null ; then
if grep "UTF8" /tmp/lg.tmp.$$ >& /dev/null ; then
lc="zh_CN.UTF8"
elif grep "utf8" /tmp/lg.tmp.$$ >& /dev/null ; then
lc="zh_CN.UTF8"
elif grep "utf-8" /tmp/lg.tmp.$$ >& /dev/null ; then
lc="zh_CN.UTF8"
elif grep "UTF-8" /tmp/lg.tmp.$$ >& /dev/null ; then
lc="zh_CN.UTF8"
else
lc="zh_CN.GB"
fi
fi

rm -f /tmp/lg.tmp.$$
}

ewdown()
{
ewdown_l="`sed -n '332p' $language`"
ewdown_dl="`sed -n '329p' $language`"
ewdown_dl1="`sed -n '330p' $language`"
ewdown_dl2="`sed -n '331p' $language`"
if [ "$dload" = "none" ]; then
 [ "$dlsize" = "" ] && mount_cd
 else
 PROGRESS="`ls -l "$sysname" 2>/dev/null |sed -e \"s/\ \+/,/g\"|cut -d\, -f5`"
 realdownload=1
 [ -n "$PROGRESS" ] && echo "$PROGRESS bytes previously downloaded"
 if [ "$PROGRESS" = "$dlsize" ]; then
 realdownload=0
txwk msgbox "`sed -n '328p' $language`"
 fi 
 
 if [ "$realdownload" = "1" ]; then
 echo "downloading $dload to $sysname with $dlsize bytes..."
 PROGRESS="0"
 > $sysname
 {
 wget "$dload" -O "$sysname" 2>wget.errors &
 echo 0
 while [ "$PROGRESS" != "$dlsize" ]
 do
 PROGRESS="`ls -l "$sysname" |sed -e \"s/\ \+/,/g\"|cut -d\, -f5`"
 grep "Not Found." wget.errors &>/dev/null && PROGRESS="$dlsize"
 echo $[PROGRESS*100/dlsize] 
 sleep 1s
 done
 echo 100
 } | $Xdev --title "$ewdown_dl" --gauge "$ewdown_dl1 $sysname $ewdown_dl2 $dlsize b" 7 60 0
 grep "Not Found." wget.errors &>/dev/null
 if [ "$?" = "0" ]; then
 echo "$sysname = download failed at `date \"+%d.%m.%Y %H:%M:%S\"`" >> wget.errors
 ERR="wget.errors"
 $Xdev --title "wine status" \
 --no-cancel \
 --msgbox "$ewdown_l" 7 70
 fi
 fi
 fi
}

if [ ! -z "DISPLAY" ]; then
   if [ $# -eq 0 ]; then
    EasyWine_setup
  fi
fi
     
exit 1
