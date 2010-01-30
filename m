From: "George Joseph" <george.joseph@fairview5.com>
Date: Sat, 30 Jan 2010 22:08:53 +0000
Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted by
Message-Id: <006801caa1f8$d1864740$7492d5c0$@joseph@fairview5.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
In-Reply-To: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All items incorporated.  Updated patch to follow.

> -----Original Message-----
> From: Hans de Goede [mailto:j.w.r.degoede@hhs.nl]
> Sent: Tuesday, January 26, 2010 4:56 AM
> To: Jaswinder Singh Rajput
> Cc: George Joseph; lm-sensors@lm-sensors.org; Jean Delvare; Linux
> Kernel Mailing List
> Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted
> by George Joseph on 2008-05-29
> 
> On 01/24/2010 06:05 AM, Jaswinder Singh Rajput wrote:
> > Hello Hans,
> >
> > On Sat, Jan 23, 2010 at 11:28 PM, Hans de Goede<j.w.r.degoede@hhs.nl>
> wrote:
> >> Hi,
> >>
> >> I just checked my Drafts folder, and I still have my unfinished
> review
> >> in there. So if there is interest I can send that, note that it is
> >> not a complete review though (there is a note in there which part
> >> of the code is reviewed and which still needs to be reviewed).
> >>
> >
> > Please provide your review so that we can discuss about this driver
> > and make relevant changes to accept it.
> >
> 
> Ok, here is the partly review I've done:
> 
> ---begin---
> Hi Joseph,
> 
> george.joseph@peakin.com wrote:
>  > Here's the c file by itself.
>  >
>  > Hans, will you have any time to review the driver in the near
> future?
>  >
> 
> I believe I said I would make time for this some time ago. Given that
> the 2.6.29 merge window has already opened, I've now done so (made
> time). So that this hopefully / maybe can make 2.6.29's merge window.
> 
> I must say that this driver deviates a lot from the standard way all
> other hwmon drivers are written making the review somewhat cumbersome
> and this might also be a problem if you step down and someone else
> becomes the maintainer.
> 
> I've split me review in 2 parts, first some comments about how you've
> implemented the sysfs API:
> 
> I notice that you have added foo_label sysfs entries, while you have
> nothing usefull to put in them, please do not _label entries are only
> for when the driver knows / can provide a label in the prefered format
> for a human reader of the sensors output, so not "in1", but something
> like "ATX 12V", so please remove all _label sysfs entries and remove
> the corresponding "char *label" member from the asc7621_param struct.
> 
> Likewise you've added tempX_type entries, but these always return the
> same value, in this case they can (and should be omitted) there is only
> the need to know (and more importantly be able to set) the type of the
> sensor, if it can be of different types, as in this case the BIOS might
> have set it wrong, when you remove these sysfs entries, you can also
> remove the corresponding "value" member from the asc7621_param struct.
> 
> 
> 
> And second, some feedback on the code itself.
> 
> First of all in *ALL* your store functions you need to store the result
> of strtol in a long and strtoul in an unsigned long, storing in smaller
> types can cause an overflow before you do any checking / clamping when
> the user gives a really large value as input.
> 
> Also in *ALL* store functions please use strict_strtol (and strtoul)
> instead of simple.
> 
> Last in some functions you need to clamp the input from the user to the
> valid input range before doing further calculations to avoid overflows
> during the calculation. Often clamping after calculations can be too
> late.
> 
> Example:
> 
> Instead of:
> 
> static ssize_t store_u8(struct device *dev, struct device_attribute
> *attr,
>                          const char *buf, size_t count)
> {
>          SETUP_STORE_data_param(dev, attr);
> 
>          u8 reqval = simple_strtoul(buf, NULL, 10);
> 
>          mutex_lock(&data->update_lock);
>          data->reg[param->msb[0]] = reqval;
>          write_byte(param->msb[0], reqval);
>          mutex_unlock(&data->update_lock);
>          return count;
> }
> 
> Write:
> 
> static ssize_t store_u8(struct device *dev, struct device_attribute
> *attr,
>                          const char *buf, size_t count)
> {
>      SETUP_STORE_data_param(dev, attr);
>      long reqval;
> 
>      if (strict_strtoul(buf, 10, &reqval))
>          return -EINVAL;
> 
>      reqval = SENSORS_LIMIT(v, 0, 255);
> 
>          mutex_lock(&data->update_lock);
>          data->reg[param->msb[0]] = reqval;
>          write_byte(param->msb[0], reqval);
>          mutex_unlock(&data->update_lock);
>          return count;
> }
> 
> Note that in this example all 3 described changes were made (use long,
> use strict_strtol, clamp before further use). *ALL* your store
> functions need the first 2 changes (use long, use strict_strtol), so
> I'm not going to make that comment for each and every store functions
> in the detailed comments below.
> 
> Where a store function needs earlier / different clamping I will make a
> comment in the detailed feedback given below.
> 
> Below are pieces of code from the driver with detailed feedback below
> them.
> 
> ###
> 
>   * This program is free software; you can redistribute it and/or
> modify
>   * it under the terms of the GNU General Public License as published
> by
>   * the Free Software Foundation; version 2 of the License.
>   *
> 
> I notice there is no "or at your option any later version" language
> here, this
> is fine, but I wonder if this is on purpose, if not please add "or at
> your
> option any later version", so that if the kernel ever (not likely)
> wants to
> move to GPL v3 this is one less file to worry about.
> 
> ###
> 
> /*
>   * The "chips" enum created by I2C_CLIENT_INSMOD_2 has "any_chip" as
>   * the first element in the enum, so it must also be first in our
> array.
>   */
> static struct asc7621_chip asc7621_chips[] = {
>          {
>           .name = "any",.chip_type = any_chip,
>           },
>          {
>           .name = "asc7621",.chip_type = asc7621,
>           .company_reg = 0x3e,.company_id = 0x61,
>           .verstep_reg = 0x3f,.verstep_id = 0x6c,
>           .addresses = normal_i2c,
>           },
>          {
>           .name = "asc7621a",.chip_type = asc7621a,
>           .company_reg = 0x3e,.company_id = 0x61,
>           .verstep_reg = 0x3f,.verstep_id = 0x6d,
>           .addresses = normal_i2c,
>           },
> };
> 
> Your driver still uses old style i2c driver binding, please update it
> too the
> new style. See for example:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-July/023773.html
> 
> You will probably want to remove using this when you do this, as this
> overlaps
> with the i2c_device_id array you need to declare then.
> 
> ###
> 
> static ssize_t store_u8(struct device *dev, struct device_attribute
> *attr,
>                          const char *buf, size_t count)
> {
>          SETUP_STORE_data_param(dev, attr);
> 
>          u8 reqval = simple_strtoul(buf, NULL, 10);
> 
>          mutex_lock(&data->update_lock);
>          data->reg[param->msb[0]] = reqval;
>          write_byte(param->msb[0], reqval);
>          mutex_unlock(&data->update_lock);
>          return count;
> }
> 
> Clamp large input values instead of allowing large values to cause
> overflows, see above for how this function should look (IMHO)
> 
> ###
> 
> static ssize_t store_bitmask(struct device *dev,
>                               struct device_attribute *attr,
>                               const char *buf, size_t count)
> {
>          SETUP_STORE_data_param(dev, attr);
> 
>          u8 reqval = simple_strtoul(buf, NULL, 10);
> 
> Same as for store_u8, except the values between which to clamp depend
> on the mask.
> 
> ###
> 
> static ssize_t show_fan16(struct device *dev,
>                            struct device_attribute *attr, char *buf)
> {
>          SETUP_SHOW_data_param(dev, attr);
> 
>          u16 regval = (data->reg[param->msb[0]] << 8) | data-
> >reg[param->lsb[0]]
> 
> 
> You are using multiple values from data here, this might race with
> device update resulting in using an old msb with a new lsb or vica
> versa, so you need locking around this.
> 
> ###
> 
> static ssize_t show_in10(struct device *dev, struct device_attribute
> *attr,
>                           char *buf)
> {
> 
> You are using multiple values from data here, you need locking around
> this.
> 
> ###
> 
> static ssize_t store_in8(struct device *dev, struct device_attribute
> *attr,
>                           const char *buf, size_t count)
> {
> 
>          u8 nr;
>          s32 reqval;
> 
>          SETUP_STORE_data_param(dev, attr);
> 
>          nr = sda->index;
>          reqval = simple_strtoul(buf, NULL, 10);
>          reqval *= asc7621_in_scaling_div[nr];
>          reqval /= asc7621_in_scaling_mul[nr];
>          reqval = SENSORS_LIMIT(reqval, 0, 255);
> 
> do SENSORS_LIMIT before calculations, the multiple might cause an
> overflow
> otherwise (and ofcourse, reqval should be a long, use strict_strtol).
> 
> ###
> static ssize_t show_temp10(struct device *dev,
>                             struct device_attribute *attr, char *buf)
> {
> 
> You are using multiple values from data here, you need locking around
> this.
> 
> ###
> 
> static ssize_t show_ap2_temp(struct device *dev,
>                               struct device_attribute *attr, char *buf)
> {
> 
> You are using multiple values from data here, you need locking around
> this.
> 
> ###
> 
> static ssize_t store_ap2_temp(struct device *dev,
>                                struct device_attribute *attr,
>                                const char *buf, size_t count)
> {
> 
> you need to take the lock earlier, before reading auto_point1 from the
> cached
> register array (and ofcourse, reqval should be a long, use
> strict_strtol).
> 
> ###
> 
> static ssize_t show_pwm_enable(struct device *dev,
>                                 struct device_attribute *attr, char
> *buf)
> {
> 
> You are using multiple values from data here, you need locking around
> this.
> 
> ###
> 
> In store store_pwm_freq() / store_pwm_ast() / store_temp_st() the
> following:
>          if (newval = 255)
>                  return count;
> 
> Should return -EINVAL, as you are rejecting the value (not making any
> changes)
> 
> ###
> 
> Note to self all store / show functions are reviewed
> 
> ---end---
> 
> Regards,
> 
> Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
