From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Jul 2009 06:41:47 +0000
Subject: Re: [lm-sensors] [PATCH] dme1737: Keep index within pwm_config[]
Message-Id: <20090725084147.7e4b3411@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A689F42.4070701@gmail.com>
In-Reply-To: <4A689F42.4070701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 24 Jul 2009 16:53:49 -0700, Andrew Morton wrote:
> On Fri, 24 Jul 2009 09:12:12 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > On Thu, 23 Jul 2009 19:34:58 +0200, Roel Kluin wrote:
> > > pwm_config is only 3 bytes - pwm_config[3] is out of range.
> > > 
> > > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > > ---
> > > Credits to Parfait and Nathan Keynes,
> > > 
> > > diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> > > index 3df202a..57e8ed4 100644
> > > --- a/drivers/hwmon/dme1737.c
> > > +++ b/drivers/hwmon/dme1737.c
> > > @@ -1134,7 +1134,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
> > >  		res = PWM_FREQ_FROM_REG(data->pwm_freq[ix]);
> > >  		break;
> > >  	case SYS_PWM_ENABLE:
> > > -		if (ix > 3) {
> > > +		if (ix >= 3) {
> > >  			res = 1; /* pwm[5-6] hard-wired to manual mode */
> > >  		} else {
> > >  			res = PWM_EN_FROM_REG(data->pwm_config[ix]);
> > 
> > This code path is never called with ix = 3 (the device has no PWM4
> > output) so it doesn't make any difference in practice.
> > 
> 
> This possible bug was, I believe, detected by a static code scanner
> called "Parfait".
> 
> Hopefully people will continue to run Parfait against the kernel for
> years to come.  It would be unfortunate if code sites such as this were
> to pop up in their reports again and again, so there is value in making
> the parfait warning go away, even if it is a cant-happen thing.

Feel free to push the patch upstream yourself then. But please make
sure the description is clear enough that it doesn't fix any actual bug.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
