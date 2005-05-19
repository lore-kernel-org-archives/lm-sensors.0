From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Mondo: problem with as99127f-i2c-2d
Message-Id: <3D814878.9C84DA4C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
In-Reply-To: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fan counters (which get higher the slower the fan is) generally saturate
at 255 so I doubt your patch is correct, you'll never see a stopped fan.
You may need to increase your fan divisors (I think they work
on as99127f, can't remember) - see doc/fan-divisors in our package for
details.
Stop your fan and test the patch to see for yourself.

Not familiar with mondo but if it shuts down the whole system based on
one reading that may be a little drastic, espcecially if you
are relying on an undocumented chip :)

You can try periodically running i2cdump in our package as another
diagnostic. This bypasses the w83781d driver and you can see if
you are getting bad readings from the chip or from the driver.

mds



Kelledin wrote:
> 
> On Tuesday 10 September 2002 04:24 pm, you wrote:
> > In any case, this indicates that the problem I'm seeing is not
> > in mondo, but is a bug either in i2c/lm_sensors or
> > conceivably, at the bios or hardware level in the A7V266E
> > motherboard. However I don't think it's hardware - motherboard
> > monitor runs on these machines when they are booted to XP and
> > I've not seen any oddball shutdowns under that OS.  In one
> > instance there was an xlock authentication failure 4 seconds
> > before fan1 read 0.0.  Other than that, there was nothing
> > obvious to indicate a problem /var/log/messages.  Note though
> > that xlock was running continuously most of this time (due to
> > the idle console), and cycling through whichever programs it
> > runs by default.  This is xlockmore -4.17.2.
> >
> > This presents somewhat of a problem since it means running
> > mondo in a protective mode will trigger unwanted shutdowns
> > at 1-2 hour intervals (more or less).  Unfortunately for this
> > class of software 99.99% correct doesn't quite do it.
> >
> > Any suggestions?  This is with RH 7.3 and the current
> > distribution of I2c/lm_sensors.  The device is
> > as99127f-i2c-0-2d.
> 
> Hmmm...yup, as99127f support is listed as BETA in the docs.  We
> have Asus to thank for that. =/  Perhaps Alex van Kaam
> (Motherboard Monitor developer) could help us here; IIRC he's
> contributed to lm_sensors in the past.
> 
> In the meantime...
> 
> After casting my marginally-experienced-kernel-hacker's eye over
> the lm_sensors sources, I think I might have spotted a fix for
> the fan issue.
> 
> The standard caveats apply; this patch may save your bacon, or it
> may take you from the frying pan into the fire.  I will not be
> responsible for any damage this does to your computer, your
> health, your sanity, or any of your friends, family, neighbors,
> or other possessions. ;)
> 
> All that being said, just cd to your lm_sensors source directory
> and type "patch -p1 < /path/to/lm_sensors-2.6.4-asus.patch".
> Then recompile and reinstall lm_sensors.
> 
> I haven't tried to fix the temp issue--yet.  It looks a little
> more difficult, and that job's probably better suited to a
> developer with appropriate hardware to test on.
> 
> --
> Kelledin
> "If a server crashes in a server farm and no one pings it, does
> it still cost four figures to fix?"
> 
> 
>                                   Name: lm_sensors-2.6.4-asus.patch
>    lm_sensors-2.6.4-asus.patch    Type: text/x-diff
>                               Encoding: 7bit
