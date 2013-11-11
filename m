From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Nov 2013 19:50:51 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <20131111195051.GA29204@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 11, 2013 at 11:46:21AM -0800, p. stephen w wrote:
> it seems after reboot, I've lost the sensors.  To get them back I have to
> run modprobe again.
> 
The driver doesn't auto-load. Just add nct6775 to /etc/modules.

Guenter

> 
> On Mon, Nov 11, 2013 at 11:17 AM, p. stephen w <p.stephenwille@gmail.com>wrote:
> 
> > Thanks, but I'd still like to contribute.  I know this stuff takes time
> > and energy.
> >
> >
> > On Mon, Nov 11, 2013 at 11:11 AM, Guenter Roeck <linux@roeck-us.net>wrote:
> >
> >> On Mon, Nov 11, 2013 at 10:31:40AM -0800, p. stephen w wrote:
> >> > woot-woot, that was it.  Running Make install did the trick.  Like I
> >> said,
> >> > I'm a Linux noob.
> >> >
> >> > Where can I send you $50?
> >> >
> >> That was free of charge ...
> >>
> >> Guenter
> >>
> >> >
> >> > On Mon, Nov 11, 2013 at 10:29 AM, Guenter Roeck <linux@roeck-us.net>
> >> wrote:
> >> >
> >> > > On Mon, Nov 11, 2013 at 10:17:00AM -0800, p. stephen w wrote:
> >> > > >  I just followed the link from the lm-sensors devices page to the
> >> GitHub
> >> > > > page (is that yours?), and re-cloned it.  This time the output was a
> >> > > little
> >> > > > different, and I have a few .ko files in my personal directory.
> >>  They are
> >> > > > not in the hwmon dir.  I thought I might try moving them there and
> >> > > > re-running sensors-detect.
> >> > > >
> >> > > > Githum repo:
> >> > > > https://github.com/groeck/nct6775.git
> >> > > >
> >> > > > Make:
> >> > > > Mint nct6775 # make all
> >> > > >   CC [M]  /home/stephen/nct6775/nct6775.o
> >> > > >
> >> > > >   Building modules, stage 2.
> >> > > >   MODPOST 1 modules
> >> > > >   CC      /home/stephen/nct6775/nct6775.mod.o
> >> > > >   LD [M]  /home/stephen/nct6775/nct6775.ko
> >> > > >
> >> > > >
> >> > > I asked earlier if you did run "make install". Looks like you didn't.
> >> > >
> >> > >
> >> > > > Contents of home dir after make all:
> >> > > > Mint nct6775 # ls
> >> > > > compat.h  Makefile        nct6775.c      nct6775.mod.o
> >>  README.ASRock
> >> > > > LICENSE   modules.order   nct6775.ko     nct6775.o
> >> > > > lm75.h    Module.symvers  nct6775.mod.c  README
> >> > > >
> >> > > >
> >> > > > Sensors -v
> >> > > > Mint nct6775 # sensors -v
> >> > > > sensors version 3.3.4 with libsensors version 3.3.4
> >> > > >
> >> > > >
> >> > > >
> >> > > > I run everything as root.
> >> > > > Should I copy any of the .ko, .o, and .c files from your driver
> >> into any
> >> > > > other folders?
> >> > > >
> >> > > Run "make install" followed by "modprobe nct6775".
> >> > >
> >> > > > I'm using the sensors-detect that came with the manual installation
> >> of
> >> > > > lm-sensors, latest version.  I don't have a prog/detect, either
> >> folder or
> >> > > > command.
> >> > >
> >> > > The prog/detect directory is in the lm-sensors source, so if you
> >> > > cloned lm-sensors from github or svn you should have it.
> >> > >
> >> > > Thanks,
> >> > > Guenter
> >> > >
> >> > > >   Just run sensors_detect from prog/detect/. I am not sure if you
> >> > > actually
> >> > > > installed it. If not, you just keep running the installed version.
> >> > > >
> >> > > > --
> >> > > >
> >> > > >
> >> > > > _____________________________
> >> > > > Stephen Wille | pstephenwille.com
> >> > > > *new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
> >> > > > _______________________________________________
> >> > > > lm-sensors mailing list
> >> > > > lm-sensors@lm-sensors.org
> >> > > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >> > > >
> >> > >
> >> >
> >> >
> >> >
> >> > --
> >> >
> >> >
> >> > _____________________________
> >> > Stephen Wille | pstephenwille.com
> >> > *new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
> >>
> >
> >
> >
> > --
> >
> >
> > _____________________________
> > Stephen Wille | pstephenwille.com
> > *new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
> >
> 
> 
> 
> -- 
> 
> 
> _____________________________
> Stephen Wille | pstephenwille.com
> *new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
