From: philpi@apu.edu (Phillip Pi)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Installing i2c and lm_sensors in RH Linux 7.2? (New problem)
Message-Id: <Pine.LNX.4.33.0111210233120.1364-100000@home.apu.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151400.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151400.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey guys,

I got a little farther after running make xconfig and save my settings,
but I ran into another problem (make had no errors AFAIK):

[root@ANTux-P3 i2c-2.6.2]# make install
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

Does this mean my Kernel source, from Red Hat Linux 7.2 CDs, is bad?
Thank you in advance for a reply. :)
--
"Thanks for giving me the courage to eat all those ants." --unknown
--
  /\___/\                               Phillip Pi (Ant) from apu.edu.
 / /\ /\ \              E-Mail: philpi@earthlink.net or philpi@apu.edu
| |.   .| |
   \ _ /                     The Ant Farm: http://antfarm.home.dhs.org
    ( )       ICQ UIN: 2223658. Resume: http://ptp-resume.home.dhs.org

On Tue, 20 Nov 2001 phil@netroedge.com wrote:

> You need to at least configure your kernel.  If it's a redhat kernel,
> then there is probably a reasonable default config.  'cd
> /usr/src/linux-2.4.7-10' and do a 'make xconfig' (or menuconfig, or
> config) and leave the settings as the defaults and save the config.
> It creates the .config file and also creates some symlinks to include
> files which are needed for your specific hardware.  If that kernel
> source isn't the exact which was used to make your running kernel,
> then you'll have troubles getting the modules to work.  In that case,
> you won't be able to get around configuring and building the kernel,
> rebooting, and then building lm-sensors.
> 
> 
> Phil
> 
> 
> On Tue, Nov 20, 2001 at 01:59:41AM -0800, Phillip Pi wrote:
> > Hi. I am trying to compile and install i2c-2.6.2 and lm_sensors-2.6.2 on
> > my new Red Hat Linux v7.2 box. I haven't upgraded and tweaked my Kernel
> > v2.4.7-10 yet. Do I still need to download the Kernel source from
> > kernel.org even though I see the source (installed from CD installation)?
> > 
> > If not, then I am having problems compiling after make all. When I do make 
> > install, I get this:
> > 
> > [root@ANTux-P3 i2c-2.6.2]# make install
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o 
> > kernel/i2c-philips-par.o kernel/i2c-elv.o kernel/i2c-velleman.o 
> > kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o 
> > kernel/i2c-pport.o" ] ; then \
> >   mkdir -p /lib/modules/`grep UTS_RELEASE 
> > /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> >   install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o 
> > kernel/i2c-algo-bit.o kernel/i2c-philips-par.o kernel/i2c-elv.o 
> > kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o 
> > kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE 
> > /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> > fi
> > install: `/lib/modules/2.4.7-10smp' is a directory
> > install: `2.4.7-10BOOT' is a directory
> > install: `2.4.7-10enterprise' is a directory
> > install: `2.4.7-10debug' is a directory
> > make: *** [install-kernel] Error 1
> > 
> > Am I doing something wrong? I am still new with Linux so I might be doing
> > something wrong. I hope I don't have to fiddle with the Kernel. Note: I2C
> > is not built in my kernel according to its make xconfig. Also, I did edit
> > Makefile to have it point to /usr/src/linux-2.4.7-10 for source files.
