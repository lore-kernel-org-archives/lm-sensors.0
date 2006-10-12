From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 12 Oct 2006 09:37:49 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min,
Message-Id: <20061012113749.e507a9a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4529A56C.1030507@gmail.com>
In-Reply-To: <4529A56C.1030507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > > +static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> >
> > Line too long, please fold. Same for all other callbacks you introduced.
>
> Ok.  I was under impression that fn-sigs were the sole exception
> to the line-wrap rule, in that having the full sig on a single line is
> good for grepping.

No, there is no such exception. Line wrap indeed makes grep'ing more
difficult in some cases, but Linus seems to care about the line length
more than the grep'ability.

> I'll guess that folding existing functions should be a separate patch ?
> (combined with any other cosmetic changes, later)

Yes, please.

> > This callback is exactly the same as show_in_min_alarm above, so why
> > don't you just reuse it? Same for show_therm_max_alarm below and
> > show_in_max_alarm.
> >
> > Which made me check the current code, and it appears that
> > show_therm_input, show_therm_min and show_therm_max are redundant with
> > show_in_input, show_in_min and show_in_max, respectively, so the code
> > could be simplified. And this is again true of "set" callbacks, unless
> > I am overlooking something? The benefit is even bigger here as these
> > callbacks are larger. Care to submit a patch?
>
> I was planning to fold them together in a 2D patch, like so:
> 
> static ssize_t show_temp(struct device *dev, struct device_attribute 
> *devattr, char *buf)
> {
>     struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>     struct pc87360_data *data = pc87360_update_device(dev);
>     int idx = attr->index;
>     unsigned res = -1;
> 
>     switch (attr->nr) {
>     case FN_TEMP_INPUT:
>         res = TEMP_FROM_REG(data->temp[idx]);
>         break;
>     case FN_TEMP_STATUS:
>         res = data->temp_status[idx];
>         break;
>     case FN_TEMP_MIN:
>         res = TEMP_FROM_REG(data->temp_min[idx]);
>         break;
>     case FN_TEMP_MAX:
>         res = TEMP_FROM_REG(data->temp_max[idx]);
>         break;
>     case FN_TEMP_CRIT:
>         res = TEMP_FROM_REG(data->temp_crit[idx]);
>         break;
>     case FN_TEMP_MIN_ALARM:
>         res = (data->temp_status[idx] & 2) >> 1;
>         break;
>     case FN_TEMP_MAX_ALARM:
>         res = (data->temp_status[idx] & 4) >> 2;
>         break;
>     case FN_TEMP_CRIT_ALARM:
>         res = (data->temp_status[idx] & 8) >> 3;
>         break;
>     default:
>         dev_err(dev, "unknown attr fetch\n");
>      }
>      return sprintf(buf, "%u\n", res);

How do you handle negative temperature values with a %u?

> }
> 
> This gets significant shrinkage..
>   15902    5160      32   21094    5266 
> 19rc1mm1-1/drivers/hwmon/pc87360.ko  --- this patch

What is "this patch" exactly?

>   14011    5160      32   19203    4b03 
> 19rc1mm1-2/drivers/hwmon/pc87360.ko  --- 2D patch
> 
> This folding doesnt rely on thermistor measurements being done with voltage
> hardware, which is an ideosyncrasy of this particular part, and doesnt 
> work for the temp_ sensors (only the therm ones), so I think its clearer
> and more general this way.

Actually, thermistor measurements are always being done with voltage
hardware, by design. What may be surprising is that the chip doesn't
attempt to abstract this to make temperatures look more like
temperatures.

As said before, I'm not a fan of this switch/case approach, as it looks
suboptimal from a performance point of view (unless you can prove me
wrong with actual data). I did not object for the vt1211 driver because
it was a new driver, and the author prefered it that way, so why not,
but I see little benefit in converting a perfectly working driver to a
different approach when both approaches have drawbacks and benefits.

> > >  static struct attribute * pc8736x_temp_attr_array[] = {
> > >  	TEMP_UNIT_ATTRS(0),
> > >  	TEMP_UNIT_ATTRS(1),
> > >  	TEMP_UNIT_ATTRS(2),
> > > -	/* include the few miscellaneous atts here */
> >
> > This comment can stay for now?
>
> Its less true than it once was - few is one, and not so miscellaneous -
> temp-alarms belongs with temp_*, and comment implies that its something 
> of a catch-all. 
> At least that was my mis-thinking when I 1st added it.
> 
> Or did you mean drop it *later* ?

No, I'm fine with that. I thought it was a left over from the first
patch attempt, but if you remove it on purpose it's OK.

(Indeed it then becomes a cleanup change without direct relation with
what the patch does. But nevermind.)

> btw, thunderbird shows me 7:28 am on this mail, but Id *swear*
> I looked at my inbox a dozen times today w/o seeing it.
> Any idea why ? / what time did you actually send it ?

Wed, 11 Oct 2006 15:28:19 +0200

Which is indeed 7:28 AM for you. Maybe the mail was delayed on the way,
check the headers.

> ps.  got a (link to a good model) patch converting a superio-i2c driver 
> to platform_driver ?
> It will simplify things if I have something to crib from ;-)

The f71805f and vt1211 drivers are already implemented as platform
drivers so you can start from there. The preliminary pc87427 driver
which I'll submit later this week is a platform driver as well.

For the pc87360 driver I expect an additional difficulty because it
uses up to 3 different I/O areas, each of which may or may not be
there. So you'll have to find a way to carry chip-specific information
from the Super-I/O detection step to the platform device creation, and
from there to the platform device probe function.

You may take a look there:
http://khali.linux-fr.org/devel/linux-2.6/hwmon-f71805f-add-f71872f-support.patch
This is an example of how I used dev.platform_data to carry this
information now that the f71805f driver supports two different chip
types. I guess you'll have to do something similar.

-- 
Jean Delvare

