From: Jeremy Jackson <jerj@coplanar.net>
Date: Sat, 16 Jan 2010 20:53:12 +0000
Subject: Re: [lm-sensors] dme1737 datasheet
Message-Id: <1263675192.32139.26.camel@ragnarok>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176080449.13814.51.camel@ragnarok>
In-Reply-To: <1176080449.13814.51.camel@ragnarok>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2010-01-16 at 12:23 -0800, Juerg Haefliger wrote:
> Hi Jeremy,
> 
> 
> > Heh ok so it's a while ago... but someone wrote a watchdog driver for
> > SCH311x, which I have tried to apply to DME1737, but no luck!
> >
> > Using superiotool to dump the registers, I can see no difference when
> > BIOS has watchdog enabled/disabled.
> >
> > I have compared the LDN 0xa Realtime Registers with watchdog enabled vs
> > disabled, and there is no difference.
> >
> > I tried searching Logical Device Numbers that superiotool doesn't have
> > defined, but they don't seem to exist or be enabled by the BIOS,
> >
> > So either the motherboard has a 2nd watchdog that the BIOS uses
> > (although I can't find any mention of a watchdog on nForce4 Ultra) or
> > there *is* some difference between the SCH311x with public datasheed and
> > the DME1737.  Maybe superiotool isn't printing the full information?  I
> > am thinking of making it dump all 255 registers of all LDNs with
> > watchdog enabled/disabled in BIOS, in case it's hiding in there
> > somewhere.
> >
> > I know it's not strictly related to lm-sensors, but can anyone help?
> 
> What exactly are you looking for?

On your advice (that watchdog function of these chips is the same), I
have modified the SCH311x linux watchdog driver to recognize the device
ID of DME1737... but it doesn't work!

So I'm wondering if you can look at the watchdog function, and see if
they are really the same.

To test, in the BIOS, I enable watchdog, boot linux, load driver, and
watchdog reboots the machine after 110s (BIOS timeout). So, driver fails
to turn off wdt at load.

Turning watchdog off in BIOS, configuring watchdog on linux, timeout
passes, and machine doesn't reboot.  So, driver fails to turn on
watchdog.   

I haven't checked if the watchdog register signals the timeout or not
yet.  That might indicate the chip is partly programmed right.

-- 
Jeremy Jackson
Coplanar Networks
(519)489-4903
http://www.coplanar.net
jerj@coplanar.net


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
