From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors on ThinkPads
Message-Id: <3D94C606.2D75F782@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020927134750.B20006@Stimpy.netroedge.com>
In-Reply-To: <20020927134750.B20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

no, it's not nice, it should have bombed out automatically w/o hitting ^C.
What's the output of prog/detect/dmidecode?

phil@netroedge.com wrote:
> 
> Nice, thanks for testing.
> 
> On Fri, Sep 27, 2002 at 04:28:24PM -0400, Pam Huntley wrote:
> > Hi Phil, Mike,
> >
> > I tested the new lm_sensors package 2.6.5 on the ThinkPad T30.  I used Red Hat Beta (null) with kernel version 2.4.18.  Everything built and installed ok.  When I ran sensors_detect I got the following output:
> >
> > <snip>
> > root@tester lm_sensors-2.6.5]# prog/detect/sensors-detect
> >  This program will help you to determine which I2C/SMBus modules you need to
> >  load to use lm_sensors most effectively.
> >  You need to have done a `make install', issued a `depmod -a' and made sure
> >  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
> >  module path before you can use some functions of this utility. Read
> >  doc/modules for more information.
> >  Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
> >  for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
> >  if you do not have them already.
> >  If you have patched your kernel and have some drivers built-in you can
> >  safely answer NO if asked to load some modules. In this case, things may
> >  seem a bit confusing, but they will still work.
> >
> > dmi: read: Success
> >  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
> >  IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
> >  the bus will break your Thinkpad forever!
> >  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
> >  had users reporting system breakage on other IBM systems as well.
> >
> >  We can start with probing for (PCI) I2C or SMBus adapters.
> >  You do not need any special privileges for this.
> >  Do you want to probe now? (YES/no):
> > </snip>
> >
> >
> > Obviously I hit ctrl-c at that point.
> > Please let me know if this is the appropriate output, or if I should have continued to see if it actually refused to run.
> >
> > Once I know this is the output I'm looking for, I can also test it on the older ThinkPads as well.
> >
> > Thanks!
> > Pam
> >
> > __________________________________________________________________
> > The NEW Netscape 7.0 browser is now available. Upgrade now! http://channels.netscape.com/ns/browsers/download.jsp
> >
> > Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
