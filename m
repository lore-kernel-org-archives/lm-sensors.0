From: pontus.edvardsson@bredband.net (Pontus Edvardsson)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: Regarding ticket #971
Message-Id: <20020824083637.DLAR312.mf1@there>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020815101953.NRIF312.mf1@there>
In-Reply-To: <20020815101953.NRIF312.mf1@there>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks!!!

It works beatifully now! :))

Thank you very much for all your help and keep up the good work!

Pontus

On Friday 23 August 2002 23.37, Mark D. Studebaker wrote:
> duh. thought I compile-tested it but I guess not!
> Change line 89 from ICH4 to ICH2, or just get new CVS.
> thanks for testing.
> mds
>
> Pontus Edvardsson wrote:
> > Hi!,
> >
> > Thanks for the good news! :) I have tried the CVS as of today and the
> > problem is back to compiling the p4b_smbus.o:
> >
> > panda:/home/poed/cvs/lm_sensors2/prog/hotplug# make -f Makefile.p4b
> > cc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h
> > -D__KERNEL__ -DMODULE -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -I/lib/modules/2.4.19/build/include   -c -o
> > p4b_smbus.o p4b_smbus.c
> > p4b_smbus.c:92: warning: `ICH4' redefined
> > p4b_smbus.c:89: warning: this is the location of the previous definition
> > p4b_smbus.c: In function `init_module':
> > p4b_smbus.c:215: `ICH2' undeclared (first use in this function)
> > p4b_smbus.c:215: (Each undeclared identifier is reported only once
> > p4b_smbus.c:215: for each function it appears in.)
> > make: *** [p4b_smbus.o] Error 1
> > panda:/home/poed/cvs/lm_sensors2/prog/hotplug#
> >
> > I have made sure I compiled without SMP this time... Any ideas?
> >
> > Thanks & have a good weekend!
> >
> > Pontus
> >
> > On Thursday 22 August 2002 03.11, Mark D. Studebaker wrote:
> > > ah thanks, I figured it out. PCI ID's were wrong.
> > > Fixed in CVS.
> > > The 82820 chipset contains the 82801BA (ICH2). We support it.
> > > Please try CVS and let me know how it works.
> > > mds
> > >
> > > Pontus Edvardsson wrote:
> > > > Hi again,
> > > >
> > > > I still have problems after checking dmesg & syslog (which I had done
> > > > before also). Apart from this problem I relly think lm_sensors would
> > > > benefit from a 'make uninstall' target to clean up and uninstall. But
> > > > thats a parenthesis... :)
> > > >
> > > > With your help #955 I successfully compiled p4b_smbus.o, but can't
> > > > load it;
> > > >
> > > > panda:/usr/src/misc-drivers/lm_sensors-2.6.4/prog/hotplug# insmod
> > > > p4b_smbus.o p4b_smbus.o: init_module: Operation not permitted
> > > > Hint: insmod errors can be caused by incorrect module parameters,
> > > > including invalid IO or IRQ parameters
> > > > panda:/usr/src/misc-drivers/lm_sensors-2.6.4/prog/hotplug#
> > > >
> > > > and in syslog I get:
> > > >
> > > > Aug 15 11:54:07 panda kernel: i801smbus: SMBus already active
> > > >
> > > > BUT, a lspci does not show the SMBus controller (should have been at
> > > > 00:1f.3 if I'm correct?)
> > > >
> > > > panda:~# lspci
> > > > 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
> > > > Bridge (rev 04) 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale)
> > > > Chipset AGP Bridge (rev 04) 00:1e.0 PCI bridge: Intel Corp. 82820 820
> > > > (Camino 2) Chipset PCI (rev 05) 00:1f.0 ISA bridge: Intel Corp. 82820
> > > > 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 05) 00:1f.1 IDE
> > > > interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 05)
> > > > 00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB
> > > > (Hub A) (rev 05) 00:1f.4 USB Controller: Intel Corp. 82820 820
> > > > (Camino 2) Chipset USB (Hub B) (rev 05) 00:1f.5 Multimedia audio
> > > > controller: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio
> > > > Controller (rev 05) 01:00.0 VGA compatible controller: Matrox
> > > > Graphics, Inc. MGA G550 AGP (rev 01) 02:0a.0 Ethernet controller:
> > > > Realtek Semiconductor Co., Ltd. RTL-8029(AS) 02:0b.0 Unknown mass
> > > > storage controller: Promise Technology, Inc.: Unknown device 4d69
> > > > (rev 02) panda:~#
> > > >
> > > > My current kernel is compiled without any i2c support and I soley
> > > > intended to use modules for this.
> > > >
> > > > ARGh... I guess I found something. I was about to describe what
> > > > happened if loading modules i2c-core, proc and so on and referr to
> > > > ticket #601. He was talking about 82820 815e, I have 82820 820... :(
> > > > I checked your page of supported busses and it wasn't there... Is
> > > > there any chance you will support this?
> > > >
> > > > Thanks for all your help so far!
> > > >
> > > > Pontus
