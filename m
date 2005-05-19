From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: trying ti install lm_sensors...
Message-Id: <3C308B0F.909E13D5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C2D0379.1040205@gmx.net>
In-Reply-To: <3C2D0379.1040205@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

1st problem see our FAQ #3.9
2nd problem see our FAQ #3.8
3rd problem did you do a 'make install' in i2c?
Where did the headers get installed? You need to put i2c-proc.h
where lm_sensors can find it.
mds

mtkx1 wrote:
> 
> Hi,
> Here is some feedback from my trying to install  lm_sensors.
> 
> I tried to compile i2c-2.6.2 and lm_sensors-2.6.2 on Redhat Linux 7.1
> I already have the lm_sensors-2.5.5-3  package installed with this
> distribution,
> but when I tried to use it I couldn't load the i2c-i801.o: I got
> a message that the symbols i2c_del_adapter_R97e1c952 and
> i2c_add_adapter_Rd50a523b
> could not be resolved. These symbols are defined in  i2c-i801.o in my
> installation.
> 
> So I tried to install the latest version of the two packages, first
> i2c-2.6.2 according to the inctructions.
> 
> The first problem was that in file kernel/Module.mk a lot of lines
> contain the
> following path:  $(LINUX)/.config
> There is no such file in my installation. Instead there is a directory
> /usr/src/linux-2.4.9-12/configs and in it there are several *.config files.
> So I changed the path to be  $(LINUX)/configs/*.config,
> after which grep did not complain any more that "there is no such file"
> 
> After this the "make all" did not complain at all. But when I tried
> "make install"
> a got this:
> 
> if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o
> kernel/i2c-philips-par.o kernel/i2c-elv.o kernel/i2c-velleman.o
> kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o
> kernel/i2c-pport.o" ] ; then \
>   mkdir -p /lib/modules/`grep UTS_RELEASE
> /usr/src/linux-2.4.9-12/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
>   install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o
> kernel/i2c-algo-bit.o kernel/i2c-philips-par.o kernel/i2c-elv.o
> kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o
> kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE
> /usr/src/linux-2.4.9-12/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
> fi
> install: `/lib/modules/2.4.9-12smp' is a directory
> install: `2.4.9-12BOOT' is a directory
> install: `2.4.9-12enterprise' is a directory
> install: `2.4.9-12debug' is a directory
> make: *** [install-kernel] Error 1
> 
> I did not dig into this: I just copied the *.o and *.h file in the
> appropriate
> directories.
> 
> Then I went on to compile  lm_sensors-2.6.2. I again had to fix that
> ${LINUX}/.config
> path in several files.
> Tha compile fails. Here are the last couple of lines:
> 
>            sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d
> kernel/busses/i2c-ali1535.o: Makefile '`dirname
> kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
> make: *** No rule to make target `linux/i2c-proc.h', needed by
> `prog/sensord/chips.rd'.  Stop.
> 
> Best regards,
> Mitko Liotev
