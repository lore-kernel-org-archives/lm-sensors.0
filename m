From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Patches for 2.6.0 (lm83 and misc)
Message-Id: <20031010222649.75cd8a2e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031004160750.70561b1d.khali@linux-fr.org>
In-Reply-To: <20031004160750.70561b1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I'll wait until the lm83 driver is accepted. That way, if changes
> > are needed for that driver, I won't have to fix these things for the
> > new drivers.
> 
> Why wait?  The lm83 driver is sitting in my bitkeeper tree, and I can
> gladly add others.  I'm doing the same thing for two new USB drivers
> already :)

Apart from the above-mentioned reason (I am a step-by-step guy), I have
so many things to do that I can reasonably delay the two additional
drivers. In particular, I have to prepare a i2c-2.8.1 patch for
submission to the LKML and integration into Linux 2.4.23. I think you
remember about that. At least, I hope so, since I definitely count on
your help in the process :)

> And who knows how long it will be before 2.6.0 comes out...

I know that, but that's not really the point.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
