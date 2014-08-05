From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Aug 2014 05:51:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (dme1737) Prevent overflow problem when writing large limits
Message-Id: <20140805055156.GA32261@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406945687.12632.1.camel@phoenix>
In-Reply-To: <1406945687.12632.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 04, 2014 at 09:44:21AM -0700, Guenter Roeck wrote:
> On Sat, Aug 02, 2014 at 10:14:47AM +0800, Axel Lin wrote:
> > On platforms with sizeof(int) < sizeof(long), writing a temperature
> > limit larger than MAXINT will result in unpredictable limit values
> > written to the chip. Avoid auto-conversion from long to int to fix
> > the problem.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> >  drivers/hwmon/dme1737.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> > index 4ae3fff..e9cd1e2 100644
> > --- a/drivers/hwmon/dme1737.c
> > +++ b/drivers/hwmon/dme1737.c
> > @@ -293,7 +293,7 @@ static inline int TEMP_FROM_REG(int reg, int res)
> >  	return (reg * 1000) >> (res - 8);
> >  }
> >  
> > -static inline int TEMP_TO_REG(int val)
> > +static inline int TEMP_TO_REG(long val)
> >  {
> >  	return clamp_val((val < 0 ? val - 500 : val + 500) / 1000, -128, 127);
> >  }
> 
> Hi Axel,
> 
> the problem is not just limietd to temperatures. Voltage limits,
> fan minimum speed, pwm frequency, pwm ramp rate, and possibly other
> attributes have the same problem.
> 
Hi Axel,

as followup on this, here is a complete set of test script results for
this driver. Problematic are the suspected overflows as well as the
min > max error when writing vrm (which is because writing a long variable
into an u8 is rarely a good idea). This is without applying your patch;
with it the temperature overflows should be fixed.

Please let me know if you want/can take care of the problems.
Otherwise I'll have a look myself later this week.

Thanks,
Guenter

---
temp1_min: Suspected overflow: [127000 vs. 0]
temp1_max: Suspected overflow: [127000 vs. 0]
temp1_offset: Suspected overflow: [127000 vs. 0]
temp2_min: Suspected overflow: [127000 vs. 0]
temp2_max: Suspected overflow: [127000 vs. 0]
temp2_offset: Suspected overflow: [127000 vs. 0]
temp3_min: Suspected overflow: [127000 vs. 0]
temp3_max: Suspected overflow: [127000 vs. 0]
temp3_offset: Suspected overflow: [127000 vs. 0]
in0_min: Suspected overflow: [6641 vs. 0]
in0_max: Suspected overflow: [6641 vs. 0]
in1_min: Suspected overflow: [2988 vs. 0]
in1_max: Suspected overflow: [2988 vs. 0]
in2_min: Suspected overflow: [4383 vs. 0]
in2_max: Suspected overflow: [4383 vs. 0]
in3_min: Suspected overflow: [6641 vs. 0]
in3_max: Suspected overflow: [6641 vs. 0]
in4_min: Suspected overflow: [15938 vs. 0]
in4_max: Suspected overflow: [15938 vs. 0]
in5_min: Suspected overflow: [4383 vs. 0]
in5_max: Suspected overflow: [4383 vs. 0]
in6_min: Suspected overflow: [4383 vs. 0]
in6_max: Suspected overflow: [4383 vs. 0]
fan1_min: value range [0,100000], deviation 1428
fan1_type: value range [1,2], deviation 0
fan2_min: value range [0,100000], deviation 1428
fan2_type: value range [1,2], deviation 0
fan3_min: value range [0,100000], deviation 1428
fan3_type: value range [1,2], deviation 0
fan4_min: value range [0,100000], deviation 1428
fan4_type: value range [1,2], deviation 0
pwm1_auto_point1_pwm: value range [0,255], deviation 0
pwm1_auto_pwm_min: value range [0,77], deviation 39
pwm1_enable: value range [0,2], deviation 0
pwm1_freq: Suspected overflow: [30000 vs. 11]
pwm1_ramp_rate: Suspected overflow: [206 vs. 5]
pwm2_auto_point1_pwm: value range [0,255], deviation 0
pwm2_auto_pwm_min: value range [0,77], deviation 39
pwm2_enable: value range [0,2], deviation 0
pwm2_freq: Suspected overflow: [30000 vs. 11]
pwm2_ramp_rate: Suspected overflow: [206 vs. 5]
pwm3_auto_point1_pwm: value range [0,255], deviation 0
pwm3_auto_pwm_min: value range [0,77], deviation 39
pwm3_enable: value range [0,2], deviation 0
pwm3_freq: Suspected overflow: [30000 vs. 11]
pwm3_ramp_rate: Suspected overflow: [206 vs. 5]
zone1_auto_point1_temp_hyst: Suspected overflow: [45000 vs. 30000]
zone1_auto_point1_temp: Suspected overflow: [127000 vs. 0]
zone1_auto_point2_temp: Suspected overflow: [80000 vs. 2000]
zone1_auto_point3_temp: Suspected overflow: [127000 vs. 0]
zone2_auto_point1_temp_hyst: Suspected overflow: [45000 vs. 30000]
zone2_auto_point1_temp: Suspected overflow: [127000 vs. 0]
zone2_auto_point2_temp: Suspected overflow: [80000 vs. 2000]
zone2_auto_point3_temp: Suspected overflow: [127000 vs. 0]
zone3_auto_point1_temp_hyst: Suspected overflow: [45000 vs. 30000]
zone3_auto_point1_temp: Suspected overflow: [127000 vs. 0]
zone3_auto_point2_temp: Suspected overflow: [80000 vs. 2000]
zone3_auto_point3_temp: Suspected overflow: [127000 vs. 0]
vrm: max [1] must be larger or equal to min [255]


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
