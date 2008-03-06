From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 06 Mar 2008 14:06:09 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <20080306140609.GN2892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick:

* Darrick J. Wong <djwong@us.ibm.com> [2008-03-04 09:13:41 -0800]:
> On Tue, Mar 04, 2008 at 09:54:40AM -0500, Mark M. Hoffman wrote:
> 
> <snip>
> > diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
> > index 9587869..3807062 100644
> > --- a/drivers/hwmon/adt7473.c
> > +++ b/drivers/hwmon/adt7473.c
> > @@ -422,11 +422,9 @@ static ssize_t show_volt(struct device *dev, struct device_attribute *devattr,
> >   * number in the range -128 to 127, or as an unsigned number that must
> >   * be offset by 64.
> >   */
> > -static int decode_temp(struct adt7473_data *data, u8 raw)
> > +static int decode_temp(u8 twos_complement, u8 raw)
> >  {
> > -	if (data->temp_twos_complement)
> > -		return (s8)raw;
> > -	return raw - 64;
> > +	return twos_complement ? (s8)raw : raw - 64;
> 
> Since this patch is to fix a bunch of race conditions, I think this chunk
> would be better off as a separate cleanup patch.  That said, you're the
> maintainer, so it's your call.... :)

I agree, and I'm glad you brought it up wrt adt7473.  I refactored both
encode_temp and decode_temp and then noticed that encode_temp actually
has the same race condition, eg:

 449 static ssize_t set_temp_min(struct device *dev,
 450                             struct device_attribute *devattr,
 451                             const char *buf,
 452                             size_t count)
 453 {
 454         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 455         struct i2c_client *client = to_i2c_client(dev);
 456         struct adt7473_data *data = i2c_get_clientdata(client);
 457         int temp = simple_strtol(buf, NULL, 10) / 1000;
 458         temp = encode_temp(data, temp);
 459 
 460         mutex_lock(&data->lock);
 461         data->temp_min[attr->index] = temp;
 462         i2c_smbus_write_byte_data(client, ADT7473_REG_TEMP_MIN(attr->index),
 463                                   temp);
 464         mutex_unlock(&data->lock);
 465 
 466         return count;
 467 }

Notice how encode_temp() above is outside of the locked section.  It is
instructive for potential reviewers of this patch series to see just how easy
it is to miss these.

However...

REG_CFG5 (from which temp_twos_complement is updated) is never written.  Do you
really need to read that during every update?  If you move that one read into
the init routine, that will instantly kill all the race conditions associated
with temp_twos_complement (assuming the hardware does not modify this register
behind our backs).  What do you think?

> I also suspect that ibmpex/i5k-amb will need similar cleanups.  I can
> generate patches if you want, though if you're intent upon fixing all of
> the drivers as one big push, let me know.

I am planning to just rip through them all myself.  But I want to get them all
done early enough to get good testing prior to 26-rc1... so I may ask for help
later if it looks like I won't have time.

Of course, I won't tell anyone *not* to help. ;)

> For the adt7470/adt7473 bits,
> Acked-by: Darrick J. Wong <djwong@us.ibm.com>

Thanks.  Cleanup patch for adt7473 to follow...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
