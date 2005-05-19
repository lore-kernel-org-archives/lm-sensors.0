From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm90 driver
Message-Id: <20031026103438.4b043d95.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030906000353.40951246.khali@linux-fr.org>
In-Reply-To: <20030906000353.40951246.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi Jean.  I just got 2.8.1 installed successfully on my mandrake 9.2 
> installation and all appears to be working properly for the lm90
> driver.  The temp readings I am getting on my Athlon XP clocked at
> 2GHz are about what my BIOS reports at boot (60C).  Sensors reports
> 58C at idle and 67-68C at full load.  I was getting a socket reading
> of 40C from the it87 sensor at full load (36C at idle), so I got a
> difference that was within my range of expectation.  Also, the temps
> change quite rapidly when going from full load to idle or vice-versa,
> which I would also expect from reading the diode.
> 
> Also the lm90 reports the board temp at 30C while the it87 reported it
> at 25C.  
> From reading the docs, I believe the lm90 is reading it's own temp,
> so I would expect it to be more accurate than the thermistor reading
> of the it87.

I'm glad it works so well :) Just to make sure I understand it well, the
it87 was on a completely different system, right?

> 2.8.0 shipped with mandrake 9.2, and the lm90 module reported 'to be
> written' with that version, so I was glad to get 2.8.1 working so
> easily (still screwed up my tv card though).

We suspected that the LM90 would be found on a number of motherboards,
so we included detection for it (as well as half a dozen of similar
chips) to sensors-detect. Each time someone reports he/she needs one of
these "to-be-written" drivers, we write the driver (or add support to an
existing driver). This make it easy to support only chips that are
really used (thus keeping drivers small), while still letting people
know that we are able to support some other ones if needed.

> I may go back to the
> packaged version just to be able to use my tv card and hold off on
> using the new sensor until a cooker kernel comes out with 2.8.1 fully
> integrated.  I will spend a little time getting it to work though
> before I resort to that.
> (...)
> Just to follow up, I got it (the tv card) working.  It turns out the
> problem was the permissions on my video device, not anything to do
> with lm_sensors.

OK, good to know. Since your system was working OK with 2.8.0, I was
surprised that you would have problems with 2.8.1. Although 2.8.1 has
the same compatibility issues as 2.8.0 does, once it has been solved for
2.8.0, there's no reason it wouldn't work with subsequent versions.

Thanks a lot for your report, it's really great to have positive
feedback from times to times ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
