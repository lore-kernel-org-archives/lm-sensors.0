From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Linux  2.6.10-rc3 for 8xx with I2C config enabled  fails ...
Message-Id: <20041219191141.51fd17ce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041219150053.GB10771@jupiter.solarsys.private>
In-Reply-To: <20041219150053.GB10771@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> (I hope I will be excused - at least I was not soliciting anything but
> just info and advise, for which in my idealistic judgement there is no
> money equivalent, since those are ... priceless.
> Of course, this is just my private view and other people might have
> different opinion on this subject ).

Not sure what you mean here, but we welcome hardware donations ;)

> In http://www2.lm-sensors.nu/~lm78/cvs/i2c/doc/summary I see:
> ..
> Adapter drivers
> ---------------
> ..
> i2c-rpx:         RPX board Motorola 8xx I2C device (uses i2c-algo-8xx)
> (NOT BUILT BY DEFAULT)
> ..
> 
> Does above comment relates to 2.4 or 2.6 or both ?

The "NOT BUILD BY DEFAULT" relates to 2.4 only (or more precisely to the
version of i2c which is Linux 2.4 compatible). Non-x86 driver receive
very little testing (and are not maintained) because none of us has
non-x86 hardware to test on. In the facts, i2c and lm_sensors are very
x86-centric.

> As it was discovered, 2.6 distribution lacks (as far as ppc 8xx is
> concerned)
>  both: i2c-algo-8xx.h and i2c-algo-8xx.c files, which are present in
>  2.4 .
> 
> Tom Rini suggested to me to bring both files into Linux 2.6 and to
> merge i2c-rpx.c with i2c-algo-8xx.c
> into one file (placing it it under the busses subdirectory ? - AP ) -
> any opinion on that ?

We usually have separate algorithms when one algorithm is shared by
several bus drivers. Since it seems that i2c-rpx is the only user of
this one, I have no objection to merging i2c-algo-8xx and i2c-rpx. In
fact, we don't really care here, the PPC folks can do what they want
with their drivers.

-- 
Jean Delvare
http://khali.linux-fr.org/
