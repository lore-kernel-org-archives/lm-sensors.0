From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: Installing i2c and lm_sensors in RH Linux 7.2? (New problem)
Message-Id: <3C000860.86362AB0@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151400.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151400.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry I'm not making myself clear.
In Makefile, change the line
 
 MODDIR := /lib/modules/`grep UTS_RELEASE
/usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc

to

 MODDIR := /lib/modules/2.4.7-10/misc


All that stuff inside the `.........` just picks out the right name
for the kernel, but it only wants ONE answer and it is getting FIVE
answers, and you say the correct name, from 'uname -r',
is 2.4.7-10.

mds 



Phillip Pi wrote:
> 
> I hope this is what you wanted (I get more than one):
> 
> [ant@ANTux-P3 linux]$ pwd
> /usr/src/linux-2.4.7-10/include/linux
> 
> [ant@ANTux-P3 linux]$ cat version.h |grep UTS_RELEASE
> #define UTS_RELEASE "2.4.7-10smp"
> #define UTS_RELEASE "2.4.7-10BOOT"
> #define UTS_RELEASE "2.4.7-10enterprise"
> #define UTS_RELEASE "2.4.7-10debug"
> #define UTS_RELEASE "2.4.7-10"
> 
> I edited Makefile's MODDIR to say:
> MODDIR := /lib/modules/`grep UTS_RELEASE /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc
> 
> I ran make, and I think it worked (no errors). However, make install
> failed:
> 
> [root@ANTux-P3 i2c-2.6.2]# make install
> if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o
> kernel/i2c-philips-par.o kernel/i2c-elv.o kernel/i2c-velleman.o
> kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o
> kernel/i2c-pport.o" ] ; then \
>   mkdir -p /lib/modules/`grep UTS_RELEASE
> /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
>   install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o
> kernel/i2c-algo-bit.o kernel/i2c-philips-par.o kernel/i2c-elv.o
> kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o
> kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE
> /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> fi
> install: `/lib/modules/2.4.7-10smp' is a directory
> install: `2.4.7-10BOOT' is a directory
> install: `2.4.7-10enterprise' is a directory
> install: `2.4.7-10debug' is a directory
> make: *** [install-kernel] Error 1
> 
> I looked at Makefile and couldn't figure out where the change needed to
> take place. Thank you in advance for a reply. :)
> 
> On Sat, 24 Nov 2001, Mark D. Studebaker wrote:
> 
> > So are you OK or not, I can't tell from you mail.
> > When you 'grep UTS_RELEASE' in version.h do you get more
> > than one entry or not?
> > If you get more than one, you have to pick the right one
> > and then fix the MODDIR := line.
> >
> >
> > Phillip Pi wrote:
> > >
> > > On Sat, 24 Nov 2001, Mark D. Studebaker wrote:
> > >
> > > > 'ls /lib/modules'
> > >
> > > Odd, the directory is valid.  [ant@ANTux-P3 ant]$ ls /lib/modules/
> > > 2.4.7-10  2.4.7-10BOOT  2.4.7-10debug  2.4.7-10enterprise  2.4.7-10smp
> > >
> > > Makefile shows:
> > > MODDIR := /lib/modules/`grep UTS_RELEASE $(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`/misc
> > > ... and that seems correct to me.
> > >
> > > > or
> > > > do a 'make modules_install' from the source of the kernel
> > > > you are compiling against to see where it is going to
> > > > put the modules
> > > > or
> > > > 'uname -r' if you are running that kernel.
> > >
> > > uname -r shows: 2.4.7-10 which is correct.
> > >
> > > > Phillip Pi wrote:
> > > > >
> > > > > I see:
> > > > >
> > > > > 3.8 'make install' fails on Mandrake kernels
> > > > >
> > > > > Mandrake uses a non-standard version.h file which confuses our Makefile.
> > > > > Edit our Makefile on the 'MODDIR :=' line to hard-code the module
> > > > > directory.
> > > > >
> > > > > Now my question, what do I change the line after MODDIR := to? I don't
> > > > > know where my module directory is.
> > > > >
> > > > > On Sat, 24 Nov 2001, Mark D. Studebaker wrote:
> > > > >
> > > > > > You have a problem we usually see in Mandrake kernels.
> > > > > > See FAQ #3.8 for the fix.
> > > > > > mds
> > > > > >
> > > > > > Phillip Pi wrote:
> > > > > > >
> > > > > > > Hey guys,
> > > > > > >
> > > > > > > I got a little farther after running make xconfig and save my settings,
> > > > > > > but I ran into another problem (make had no errors AFAIK):
> > > > > > >
> > > > > > > [root@ANTux-P3 i2c-2.6.2]# make install
> > > > > > > if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o
> > > > > > > kernel/i2c-philips-par.o kernel/i2c-elv.o kernel/i2c-velleman.o
> > > > > > > kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o
> > > > > > > kernel/i2c-pport.o" ] ; then \
> > > > > > >   mkdir -p /lib/modules/`grep UTS_RELEASE
> > > > > > > /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> > > > > > >   install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o
> > > > > > > kernel/i2c-algo-bit.o kernel/i2c-philips-par.o kernel/i2c-elv.o
> > > > > > > kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o
> > > > > > > kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE
> > > > > > > /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> > > > > > > fi
> > > > > > > install: `/lib/modules/2.4.7-10smp' is a directory
> > > > > > > install: `2.4.7-10BOOT' is a directory
> > > > > > > install: `2.4.7-10enterprise' is a directory
> > > > > > > install: `2.4.7-10debug' is a directory
> > > > > > > make: *** [install-kernel] Error 1
> > > > > > >
> > > > > > > Does this mean my Kernel source, from Red Hat Linux 7.2 CDs, is bad?
> > > > > > > Thank you in advance for a reply. :)
> > > > >
> > > > > > > On Tue, 20 Nov 2001 phil@netroedge.com wrote:
> > > > > > >
> > > > > > > > You need to at least configure your kernel.  If it's a redhat kernel,
> > > > > > > > then there is probably a reasonable default config.  'cd
> > > > > > > > /usr/src/linux-2.4.7-10' and do a 'make xconfig' (or menuconfig, or
> > > > > > > > config) and leave the settings as the defaults and save the config.
> > > > > > > > It creates the .config file and also creates some symlinks to include
> > > > > > > > files which are needed for your specific hardware.  If that kernel
> > > > > > > > source isn't the exact which was used to make your running kernel,
> > > > > > > > then you'll have troubles getting the modules to work.  In that case,
> > > > > > > > you won't be able to get around configuring and building the kernel,
> > > > > > > > rebooting, and then building lm-sensors.
> > > > > > > >
> > > > > > > >
> > > > > > > > Phil
> > > > > > > >
> > > > > > > >
> > > > > > > > On Tue, Nov 20, 2001 at 01:59:41AM -0800, Phillip Pi wrote:
> > > > > > > > > Hi. I am trying to compile and install i2c-2.6.2 and lm_sensors-2.6.2 on
> > > > > > > > > my new Red Hat Linux v7.2 box. I haven't upgraded and tweaked my Kernel
> > > > > > > > > v2.4.7-10 yet. Do I still need to download the Kernel source from
> > > > > > > > > kernel.org even though I see the source (installed from CD installation)?
> > > > > > > > >
> > > > > > > > > If not, then I am having problems compiling after make all. When I do make
> > > > > > > > > install, I get this:
> > > > > > > > >
> > > > > > > > > [root@ANTux-P3 i2c-2.6.2]# make install
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > grep: /usr/src/linux-2.4.7-10/.config: No such file or directory
> > > > > > > > > if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o
> > > > > > > > > kernel/i2c-philips-par.o kernel/i2c-elv.o kernel/i2c-velleman.o
> > > > > > > > > kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o
> > > > > > > > > kernel/i2c-pport.o" ] ; then \
> > > > > > > > >   mkdir -p /lib/modules/`grep UTS_RELEASE
> > > > > > > > > /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> > > > > > > > >   install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o
> > > > > > > > > kernel/i2c-algo-bit.o kernel/i2c-philips-par.o kernel/i2c-elv.o
> > > > > > > > > kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o
> > > > > > > > > kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE
> > > > > > > > > /usr/src/linux-2.4.7-10/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> > > > > > > > > fi
> > > > > > > > > install: `/lib/modules/2.4.7-10smp' is a directory
> > > > > > > > > install: `2.4.7-10BOOT' is a directory
> > > > > > > > > install: `2.4.7-10enterprise' is a directory
> > > > > > > > > install: `2.4.7-10debug' is a directory
> > > > > > > > > make: *** [install-kernel] Error 1
> > > > > > > > >
> > > > > > > > > Am I doing something wrong? I am still new with Linux so I might be doing
> > > > > > > > > something wrong. I hope I don't have to fiddle with the Kernel. Note: I2C
> > > > > > > > > is not built in my kernel according to its make xconfig. Also, I did edit
> > > > > > > > > Makefile to have it point to /usr/src/linux-2.4.7-10 for source files.
