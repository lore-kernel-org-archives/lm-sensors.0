From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors/i2c 2.8.2
Message-Id: <20040104141910.64b647a2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

Sorry for the late answer, I was away from home for a few days.

> I just saw that there is 2.8.2 available for some weeks now.  (BTW
> could you put me on the developer's mailing list, so I catch that up
> sooner? :)

Request sent, as you will have noticed.

> I'd like to freshen the kernels, kernel modules and user land tools
> for the Red Hat Linux (and FC) series. I see 2.8.2 i2c patches for
> 2.4.22 and 23, but RH 9/8.0/7.3 are based on 2.4.20 plus some parts of
> 2.4.21. Is it much trouble to backport it to the Red Hat Linux 2.4.20
> sources?

Shouldn't be too much trouble. Drivers tend to be added, not removed, so
all you'll have to do is not apply patches for drivers that did not
exist in 2.4.20 yet (which is what I did myself when building the 2.8.0
patch for kernel 2.4.21, so you can just pick the list here). Also,
I guess that the i2c core patch won't apply cleanly, but you can always
regenerate it using the mkpatch.pl script. So it seems to be feasable.

And in fact I could even update my 2.4.21 patch from 2.8.0 to 2.8.2. I
though nobody would be interested in it, but obviously you, at least,
are. I want to have a new patch for 2.4.24-preX anyway, so I'll some
work on the web page and files soon.

That said, please note that there is not much change between 2.8.1 and
2.8.2 and that lm_sensors 2.8.2 will work with i2c 2.8.1. So if you
already have a kernel with 2.8.1 working, you could consider skipping
i2c 2.8.2 completely.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
