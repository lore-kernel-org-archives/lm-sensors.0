From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <20030813211613.21ce6532.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I don't understand. In this example, 38 < 47 and 38 < 60 so no alarm
> > should trigger at all - yet the high alarm seems to be set. Looks
> > like a bug in my driver :(
>
> No the temperature has been over the high limit since the last
> reading. I temporarily changed the limit to 40 and then back to 47.
> Since the temperature is not constant an alarm has been generated.

OK, this makes sense then. The alarm bits are not cleared until the
status register is read, so that you'll never miss an alarm, even if you
were not reading the temperatures at the time the alarm triggered. So
you will still see the alarm flag once (and for the two following
seconds, due to internal caching) after the alarm condition has
disappeared. This is a feature, not a bug.

Same applies to T_CRIT of course.

> > > I had a look at the wiring diagram and all D+ ports are wired
> > > together. But as said before the temperatures differ with as much
> > > as 7 degrees within a single reading I find that hard to believe.
> >
> > Sure, I just can't believe it. BTW, where did you got that diagram? 
>
> It comes from the manufacturer. I assume that we have made a special
> request that they should supply us with a wiring diagram.

Well, maybe the request should have mentioned the fact that you wanted a
*real* diagram, matching the hardware ;) Obviouslsy it isn't the case
here, at least as far as hardware monitoring is concerned.

Magnus, thanks a lot for testing my driver. I appreciate that really
much :)

Since it looks like the driver works OK, I'll update the configuration
file and the docs, as well as the new drivers page. I think we can say
the driver was tested and is known to work.

If you ever notice a problem with the driver, of just want to report
about anything, let us know.

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
