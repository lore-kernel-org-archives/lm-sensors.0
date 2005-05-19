From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm_sensors 2.8.1 test
Message-Id: <20031007220754.129ba66c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310071243.44286.lamar@synque.com>
In-Reply-To: <200310071243.44286.lamar@synque.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> lm90-i2c-0-4c
> Adapter: SMBus AMD75x adapter at 06e0
> Algorithm: Non-I2C SMBus adapter
> M/B Temp:    +45?C  (low =   +5?C, high =  +70?C)         
> CPU Temp:  +55.6?C  (low =  +5.0?C, high = +70.0?C)         
> tcrit1:      +85?C
> tcrit2:      +85?C
> hyst:        +10?C

Looks great (except the alignment which is discussable, but that's not
really important).

> So yes, the lm90 (if that's what's on my MPX2)

Yes, it is.

> is being read correctly (and with higher precision).

Obviously, we could live without the extra precision, but that's a funny
feature.

> Apparently only CPU0 is supported, I didn't see anything in the docs
> or configuration filers that would suggest otherwise, so I assume you
> haven't been able to incorporate Alex's suggestion yet. Let me know if
> my assumption is wrong and there is something else for me to test.

No, you're right. I'll need some time to implement what Alex suggested.
It's something relatively new for us, and I don't know how we can handle
this both cleanly and user-friendly.

> I also think the reporting is cleaned up a bit over 2.8.0.
> Before I was getting temperature readings reported for the
> adapter and the chip, in 2.8.1 it is much nicer (unless I
> had something configured wrong before).

I don't really understand what you mean, so yes, you must have had
something strangely configured before.

> What is the meaning/purpose of tcrit over temp_high?

They generate different signals when reached. The exact actions depend
on how your hardware is wired. For example, being over temp_high may
trigger an extra fan or CPU throttling, while being over tcrit would
shut down the system. Read the LM90 data sheet if your interested in the
details:
http://www.national.com/pf/LM/LM90.html

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
