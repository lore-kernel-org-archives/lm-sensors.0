From: tderooy@optonline.net (Tonko de Rooy)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: IBM sensor drivers for xSeries Servers
Message-Id: <000501c383d7$4b8d8900$bf824109@tderooy>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just wanted to let people know that IBM has Linux drivers available for
download as source under the GPL.
The problem is that these drivers are mainly meant for IBM Director which is
a client/server management tool where you have a 'thin' client on the
machine and a Director Server somewhere else to manage them.
For ASMP systems there is a commandline interface to the driver, but ISMP
systems are out of luck in this regard.
Still as the sourcecode is provided, if anyone wants to have a look at it,
or make the ISMP work without Director....

For so called ISMP systems (x335, x345 and other recent IBM servers, but not
those with RSA adapters)
ftp://ftp.software.ibm.com/pc/pccbbs/pc_servers/ibmdirectorsmbredhatlinux.zip
ftp://ftp.software.ibm.com/pc/pccbbs/pc_servers/ibmdirectorsmbsuselinux.zip

These are ZIP files containing a bizarre binary 'source' RPM which you can
unpack (to get to the source) using
rpm2cpio ibmsmb-src-redhat-4.10-1.i386.rpm |cpio -ivd

It contains:
binsetup  i2cich.h  i2cpiix4.c  i2cvia.h           ibmsmb-src.spec  pci.h
dump.h    i2cio.c   i2cpiix4.h  ibmsmb.h           ibmsmbstart
README.TXT
i2cali.c  i2cio.h   i2csis.c    ibmsmb.initscript  ibmsmbstop       setup
i2cali.h  i2cos.c   i2csis.h    ibmsmbremove       Makefile
smbmain.c
i2cich.c  i2cos.h   i2cvia.c    ibmsmb.spec        pci.c            sysdep.h

ibmsmblib:
dump.h  ibmi2clib.c  ibmsmb.h  ibmsmblib.c


In addition for older (ASMP) systems (e.g x330, x340 and systems with RSA
adapters)
ftp://ftp.software.ibm.com/pc/pccbbs/pc_servers/ibmasm-src-redhat-wrp131a.rpm
ftp://ftp.software.ibm.com/pc/pccbbs/pc_servers/ibmasm-src-suse-wrp131a.rpm

again to unpack (to get to the source)
rpm2cpio ibmasm-src-redhat-wrp131a.rpm |cpio -ivd

It contains:
binsetup           ibmasm.spec  ibmspremove  README.TXT  setup
ibmasm.initscript  ibmspdown    ibmspup      remove

exe:
ibmasm    ibmasm.h    ibmsphalt.c  ibmsprem.c  ibmsptxt.c
ibmasm.c  ibmspgui.c  ibmsprem2.c  ibmsprem.h

shlib:
libsysSp.so  uwiapi.c

src:
ddinst.h          serial.c  sysdrv.h    uwscmd.c    uwsisa.c    uwsutil.c
ibmasmincludes.h  serpci.c  sysplx.h    uwscmd.h    uwspci.c
Makefile          slim.c    sysscout.h  uwsConfg.c  uwsqueue.c
serial22.c        slim.h    uwioctl.h   uwsevent.c  uwsrem.c
serial24.c        sysapi.h  uwsasr.c    uwsioctl.c  uwsrem.h

Lastly for ASMP systems there is mpcli which is a JAVA based command line
interface to either the ASMP device driver (in-band) or ASMA/RSA adapter
(out-of-band).
ftp://ftp.software.ibm.com/pc/pccbbs/pc_servers/mpcli-2.0-1.0.i386.rpm
ftp://ftp.software.ibm.com/pc/pccbbs/pc_servers/mpcli-d3barmst.pdf

Note: the above links will probably break when new versions are released and
the old once removed.
