From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 18 Nov 2007 19:36:29 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON: Replace power-of-two test
Message-Id: <20071118193629.GC12086@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-11-06 23:08:09 +0100]:
> On Tue, 6 Nov 2007 03:21:42 -0500 (EST), Robert P. J. Day wrote:
> > 
> > Since <linux/log2.h> already supplies a power-of-two test, there's no
> > point in having this source file redefine it again.
> > 
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > 
> > ---
> > 
> > diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> > index 9810aaa..a215560 100644
> > --- a/drivers/hwmon/adt7470.c
> > +++ b/drivers/hwmon/adt7470.c
> > @@ -114,8 +114,6 @@ I2C_CLIENT_INSMOD_1(adt7470);
> >  /* sleep 1s while gathering temperature data */
> >  #define TEMP_COLLECTION_TIME	1000
> > 
> > -#define power_of_2(x)	(((x) & ((x) - 1)) = 0)
> > -
> >  /* datasheet says to divide this number by the fan reading to get fan rpm */
> >  #define FAN_PERIOD_TO_RPM(x)	((90000 * 60) / (x))
> >  #define FAN_RPM_TO_PERIOD	FAN_PERIOD_TO_RPM
> > @@ -677,7 +675,7 @@ static int cvt_auto_temp(int input)
> >  {
> >  	if (input = ADT7470_PWM_ALL_TEMPS)
> >  		return 0;
> > -	if (input < 1 || !power_of_2(input))
> > +	if (input < 1 || !is_power_of_2(input))
> >  		return -EINVAL;
> >  	return ilog2(input) + 1;
> >  }

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
