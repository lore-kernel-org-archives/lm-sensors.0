From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: ServerWorks and Analog Device adm1024
Message-Id: <3C5D84C5.A12764E1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0084727E3D0ED611AA1400104B3FFD5A2ADC8D@cdserv.meridian-data.com>
In-Reply-To: <0084727E3D0ED611AA1400104B3FFD5A2ADC8D@cdserv.meridian-data.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not sure why an interrupt would stop the chip from monitoring.

The adm1024 section in etc/sensors.conf.eg is a little sparse
but there is extensive documentation at the top of the file
which should tell you what you need to know to add to the section.

If you think that the config. register needs to be rewritten
to restart monitoring, that sounds like a driver bug or
something that needs to be improved.

You can start with the ADM1024 datasheet from the Analog Devices
website, together with the i2cdump and i2cset tools in prog/dump.
If you come up with a patch for the driver let us know.

mds


"Lasirona, Robert" wrote:
> 
> Hi Mark,
> 
> I think I found the problem with the adm1024. It looks like an interrupt
> occurred. During the power up init, the fans must be still spinning up and
> the adm1024 is setting an interrupt. I want to change some of the
> configuration settings. How do I read and write to control and configuration
> registers? I only see definitions for getting sensor data.
> 
> To be more specific, I want to be able to change the temperature thresholds.
> The fan RPM thresholds. And, to write to the configuration register to tell
> the adm1024 to re-start monitoring. Can you point me in the right direction?
> 
> Thanks!
> 
> Robert Lasirona
> Linux Software Engineer
> Quantum Inc.
> 2001 Logic Drive
> San Jose, Ca 95124-3452
> (408)879-8772
> 
> -----Original Message-----
> From: Mark D. Studebaker [mailto:mds@paradyne.com]
> Sent: Thursday, January 24, 2002 4:38 PM
> To: Lasirona, Robert
> Cc: 'lm78@stimpy.netroedge.com'
> Subject: Re: ServerWorks and Analog Device adm1024
> 
> sorry, haven't heard of this problem before.
> You can use 'prog/dump/i2cdump 0 0x2c' to bypass the adm1024
> driver and look at the chip registers directly to try and
> see if the chip is indeed returning -127 or if the
> problem appears to be in the driver.
> mds
> 
> "Lasirona, Robert" wrote:
> >
> > Greetings,
> >
> > First of all I wanted to thank you guys for creating this package. I've
> used
> > it for the last year and it's been great. Up until now, I've been able to
> > use it without issues on other hardware.
> >
> > I'm currently using lm_sensors2 v2.6.1 with kernel version 2.4.16. The
> > hardware I'm using is a ServerWorks 30LE OSB4 bus with an Analog Devices
> > adm1024 System Monitor.
> >
> > We're only monitoring the system temperature, so the other values are
> extra.
> > What I'm currently experiencing is the value returned form temp1 is ~34
> for
> > the first couple of hours . Then the temperature returned will change to
> > -127. The only way I've been able to recover the reading is to power down
> > the system. A soft reboot of the system doesn't recover the temperture
> > value.
> >
> > From /proc/sys/dev/sensors/adm1024-i2c-0-2c I get returned: 60.0 50.0
> > -127.0.
> >
> > I'm hoping that is has already been resolved and all I need a patch (It's
> > nice to hope).
> >
> > Thanks!
> >
> > Robert Lasirona
> > Linux Software Engineer
> > Quantum Inc.
> > 2001 Logic Drive
> > San Jose, Ca 95124-3452
> > (408)879-8772
