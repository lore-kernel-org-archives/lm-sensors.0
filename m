From: philpi@apu.edu (Phillip Pi)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Installing i2c and lm_sensors in RH Linux 7.2?
Message-Id: <Pine.LNX.4.33.0111200151400.1364-100000@home.apu.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi. I am trying to compile and install i2c-2.6.2 and lm_sensors-2.6.2 on
my new Red Hat Linux v7.2 box. I haven't upgraded and tweaked my Kernel
v2.4.7-10 yet. Do I still need to download the Kernel source from
kernel.org even though I see the source (installed from CD installation)?

If not, then I am having problems compiling after make all. When I do make 
install, I get this:

[root@ANTux-P3 i2c-2.6.2]# make install
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o 
kernel/i2c-philips-par.o kernel/i2c-elv.o kernel/i2c-velleman.o 
kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o 
kernel/i2c-pport.o" ] ; then \
  mkdir -p /lib/modules/`grep UTS_RELEASE 
/usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
  install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o 
kernel/i2c-algo-bit.o kernel/i2c-philips-par.o kernel/i2c-elv.o 
kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o 
kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE 
/usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
fi
install: `/lib/modules/2.4.7-10smp' is a directory
install: `2.4.7-10BOOT' is a directory
install: `2.4.7-10enterprise' is a directory
install: `2.4.7-10debug' is a directory
make: *** [install-kernel] Error 1

Am I doing something wrong? I am still new with Linux so I might be doing
something wrong. I hope I don't have to fiddle with the Kernel. Note: I2C
is not built in my kernel according to its make xconfig. Also, I did edit
Makefile to have it point to /usr/src/linux-2.4.7-10 for source files.

Thank you in advance for a reply. :)
--
"Thanks for giving me the courage to eat all those ants." --unknown
--
  /\___/\                               Phillip Pi (Ant) from apu.edu.
 / /\ /\ \              E-Mail: philpi@earthlink.net or philpi@apu.edu
| |.   .| |
   \ _ /                     The Ant Farm: http://antfarm.home.dhs.org
    ( )       ICQ UIN: 2223658. Resume: http://ptp-resume.home.dhs.org
