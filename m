From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Mondo: problem with as99127f-i2c-2d
Message-Id: <E17osUd-00035I-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
In-Reply-To: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I've discovered another bug, this one really problematic.  I
> > set up my mondo.conf file and then after a while the system
> > shut down claiming the CPU had overheated.  But I was sitting
> > right there and got straight into the BIOS hardware monitor
> > and it showed the temp was ok. So I changed the mondo.conf to
> > just emit warnings instead of shutting down.  After an hour or
> > so it claimed the fan was running too slow, but again, I was
> > sitting right there, and within seconds had run sensors, which
> > showed the fan speed to be ok.
> >
> >
> > Then I looked at /var/log/messages, and it said that the temp
> > when it had overheaded had been 255.40 and the fan speed
> > had been 0.0.   That's obviously nonsense.  I think maybe
> > what's happening here is that mondo is reading the proc files
> > just as they're being updated, and so reads an invalid value.
> > Is there any file locking employed?  Have you seen this
> > before?
> 
> Yikes!  Now that's something I've never seen before...
> 

I followed Kelledin's advice and ran mondo with logging turned 
on for a long time.  After about 1.5 hours it logged 3 cases
of fan1 at 0.0, these were single instances roughly 4-6 minutes
apart.  I also had mondo do:

  sensors | logger

on fan warnings and these showed that sensors also read 
the fan as 0.0 at that point in time.   I have not yet seen the 
CPU temp glitch again.

In any case, this indicates that the problem I'm seeing is not
in mondo, but is a bug either in i2c/lm_sensors or conceivably,
at the bios or hardware level in the A7V266E motherboard.
However I don't think it's hardware - motherboard monitor
runs on these machines when they are booted to XP and I've
not seen any oddball shutdowns under that OS.  In one instance
there was an xlock authentication failure 4 seconds before
fan1 read 0.0.  Other than that, there was nothing obvious to indicate
a problem /var/log/messages.  Note though that xlock was running
continuously most of this time (due to the idle console), and
cycling through whichever programs it runs by default.  This is
xlockmore -4.17.2.

This presents somewhat of a problem since it means running mondo
in a protective mode will trigger unwanted shutdowns
at 1-2 hour intervals (more or less).  Unfortunately for this class
of software 99.99% correct doesn't quite do it.

Any suggestions?  This is with RH 7.3 and the current distribution
of I2c/lm_sensors.  The device is as99127f-i2c-0-2d. 

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
