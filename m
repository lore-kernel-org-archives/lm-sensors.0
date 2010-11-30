From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Nov 2010 19:44:36 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101130204436.10a65566@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriele,

On Tue, 30 Nov 2010 11:10:53 -0800, Gabriele Gorla wrote:
> On Tue, Nov 30, 2010 at 10:17:13AM +0100, Jean Delvare wrote:
> > > diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c linux-source-2.6.26/drivers/hwmon/adm1026.c
> > > --- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c	2008-07-13 14:51:29.000000000 -0700
> > > +++ linux-source-2.6.26/drivers/hwmon/adm1026.c	2010-11-29 17:21:06.000000000 -0800
> > > @@ -918,37 +918,42 @@
> > >  {
> > >  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> > >  	int nr = sensor_attr->index;
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > >  	struct adm1026_data *data = i2c_get_clientdata(client);
> > > -	int val, orig_div, new_div, shift;
> > > +	int val, orig_div, new_div;
> > >  
> > >  	val = simple_strtol(buf, NULL, 10);
> > > -	new_div = DIV_TO_REG(val);
> > > -	if (new_div = 0) {
> > > -		return -EINVAL;
> > > -	}
> > > -	mutex_lock(&data->update_lock);
> > > -	orig_div = data->fan_div[nr];
> > > -	data->fan_div[nr] = DIV_FROM_REG(new_div);
> > >  
> > > -	if (nr < 4) { /* 0 <= nr < 4 */
> > > -		shift = 2 * nr;
> > > -		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> > > -			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
> > > -			(new_div << shift)));
> > > -	} else { /* 3 < nr < 8 */
> > > -		shift = 2 * (nr - 4);
> > > -		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> > > -			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
> > > -			(new_div << shift)));
> > > +	if(val<1 || val>8) {
> > > +	        return -EINVAL;
> > 
> > As underlined by Phil already, this is a little inconsistent. You
> > should reject all invalid values, as documented at the end of
> > Documentation/hwmon/sysfs-interface. But this should be done in a
> > separate patch, as this isn't really a bug fix and changes the driver's
> > behavior on invalid input.
> 
> Original code will reject 1 as input. I think this is a bug as div=1 is
> valid for adm1026.

Yes, you are correct, and this has to be fixed, I don't disagree. But
you are also changing the behavior when the value is more than 8...

> Anyway, if you think I should separate the patch and reject all invalid
> values it's ok for me.

... and this proposed change would also change the behavior for values
3, 5, 6 and 7. We can't really do that in a stable kernel series.

Quick summary to avoid any further conclusion:

* The DIV_TO_REG() macro as it currently exists makes sense. It always
  return a valid divisor value, regardless of the input being "correct"
  or not. This goes against the recommendations of
  Documentation/hwmon/sysfs-interface (which were written long after
  the adm1026 driver was written) but this isn't a big issue per se.

* Ergo, the current validity check on new_div is a plain bug. There's
  no point in checking a value which is correct by construction - even
  more so if the check itself is wrong. So the check should be removed
  as a bug fix in stable kernel series.

* The new validity check you propose is correct, but doesn't comply
  with Documentation/hwmon/sysfs-interface either. If we're changing
  the behavior, we should at least follow the standard. This is why I
  (and Phil) suggest that you change your test.

I hope it's all clear now :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
