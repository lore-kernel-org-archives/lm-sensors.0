From: Steve.Glendinning@smsc.com
Date: Sun, 27 Jun 2010 15:40:52 +0000
Subject: Re: [lm-sensors] [PATCH] Add driver for SMSC EMC2103 temperature
Message-Id: <OFF6F531A5.A98FC3C8-ON8025774F.0054E543-8025774F.0056222E@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for the thorough review, lots of good catches there :)

I've posted a new version of the driver addressing pretty much all of 
this.  A few notes on your review comments:

> > +
> > +static int apd = 1;
> > +module_param(apd, bool, 0);
> > +MODULE_PARM_DESC(init, "Set to zero to disable anti-parallel diode 
mode");
> > +
> > +struct temperature {
> > +   s8   degrees;
> > +   u8   fraction;   /* 0-7 multiples of 0.125 */
> > +};
> 
> This doesn't make much sense. Just use a left-aligned s16. Your code
> will be much nicer.

I haven't done this, because I couldn't decide on the "nicest" way to do 
it!

> Did you check if the chip supports i2c_smbus_read_word_data()? This
> would be faster. Might even improve reliability if the device doesn't
> do register latching (I confess I didn't read the datasheet.)

No, unfortunately the part only supports byte accesses.  I tried it :)

> > +}
> > +
> > +static void read_fan_from_i2c(struct i2c_client *client, u16 *output,
> > +               u8 hi_addr, u8 lo_addr)
> 
> Always called with hi_addr = lo_addr + 1, so it could be simplified
> (would be consistent with what you do for temperatures above.)

No, it is not! The hi and lo tach registers are the wrong way round.

> > +static ssize_t set_fan_target(struct device *dev, struct 
device_attribute *da,
> > +               const char *buf, size_t count)
> > +{
> > +   struct emc2103_data *data = emc2103_update_device(dev);
> > +   struct i2c_client *client = to_i2c_client(dev);
> > +   long rpm_target;
> > +   int fan_div = 1 << data->fan_range;
> > +
> > +   int result = strict_strtol(buf, 10, &rpm_target);
> > +   if (result < 0)
> > +      return -EINVAL;
> > +
> > +   if ((rpm_target < 0) || (rpm_target > 16384))
> 
> Odd arbitrary limit. Rationale please? The chip can handle speeds
> faster than this.

The datasheet states this as the maximum supported speed.

> > +
> > +   write_fan_target_to_i2c(client, data->fan_target);
> > +
> > +   if (!data->fan_rpm_control) {
> > +      /* RPM control mode is not currently enabled */
> > +      int status = i2c_smbus_read_byte_data(client, REG_FAN_CONF1);
> > +      if (status < 0) {
> > +         dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
> > +            REG_FAN_CONF1, status);
> > +         mutex_unlock(&data->update_lock);
> > +         return -EIO;
> > +      }
> > +      status |= 0x80;
> > +      i2c_smbus_write_byte_data(client, REG_FAN_CONF1, status);
> 
> This isn't OK. Fan speed control should be enabled (and disabled! -
> your driver currently doesn't even allow it) explicitly by the user.
> This should be controlled by file pwm1_enable: 0 for no control and 3
> for target speed mode.

I've done this, is the meaning of the number 3 documented anywhere?  I
didn't see it in Documentation/hwmon/sysfs-interface, that just says
2+ means automatic fan speed control enabled.

Steve

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
