From: Parag Warudkar <parag.lkml@gmail.com>
Date: Sat, 15 Sep 2012 23:35:18 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <alpine.DEB.2.02.1209151918210.2271@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1209151834120.2271@ubuntu> <20120915225841.GA3816@roeck-us.net>
In-Reply-To: <20120915225841.GA3816@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Parag Warudkar <parag.lkml@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, rydberg@euromail.se, khali@linux-fr.org



On Sat, 15 Sep 2012, Guenter Roeck wrote:

> On Sat, Sep 15, 2012 at 06:42:30PM -0400, Parag Warudkar wrote:
> > I have been getting a steady stream of wait_read timeouts on my 2010 MBP.
> > 
> > After playing around with various values of APPLESMC_MAX_WAIT a value of 
> > 0x10000 reduces the wait_read failures to zero under most normal workloads 
> > - with and without AC power plugged in, at idle and and at make -j4 loads.
> > 
> > While there I noticed we don't really need to udelay before first inb() - 
> > so I moved it down to after first and subsequent failures.
> > 
> > Been running this for couple days without any issues.
> > 
> > Signed-off-by: Parag Warudkar <parag.lkml@gmail.com>
> > 
> > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > index 2827088..46cb458 100644
> > --- a/drivers/hwmon/applesmc.c
> > +++ b/drivers/hwmon/applesmc.c
> > @@ -56,7 +56,7 @@
> >  /* wait up to 32 ms for a status change. */
> >  #define APPLESMC_MIN_WAIT	0x0010
> >  #define APPLESMC_RETRY_WAIT	0x0100
> > -#define APPLESMC_MAX_WAIT	0x8000
> > +#define APPLESMC_MAX_WAIT	0x10000
> >  
> >  #define APPLESMC_READ_CMD	0x10
> >  #define APPLESMC_WRITE_CMD	0x11
> > @@ -170,11 +170,11 @@ static int wait_read(void)
> >  	u8 status;
> >  	int us;
> >  	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> 
> I wonder if it would make sense to keep APPLESMC_MAX_WAIT as it is now
> and replace the loop termination conditions with
> 				us <= APPLESMC_MAX_WAIT
> 
> That would accomplish the same, and APPLESMC_MAX_WAIT would reflect
> the real maximum wait time.

Yeah, that would fix the code to match what it says and eliminate most 
failures. But in my testing sometimes it needed a max wait of 57344 us - 
I wrote a separate patch to instrument it by bumping up max wait in 
increments of 0x2000 until it no longer failed under my normal workloads. 

Under normal use 32us seemed to work but rarely when machine was 
slow - throttled, on  battery, on kernel build load etc.- the additional 
wait helped.

So I think it makes sense to fix the loop termination condition and also 
bump to max wait to 0x10000.

> 
> Also, since the delay time can get quite large, would it make sense to replace
> udelay with usleep_range() ?
> 

Yes, I think that would be a good thing to do. We could sleep in range of 
us<<=1 and us<<1 and if usleep_range() returns actual sleep time we can 
factor that in for next loop iteration if necessary. Gotta think a bit on 
that one.

I will rework the patch to fix the loop termination and keep the bump to 
0x10000 in place and possibly also experiment with usleep_range().

Thanks,
Parag

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
