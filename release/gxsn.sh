










read qr
if [ -d okyh/src/ef ];then
if [ "088" = "$qr" ];then
svn del https://okyh.googlecode.com/svn/trunk/okyh --username chenkan577@sohu.com --password jv9EM4DJ3CM5 -m b2 
svn import ./okyh https://okyh.googlecode.com/svn/trunk/okyh --username chenkan577@sohu.com --password jv9EM4DJ3CM5 -m b2
fi;fi

