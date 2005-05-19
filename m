From: ishikawa@yk.rim.or.jp (Ishikawa)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <3EF8734D.AEAB1A02@yk.rim.or.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> If you're going to send the output of make, please get the latest
> CVS of everything (i2c and lm_sensors2) not just these two files.
> We've already cleaned up a lot of warnings.
> 

Here is the compilation of CVS lm_sensors (against CVS lk 2.4 i2c)
using gcc 3.3.
This is under linux 2.4.21.

Lots of warnings from linux kernel 2.4.21 header (which
we can't do much at this stage, but I intend to 
send a patch to the problematic file asm/system.h for x86
to linux kernel mailing list.).

Aside from the warning from system.h, we see several compilation
warings from various files.
But not that many.

Happy Hacking,

Ishikawa, Chiaki

PS : During a compilation of CVS i2c modules,
there was a very strange interaction of 
LC_ALL and LANG setting and gcc/sed behavior, but
I simply set LC_ALL=C and LANG=C and
got away with it.

I attach the problem at the end, but this is more like
the I18N/L10N problem of the said toos including gcc, sed, make, etc..)



-- 
int main(void){int j 03;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
-------------- next part --------------
Hi, 

Here is the log of the latest CVS lm_sensors2 compilation
(using cvs i2c.) using GCC 3.3.

Lots of warnings from linux kernel 2.4.21 header (which
we can't do much at this stage, but I intend to
send a patch to the problematic file asm/system.h for x86
to linux kernel mailing list.).

Aside from the warning from system.h, we see several compilation
warings from various files.
But not that many.

Happy Hacking,

Ishikawa, Chiaki

PS : During a compilation of CVS i2c modules,
there was a very strange interaction of 
LC_ALL and LANG setting and gcc/sed behavior, but
I simply set LC_ALL=C and LANG=C and
got away with it.

I attach the problem at the end, but this is more like
the I18N/L10N problem of the said toos including gcc, sed, make, etc..)



---


ishikawa@duron$ 
ishikawa@duron$ make clean
rm -f mkpatch/.temp
rm -f kernel/*.o kernel/*.d
rm -f kernel/busses/*.o kernel/busses/*.d
rm -f kernel/chips/*.o kernel/chips/*.d
rm -f kernel/include/*.h.install kernel/include/sensors.h kernel/include/sensors.hd
rm -f lib/*.ld lib/*.ad
rm -f lib/*.lo lib/*.ao
rm -f lib/libsensors.a lib/libsensors.so.2.0.0 lib/libsensors.so.2 lib/libsensors.so lib/conf-parse.h lib/conf-parse.c lib/conf-lex.c
rm -f prog/sensors/*.rd prog/sensors/*.ro 
rm -f prog/sensors/sensors
rm -f prog/dump/*.rd prog/dump/*.ro prog/dump/isadump prog/dump/i2cdump prog/dump/i2cset
rm -f prog/detect/*.rd prog/detect/*.ro prog/detect/i2cdetect prog/detect/dmidecode
rm -f lm_sensors-*
ishikawa@duron$ make all
Makefile:243: kernel/busses/i2c-nforce2.d: No such file or directory
Makefile:243: kernel/busses/i2c-ali1535.d: No such file or directory
Makefile:243: kernel/busses/i2c-ali15x3.d: No such file or directory
Makefile:243: kernel/busses/i2c-amd756.d: No such file or directory
Makefile:243: kernel/busses/i2c-amd8111.d: No such file or directory
Makefile:243: kernel/busses/i2c-hydra.d: No such file or directory
Makefile:243: kernel/busses/i2c-i801.d: No such file or directory
Makefile:243: kernel/busses/i2c-i810.d: No such file or directory
Makefile:243: kernel/busses/i2c-isa.d: No such file or directory
Makefile:243: kernel/busses/i2c-sis5595.d: No such file or directory
Makefile:243: kernel/busses/i2c-sis630.d: No such file or directory
Makefile:243: kernel/busses/i2c-sis645.d: No such file or directory
Makefile:243: kernel/busses/i2c-piix4.d: No such file or directory
Makefile:243: kernel/busses/dmi_scan.d: No such file or directory
Makefile:243: kernel/busses/i2c-savage4.d: No such file or directory
Makefile:243: kernel/busses/i2c-via.d: No such file or directory
Makefile:243: kernel/busses/i2c-viapro.d: No such file or directory
Makefile:243: kernel/busses/i2c-voodoo3.d: No such file or directory
Makefile:243: kernel/chips/ds1307.d: No such file or directory
Makefile:243: kernel/chips/smartbatt.d: No such file or directory
Makefile:243: kernel/chips/smbus-arp.d: No such file or directory
Makefile:243: kernel/chips/vt8231.d: No such file or directory
Makefile:243: kernel/chips/w83627hf.d: No such file or directory
Makefile:243: kernel/chips/adm1021.d: No such file or directory
Makefile:243: kernel/chips/adm1024.d: No such file or directory
Makefile:243: kernel/chips/adm1025.d: No such file or directory
Makefile:243: kernel/chips/adm1026.d: No such file or directory
Makefile:243: kernel/chips/adm9240.d: No such file or directory
Makefile:243: kernel/chips/bt869.d: No such file or directory
Makefile:243: kernel/chips/ddcmon.d: No such file or directory
Makefile:243: kernel/chips/ds1621.d: No such file or directory
Makefile:243: kernel/chips/eeprom.d: No such file or directory
Makefile:243: kernel/chips/fscpos.d: No such file or directory
Makefile:243: kernel/chips/fscscy.d: No such file or directory
Makefile:243: kernel/chips/gl518sm.d: No such file or directory
Makefile:243: kernel/chips/gl520sm.d: No such file or directory
Makefile:243: kernel/chips/it87.d: No such file or directory
Makefile:243: kernel/chips/lm75.d: No such file or directory
Makefile:243: kernel/chips/lm78.d: No such file or directory
Makefile:243: kernel/chips/lm80.d: No such file or directory
Makefile:243: kernel/chips/lm85.d: No such file or directory
Makefile:243: kernel/chips/lm87.d: No such file or directory
Makefile:243: kernel/chips/lm92.d: No such file or directory
Makefile:243: kernel/chips/ltc1710.d: No such file or directory
Makefile:243: kernel/chips/matorb.d: No such file or directory
Makefile:243: kernel/chips/maxilife.d: No such file or directory
Makefile:243: kernel/chips/mtp008.d: No such file or directory
Makefile:243: kernel/chips/pcf8574.d: No such file or directory
Makefile:243: kernel/chips/pcf8591.d: No such file or directory
Makefile:243: kernel/chips/sis5595.d: No such file or directory
Makefile:243: kernel/chips/smsc47m1.d: No such file or directory
Makefile:243: kernel/chips/thmc50.d: No such file or directory
Makefile:243: kernel/chips/w83781d.d: No such file or directory
Makefile:243: kernel/chips/via686a.d: No such file or directory
Makefile:243: kernel/chips/vt1211.d: No such file or directory
Makefile:243: kernel/include/sensors.hd: No such file or directory
Makefile:243: lib/data.ld: No such file or directory
Makefile:243: lib/general.ld: No such file or directory
Makefile:243: lib/error.ld: No such file or directory
Makefile:243: lib/chips.ld: No such file or directory
Makefile:243: lib/proc.ld: No such file or directory
Makefile:243: lib/access.ld: No such file or directory
Makefile:243: lib/init.ld: No such file or directory
Makefile:243: lib/data.ad: No such file or directory
Makefile:243: lib/general.ad: No such file or directory
Makefile:243: lib/error.ad: No such file or directory
Makefile:243: lib/chips.ad: No such file or directory
Makefile:243: lib/proc.ad: No such file or directory
Makefile:243: lib/access.ad: No such file or directory
Makefile:243: lib/init.ad: No such file or directory
Makefile:243: prog/sensors/main.rd: No such file or directory
Makefile:243: prog/sensors/chips.rd: No such file or directory
Makefile:243: prog/dump/isadump.rd: No such file or directory
Makefile:243: prog/dump/i2cdump.rd: No such file or directory
Makefile:243: prog/dump/i2cset.rd: No such file or directory
Makefile:243: prog/detect/i2cdetect.rd: No such file or directory
Makefile:243: prog/detect/dmidecode.rd: No such file or directory
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/detect/dmidecode.c | \
       	sed -e 's@^\(.*\)\.o:@prog/detect/dmidecode.rd prog/detect/dmidecode.ro: Makefile '`dirname prog/detect/dmidecode.rd`/Module.mk' @' > prog/detect/dmidecode.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/detect/i2cdetect.c | \
       	sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd prog/detect/i2cdetect.ro: Makefile '`dirname prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/dump/i2cset.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro: Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' > prog/dump/i2cset.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/dump/i2cdump.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro: Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' > prog/dump/i2cdump.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/dump/isadump.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro: Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' > prog/dump/isadump.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/sensors/chips.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/sensors/main.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro: Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' > prog/sensors/main.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/init.c | \
       	sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile '`dirname lib/init.ad`/Module.mk' @' > lib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/access.c | \
       	sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile '`dirname lib/access.ad`/Module.mk' @' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/error.c | \
       	sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile '`dirname lib/error.ad`/Module.mk' @' > lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/general.c | \
       	sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile '`dirname lib/general.ad`/Module.mk' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/data.c | \
       	sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile '`dirname lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/init.c | \
       	sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile '`dirname lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/access.c | \
       	sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile '`dirname lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/error.c | \
       	sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/general.c | \
       	sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile '`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/data.c | \
       	sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname lib/data.ld`/Module.mk' @' > lib/data.ld
( grep 'SENSORS SYSCTL START' /dev/null kernel/chips/*.c | \
  sed -e 's/:.*//' -e 's#^#kernel/include/sensors.h: #' ) > kernel/include/sensors.hd
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/vt1211.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/vt1211.d kernel/chips/vt1211.o: Makefile '`dirname kernel/chips/vt1211.d`/Module.mk' @' > kernel/chips/vt1211.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/via686a.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/via686a.d kernel/chips/via686a.o: Makefile '`dirname kernel/chips/via686a.d`/Module.mk' @' > kernel/chips/via686a.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/w83781d.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/w83781d.d kernel/chips/w83781d.o: Makefile '`dirname kernel/chips/w83781d.d`/Module.mk' @' > kernel/chips/w83781d.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/thmc50.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/thmc50.d kernel/chips/thmc50.o: Makefile '`dirname kernel/chips/thmc50.d`/Module.mk' @' > kernel/chips/thmc50.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/smsc47m1.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smsc47m1.d kernel/chips/smsc47m1.o: Makefile '`dirname kernel/chips/smsc47m1.d`/Module.mk' @' > kernel/chips/smsc47m1.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/sis5595.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/sis5595.d kernel/chips/sis5595.o: Makefile '`dirname kernel/chips/sis5595.d`/Module.mk' @' > kernel/chips/sis5595.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/pcf8591.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8591.d kernel/chips/pcf8591.o: Makefile '`dirname kernel/chips/pcf8591.d`/Module.mk' @' > kernel/chips/pcf8591.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/pcf8574.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8574.d kernel/chips/pcf8574.o: Makefile '`dirname kernel/chips/pcf8574.d`/Module.mk' @' > kernel/chips/pcf8574.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/mtp008.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/mtp008.d kernel/chips/mtp008.o: Makefile '`dirname kernel/chips/mtp008.d`/Module.mk' @' > kernel/chips/mtp008.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/maxilife.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/maxilife.d kernel/chips/maxilife.o: Makefile '`dirname kernel/chips/maxilife.d`/Module.mk' @' > kernel/chips/maxilife.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/matorb.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/matorb.d kernel/chips/matorb.o: Makefile '`dirname kernel/chips/matorb.d`/Module.mk' @' > kernel/chips/matorb.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/ltc1710.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ltc1710.d kernel/chips/ltc1710.o: Makefile '`dirname kernel/chips/ltc1710.d`/Module.mk' @' > kernel/chips/ltc1710.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/lm92.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm92.d kernel/chips/lm92.o: Makefile '`dirname kernel/chips/lm92.d`/Module.mk' @' > kernel/chips/lm92.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/lm87.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm87.d kernel/chips/lm87.o: Makefile '`dirname kernel/chips/lm87.d`/Module.mk' @' > kernel/chips/lm87.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/lm85.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm85.d kernel/chips/lm85.o: Makefile '`dirname kernel/chips/lm85.d`/Module.mk' @' > kernel/chips/lm85.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/lm80.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm80.d kernel/chips/lm80.o: Makefile '`dirname kernel/chips/lm80.d`/Module.mk' @' > kernel/chips/lm80.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/lm78.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm78.d kernel/chips/lm78.o: Makefile '`dirname kernel/chips/lm78.d`/Module.mk' @' > kernel/chips/lm78.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/lm75.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm75.d kernel/chips/lm75.o: Makefile '`dirname kernel/chips/lm75.d`/Module.mk' @' > kernel/chips/lm75.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/it87.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/it87.d kernel/chips/it87.o: Makefile '`dirname kernel/chips/it87.d`/Module.mk' @' > kernel/chips/it87.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/gl520sm.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/gl520sm.d kernel/chips/gl520sm.o: Makefile '`dirname kernel/chips/gl520sm.d`/Module.mk' @' > kernel/chips/gl520sm.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/gl518sm.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/gl518sm.d kernel/chips/gl518sm.o: Makefile '`dirname kernel/chips/gl518sm.d`/Module.mk' @' > kernel/chips/gl518sm.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/fscscy.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/fscscy.d kernel/chips/fscscy.o: Makefile '`dirname kernel/chips/fscscy.d`/Module.mk' @' > kernel/chips/fscscy.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/fscpos.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/fscpos.d kernel/chips/fscpos.o: Makefile '`dirname kernel/chips/fscpos.d`/Module.mk' @' > kernel/chips/fscpos.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/eeprom.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/eeprom.d kernel/chips/eeprom.o: Makefile '`dirname kernel/chips/eeprom.d`/Module.mk' @' > kernel/chips/eeprom.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/ds1621.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ds1621.d kernel/chips/ds1621.o: Makefile '`dirname kernel/chips/ds1621.d`/Module.mk' @' > kernel/chips/ds1621.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/ddcmon.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ddcmon.d kernel/chips/ddcmon.o: Makefile '`dirname kernel/chips/ddcmon.d`/Module.mk' @' > kernel/chips/ddcmon.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/bt869.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/bt869.d kernel/chips/bt869.o: Makefile '`dirname kernel/chips/bt869.d`/Module.mk' @' > kernel/chips/bt869.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/adm9240.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm9240.d kernel/chips/adm9240.o: Makefile '`dirname kernel/chips/adm9240.d`/Module.mk' @' > kernel/chips/adm9240.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/adm1026.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1026.d kernel/chips/adm1026.o: Makefile '`dirname kernel/chips/adm1026.d`/Module.mk' @' > kernel/chips/adm1026.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/adm1025.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1025.d kernel/chips/adm1025.o: Makefile '`dirname kernel/chips/adm1025.d`/Module.mk' @' > kernel/chips/adm1025.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/adm1024.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1024.d kernel/chips/adm1024.o: Makefile '`dirname kernel/chips/adm1024.d`/Module.mk' @' > kernel/chips/adm1024.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/adm1021.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1021.d kernel/chips/adm1021.o: Makefile '`dirname kernel/chips/adm1021.d`/Module.mk' @' > kernel/chips/adm1021.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/w83627hf.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/w83627hf.d kernel/chips/w83627hf.o: Makefile '`dirname kernel/chips/w83627hf.d`/Module.mk' @' > kernel/chips/w83627hf.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/vt8231.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/vt8231.d kernel/chips/vt8231.o: Makefile '`dirname kernel/chips/vt8231.d`/Module.mk' @' > kernel/chips/vt8231.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/smbus-arp.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smbus-arp.d kernel/chips/smbus-arp.o: Makefile '`dirname kernel/chips/smbus-arp.d`/Module.mk' @' > kernel/chips/smbus-arp.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/smartbatt.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smartbatt.d kernel/chips/smartbatt.o: Makefile '`dirname kernel/chips/smartbatt.d`/Module.mk' @' > kernel/chips/smartbatt.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/chips/ds1307.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ds1307.d kernel/chips/ds1307.o: Makefile '`dirname kernel/chips/ds1307.d`/Module.mk' @' > kernel/chips/ds1307.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-voodoo3.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-voodoo3.d kernel/busses/i2c-voodoo3.o: Makefile '`dirname kernel/busses/i2c-voodoo3.d`/Module.mk' @' > kernel/busses/i2c-voodoo3.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-viapro.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-viapro.d kernel/busses/i2c-viapro.o: Makefile '`dirname kernel/busses/i2c-viapro.d`/Module.mk' @' > kernel/busses/i2c-viapro.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-via.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-via.d kernel/busses/i2c-via.o: Makefile '`dirname kernel/busses/i2c-via.d`/Module.mk' @' > kernel/busses/i2c-via.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-savage4.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-savage4.d kernel/busses/i2c-savage4.o: Makefile '`dirname kernel/busses/i2c-savage4.d`/Module.mk' @' > kernel/busses/i2c-savage4.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/dmi_scan.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/dmi_scan.d kernel/busses/dmi_scan.o: Makefile '`dirname kernel/busses/dmi_scan.d`/Module.mk' @' > kernel/busses/dmi_scan.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-piix4.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-piix4.d kernel/busses/i2c-piix4.o: Makefile '`dirname kernel/busses/i2c-piix4.d`/Module.mk' @' > kernel/busses/i2c-piix4.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-sis645.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis645.d kernel/busses/i2c-sis645.o: Makefile '`dirname kernel/busses/i2c-sis645.d`/Module.mk' @' > kernel/busses/i2c-sis645.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-sis630.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis630.d kernel/busses/i2c-sis630.o: Makefile '`dirname kernel/busses/i2c-sis630.d`/Module.mk' @' > kernel/busses/i2c-sis630.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-sis5595.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis5595.d kernel/busses/i2c-sis5595.o: Makefile '`dirname kernel/busses/i2c-sis5595.d`/Module.mk' @' > kernel/busses/i2c-sis5595.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-isa.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-isa.d kernel/busses/i2c-isa.o: Makefile '`dirname kernel/busses/i2c-isa.d`/Module.mk' @' > kernel/busses/i2c-isa.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-i810.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i810.d kernel/busses/i2c-i810.o: Makefile '`dirname kernel/busses/i2c-i810.d`/Module.mk' @' > kernel/busses/i2c-i810.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-i801.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i801.d kernel/busses/i2c-i801.o: Makefile '`dirname kernel/busses/i2c-i801.d`/Module.mk' @' > kernel/busses/i2c-i801.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-hydra.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-hydra.d kernel/busses/i2c-hydra.o: Makefile '`dirname kernel/busses/i2c-hydra.d`/Module.mk' @' > kernel/busses/i2c-hydra.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-amd8111.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd8111.d kernel/busses/i2c-amd8111.o: Makefile '`dirname kernel/busses/i2c-amd8111.d`/Module.mk' @' > kernel/busses/i2c-amd8111.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-amd756.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd756.d kernel/busses/i2c-amd756.o: Makefile '`dirname kernel/busses/i2c-amd756.d`/Module.mk' @' > kernel/busses/i2c-amd756.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-ali15x3.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali15x3.d kernel/busses/i2c-ali15x3.o: Makefile '`dirname kernel/busses/i2c-ali15x3.d`/Module.mk' @' > kernel/busses/i2c-ali15x3.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-ali1535.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d kernel/busses/i2c-ali1535.o: Makefile '`dirname kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   kernel/busses/i2c-nforce2.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-nforce2.d kernel/busses/i2c-nforce2.o: Makefile '`dirname kernel/busses/i2c-nforce2.d`/Module.mk' @' > kernel/busses/i2c-nforce2.d
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >> kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   prog/sensors/chips.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-nforce2.c:35:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
kernel/busses/i2c-nforce2.c: In function `nforce2_access':
kernel/busses/i2c-nforce2.c:148: warning: `len' might be used uninitialized in this function
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-ali1535.c:57:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-ali15x3.c -o kernel/busses/i2c-ali15x3.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-ali15x3.c:66:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-amd756.c -o kernel/busses/i2c-amd756.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-amd756.c:39:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-amd8111.c:12:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-hydra.c -o kernel/busses/i2c-hydra.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-hydra.c:29:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-i801.c -o kernel/busses/i2c-i801.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-i801.c:44:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-i810.c -o kernel/busses/i2c-i810.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-i810.c:39:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-isa.c -o kernel/busses/i2c-isa.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /usr/local/include/linux/i2c.h:37,
                 from kernel/busses/i2c-isa.c:31:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-sis5595.c -o kernel/busses/i2c-sis5595.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-sis5595.c:59:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-sis630.c -o kernel/busses/i2c-sis630.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-sis630.c:53:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-sis645.c -o kernel/busses/i2c-sis645.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-sis645.c:40:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-piix4.c -o kernel/busses/i2c-piix4.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-piix4.c:34:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/dmi_scan.c -o kernel/busses/dmi_scan.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/busses/dmi_scan.c:13:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-savage4.c -o kernel/busses/i2c-savage4.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-savage4.c:35:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-via.c -o kernel/busses/i2c-via.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-via.c:27:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-viapro.c -o kernel/busses/i2c-viapro.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-viapro.c:36:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-voodoo3.c -o kernel/busses/i2c-voodoo3.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-voodoo3.c:31:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/ds1307.c -o kernel/chips/ds1307.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/ds1307.c:23:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/smartbatt.c -o kernel/chips/smartbatt.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/smartbatt.c:28:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/smbus-arp.c -o kernel/chips/smbus-arp.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/smbus-arp.c:22:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/vt8231.c -o kernel/chips/vt8231.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/vt8231.c:25:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/w83627hf.c -o kernel/chips/w83627hf.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/w83627hf.c:36:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/adm1021.c -o kernel/chips/adm1021.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/adm1021.c:23:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/adm1024.c -o kernel/chips/adm1024.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/adm1024.c:27:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/adm1025.c -o kernel/chips/adm1025.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/adm1025.c:26:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/adm1026.c -o kernel/chips/adm1026.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/adm1026.c:40:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/adm9240.c -o kernel/chips/adm9240.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/adm9240.c:51:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/bt869.c -o kernel/chips/bt869.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/bt869.c:27:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/ddcmon.c -o kernel/chips/ddcmon.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/ddcmon.c:24:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/ds1621.c -o kernel/chips/ds1621.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/ds1621.c:25:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/eeprom.c -o kernel/chips/eeprom.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/eeprom.c:23:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/fscpos.c -o kernel/chips/fscpos.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/fscpos.c:29:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/fscscy.c -o kernel/chips/fscscy.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/fscscy.c:29:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/gl518sm.c -o kernel/chips/gl518sm.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/gl518sm.c:24:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/gl520sm.c -o kernel/chips/gl520sm.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/gl520sm.c:24:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/it87.c -o kernel/chips/it87.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/it87.c:35:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/lm75.c -o kernel/chips/lm75.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/lm75.c:22:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/lm78.c -o kernel/chips/lm78.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/lm78.c:22:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/lm80.c -o kernel/chips/lm80.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/lm80.c:23:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/lm85.c -o kernel/chips/lm85.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/lm85.c:59:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/lm87.c -o kernel/chips/lm87.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/lm87.c:26:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/lm92.c -o kernel/chips/lm92.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/lm92.c:24:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/ltc1710.c -o kernel/chips/ltc1710.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/ltc1710.c:45:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/matorb.c -o kernel/chips/matorb.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/matorb.c:26:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/maxilife.c -o kernel/chips/maxilife.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/maxilife.c:55:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/mtp008.c -o kernel/chips/mtp008.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/mtp008.c:22:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/pcf8574.c -o kernel/chips/pcf8574.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/pcf8574.c:42:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/pcf8591.c -o kernel/chips/pcf8591.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/pcf8591.c:22:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/sis5595.c -o kernel/chips/sis5595.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/sis5595.c:49:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/smsc47m1.c -o kernel/chips/smsc47m1.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/smsc47m1.c:23:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/thmc50.c -o kernel/chips/thmc50.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/thmc50.c:25:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/w83781d.c -o kernel/chips/w83781d.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/w83781d.c:39:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/via686a.c -o kernel/chips/via686a.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/via686a.c:35:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
kernel/chips/via686a.c: At top level:
kernel/chips/via686a.c:514: warning: `via686a_find' defined but not used
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/chips/vt1211.c -o kernel/chips/vt1211.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from kernel/chips/vt1211.c:25:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/data.c -o lib/data.ao
lib/data.c: In function `sensors_parse_chip_name':
lib/data.c:117: warning: deprecated use of label at end of compound statement
lib/data.c:151: warning: deprecated use of label at end of compound statement
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/general.c -o lib/general.ao
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/error.c -o lib/error.ao
lib/error.c: In function `sensors_default_fatal_error':
lib/error.c:61: warning: implicit declaration of function `exit'
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/chips.c -o lib/chips.ao
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/proc.c -o lib/proc.ao
lib/proc.c: In function `sensors_read_proc_chips':
lib/proc.c:83: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/proc.c: In function `sensors_read_proc_bus':
lib/proc.c:125: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/access.c -o lib/access.ao
lib/access.c: In function `sensors_do_this_chip_sets':
lib/access.c:442: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/init.c -o lib/init.ao
bison -p sensors_yy -d lib/conf-parse.y -o lib/conf-parse.c
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/conf-parse.c -o lib/conf-parse.ao
lib/conf-parse.y: In function `sensors_yyparse':
lib/conf-parse.y:151: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-parse.y:207: warning: dereferencing type-punned pointer will break strict-aliasing rules
flex -Psensors_yy -t lib/conf-lex.l > lib/conf-lex.c
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c lib/conf-lex.c -o lib/conf-lex.ao
lib/conf-lex.l: In function `sensors_yylex':
lib/conf-lex.l:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:197: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:199: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:206: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:211: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:217: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:221: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:225: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:229: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:233: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:237: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:241: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:248: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:253: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:258: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:145: warning: label `find_rule' defined but not used
/usr/include/bits/string2.h: At top level:
lib/conf-lex.l:1130: warning: `yy_flex_realloc' defined but not used
rm -f lib/libsensors.a
ar rcvs lib/libsensors.a lib/data.ao lib/general.ao lib/error.ao lib/chips.ao lib/proc.ao lib/access.ao lib/init.ao lib/conf-parse.ao lib/conf-lex.ao
a - lib/data.ao
a - lib/general.ao
a - lib/error.ao
a - lib/chips.ao
a - lib/proc.ao
a - lib/access.ao
a - lib/init.ao
a - lib/conf-parse.ao
a - lib/conf-lex.ao
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/data.c -o lib/data.lo
lib/data.c: In function `sensors_parse_chip_name':
lib/data.c:117: warning: deprecated use of label at end of compound statement
lib/data.c:151: warning: deprecated use of label at end of compound statement
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/general.c -o lib/general.lo
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/error.c -o lib/error.lo
lib/error.c: In function `sensors_default_fatal_error':
lib/error.c:61: warning: implicit declaration of function `exit'
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/chips.c -o lib/chips.lo
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/proc.c -o lib/proc.lo
lib/proc.c: In function `sensors_read_proc_chips':
lib/proc.c:83: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/proc.c: In function `sensors_read_proc_bus':
lib/proc.c:125: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/access.c -o lib/access.lo
lib/access.c: In function `sensors_do_this_chip_sets':
lib/access.c:442: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/init.c -o lib/init.lo
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/conf-parse.c -o lib/conf-parse.lo
lib/conf-parse.y: In function `sensors_yyparse':
lib/conf-parse.y:151: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-parse.y:207: warning: dereferencing type-punned pointer will break strict-aliasing rules
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -fpic -Wall -O2   -c lib/conf-lex.c -o lib/conf-lex.lo
lib/conf-lex.l: In function `sensors_yylex':
lib/conf-lex.l:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:197: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:199: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:206: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:211: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:217: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:221: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:225: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:229: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:233: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:237: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:241: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:248: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:253: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:258: warning: dereferencing type-punned pointer will break strict-aliasing rules
lib/conf-lex.l:145: warning: label `find_rule' defined but not used
/usr/include/bits/string2.h: At top level:
lib/conf-lex.l:1130: warning: `yy_flex_realloc' defined but not used
gcc -shared -Wl,-soname,libsensors.so.2 -o lib/libsensors.so.2.0.0 lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc -lm
rm -f lib/libsensors.so.2
ln -sfn libsensors.so.2.0.0 lib/libsensors.so.2
rm -f lib/libsensors.so 
ln -sfn libsensors.so.2.0.0 lib/libsensors.so
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/sensors/main.c -o prog/sensors/main.ro
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/sensors/chips.c -o prog/sensors/chips.ro
gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro -Llib -lsensors
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/dump/isadump.c -o prog/dump/isadump.ro
gcc  -o prog/dump/isadump prog/dump/isadump.ro
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/dump/i2cdump.c -o prog/dump/i2cdump.ro
gcc  -o prog/dump/i2cdump prog/dump/i2cdump.ro
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/dump/i2cset.c -o prog/dump/i2cset.ro
gcc  -o prog/dump/i2cset prog/dump/i2cset.ro
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/detect/i2cdetect.c -o prog/detect/i2cdetect.ro
gcc  -o prog/detect/i2cdetect prog/detect/i2cdetect.ro
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -Wall -O2   -c prog/detect/dmidecode.c -o prog/detect/dmidecode.ro
gcc  -o prog/detect/dmidecode prog/detect/dmidecode.ro
ishikawa@duron$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.3/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i386-linux
Thread model: posix
gcc version 3.3 (Debian)
ishikawa@duron$ 


---
Strange I2C compilation problem when I set
LANG=ja_JP.ujis
LC_ALL=ja_JP.ujis

/ide-s-master/tools/lm_sensors-CVS/i2c
ishikawa@duron$ LANG=ja_JP.ujis
ishikawa@duron$ LC_ALL=ja_JP.ujis
ishikawa@duron$ export LANG LC_ALL
ishikawa@duron$ make clean
rm -f mkpatch/.temp
rm -f kernel/*.o kernel/*.d kernel/.*.o.flags 
rm -f kernel/*~
rm -f lm_sensors-*
ishikawa@duron$ make
		... omission of messages about kernel/*.d files missing ...
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-pport.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-pport.d kernel/i2c-pport.o: Makefile '`dirname kernel/i2c-pport.d`/Module.mk' @' > kernel/i2c-pport.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-proc.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-proc.d kernel/i2c-proc.o: Makefile '`dirname kernel/i2c-proc.d`/Module.mk' @' > kernel/i2c-proc.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-algo-pcf.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-pcf.d kernel/i2c-algo-pcf.o: Makefile '`dirname kernel/i2c-algo-pcf.d`/Module.mk' @' > kernel/i2c-algo-pcf.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-velleman.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-velleman.d kernel/i2c-velleman.o: Makefile '`dirname kernel/i2c-velleman.d`/Module.mk' @' > kernel/i2c-velleman.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-elv.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-elv.d kernel/i2c-elv.o: Makefile '`dirname kernel/i2c-elv.d`/Module.mk' @' > kernel/i2c-elv.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-algo-biths.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-biths.d kernel/i2c-algo-biths.o: Makefile '`dirname kernel/i2c-algo-biths.d`/Module.mk' @' > kernel/i2c-algo-biths.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-algo-bit.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-bit.d kernel/i2c-algo-bit.o: Makefile '`dirname kernel/i2c-algo-bit.d`/Module.mk' @' > kernel/i2c-algo-bit.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-dev.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-dev.d kernel/i2c-dev.o: Makefile '`dirname kernel/i2c-dev.d`/Module.mk' @' > kernel/i2c-dev.d
gcc -M -MG -I/lib/modules/2.4.21/build/include -nostdinc  -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB kernel/i2c-core.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-core.d kernel/i2c-core.o: Makefile '`dirname kernel/i2c-core.d`/Module.mk' @' > kernel/i2c-core.d

*** So far so good.
Then, here comes an error message in Japanese which says
there is no rule to make `stdarg.h' which is a necessary target for
kernel/i2c-pport.d : I changed the Japanese characters

make: *** `kernel/i2c-pport.d' ..... `stdarg.h' ... make ......

Strange, indeed.
When I modified LANG and LC_ALL, all went well.


LANG=C
LC_ALL=C
export LANG LC_ALL
make clean
make all 
	... clean compilation...

[end of memo]
