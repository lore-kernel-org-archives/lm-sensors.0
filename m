From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 14 Apr 2007 21:27:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new driver for SMSC
Message-Id: <191fb4ca0704141427i5ffa4b85m165bfe822ffc4c45@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
In-Reply-To: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Again, thanks for the review.

> > + * Copyright (c) 2007 Juerg Haeflier <juergh@gmail.com>
>
> Typo in your name.

Duh... :-)


> > +static u8 DME1737_REG_IN_LSB[] = {0x87, 0x88, 0x88, 0x87, 0x86, 0x84, 0x84};
> > +static u8 DME1737_REG_IN_LSB_SHR[] = {0, 0, 4, 4, 4, 4, 0};
>
> These could be made const.
>
> This approach doesn't seem very efficient to me. You'll end up reading
> registers 0x84-0x88 twice on every refresh cycle. Given that SMBus
> reads aren't exactly fast and cheap, I'd rather avoid extra reads. I
> suggest that you read the values from these 5 registers in a temporary
> array in the update function, and change DME1737_REG_IN_LSB and
> DME1737_REG_TEMP_LSB to list offsets in this array, rather than
> absolute register addresses. That way, you read each register only once.

Agreed, will fix.


> > +#define DME1737_REG_FAN_MAX(ix)              (0xb4 + (ix))
>
> This last macro appears to be valid only for ix in 4-5? This could be
> documented.

Yes, will clarify.


> > +#define DME1737_REG_PWM_CONFIG(ix)   (0x5c + (ix))
> > +#define DME1737_REG_PWM_MIN(ix)              (0x64 + (ix))
>
> These two only valid for ix in 0-2?

Ditto.


> > +#define DME1737_REG_PWM_FREQ(ix)     ((ix) < 3 ? 0x5f + (ix) \
> > +                                               : 0xa3 + (ix))
> > +#define DME1737_REG_PWM_RR(ix)               (0x62 + (ix))
>
> The register mapping for this one is quite different from the rest, it
> is kinda error-prone to present is as if it were similar.

Will clarify.


> > +#define DME1737_REG_ZONE_LOW(ix)     (0x67 + (ix))
> > +#define DME1737_REG_ZONE_ABS(ix)     (0x6a + (ix))
> > +#define DME1737_REG_ZONE_HYST(ix)    (0x6d + (ix))
>
> Again this one is mapped differently, this deserves a comment.

Ditto.


> > +/* ---------------------------------------------------------------------
> > + * Super-I/O constants
> > + * --------------------------------------------------------------------- */
> > +
> > +#define DME1737_COMPANY_SMSC 0x5c
> > +#define DME1737_VERSTEP              0x88
> > +#define DME1737_VERSTEP_MASK 0xf8
>
> These are not Super-I/O constants, as you are comparing them with
> values read from the SMBus registers.

Will change the comment.


> > +     u16 temp[3];
> > +     u8  temp_min[3];
> > +     u8  temp_max[3];
> > +     u8  temp_offset[3];
>
> You should be able to simplify the code in TEMP_FROM_REG and
> TEMP_TO_REG significantly by defining these temperature registers as
> s16 and s8.

I'll look into this.


> > +     u8  config;
> > +     u8  vrm;
>
> For what it's worth, vrm isn't actually a register value.

True.


> > +     u8  zone_abs[3];
> > +     u8  zone_hyst[2];
> > +     u32 alarms;
> > +     u8  vid;
> > +};
>
> You could move alarms either at the beginning or at the end of the
> register list, to minimize holes in the structure.

Good point, will do.


> > +
> > +/* nominal voltage value */
> > +static int IN_NOMINAL(int ix)
> > +{
> > +     int nom[] = {5000, 2250, 3300, 5000, 12000, 3300, 3300};
>
> This array should be declared static const. Same for similar arrays in
> the other conversion helpers. Alternatively, at least for this
> function, you could define a global static array directly, without a
> wrapper function, as the wrapper function doesn't add much.

OK, will optimize.


> > +     return nom[ix];
> > +}
>
>
> You really want to declare all these one- or two-line conversion
> functions inline. This will make your code faster _and_ smaller.

OK.


> > +static int IN_TO_REG(int val, int ix, int res)
> > +{
> > +     return SENSORS_LIMIT(val * (3 << (res - 2)) / IN_NOMINAL(ix),
> > +                          0, (1 << res) - 1);
> > +}
>
> Can you please add proper rounding to these voltage conversion
> formulae? Also, the second function is only ever called with res = 8 so
> you could simplify it a bit.

Will add rounding and simplify the functions that don't require
different resolutions.


> > +static int TEMP_RANGE_TO_REG(int val, int reg)
> > +{
> > +     int range = ((val > 66666) ? 15 : (val > 46666) ? 14 :
> > +                  (val > 36000) ? 13 : (val > 29333) ? 12 :
> > +                  (val > 23333) ? 11 : (val > 18000) ? 10 :
> > +                  (val > 14666) ? 9 : (val > 11666) ? 8 :
> > +                  (val > 9000) ? 7 : (val > 7333) ? 6 :
> > +                  (val > 5833) ? 5 : (val > 4500) ? 4 :
> > +                  (val > 3666) ? 3 : (val > 2917) ? 2 :
> > +                  (val > 2250) ? 1 : 0);
>
> This would be much nicer implemented as a loop iterating over a static
> array.

OK.


> > +static int TEMP_HYST_FROM_REG(int reg, int ix) {
>
> Improperly placed opening curly brace.

OK.


> > +static int FAN_FROM_REG(int reg, int tpc)
> > +{
> > +     return ((reg = 0 || reg = 0xffff) ? 0 :
> > +             (tpc = 0) ? 90000 * 60 / reg : tpc * reg);
> > +}
> > +
> > +static int FAN_TO_REG(int val, int tpc)
> > +{
> > +     return SENSORS_LIMIT((tpc = 0) ? 90000 * 60 / val : val / tpc,
> > +                          0, 65535);
> > +}
>
> It's a bit inconsistent to use 0xffff in one function and 65535 in the
> other.

Will fix.


> > +static int FAN_TYPE_FROM_REG(int reg) {
>
> Improperly placed opening curly brace.

OK.


> > +static int FAN_MAX_TO_REG(int val)
> > +{
> > +     return ((val > 5500) ? 0x0e : (val > 5000) ? 0x0f :
> > +             (val > 4500) ? 0x11 : (val > 4000) ? 0x12 :
> > +             (val > 3500) ? 0x15 : (val > 3000) ? 0x18 :
> > +             (val > 2500) ? 0x1c : (val > 2000) ? 0x21 :
> > +             (val > 1500) ? 0x2a : (val > 1000) ? 0x38 : 0x54);
> > +}
>
> Here again, a loop iterating over a static array (shared between the two
> functions) would be nicer IMHO.

OK.


> > +static int PWM_EN_FROM_REG(int reg)
> > +{
> > +     int en[] = {2, 2, 2, 0, -1, 2, 2, 1};
> > +     return en[(reg >> 5) & 0x07];
> > +}
>
> "-1" isn't a valid value according to our sysfs interface standard. A
> stopped fan would be presented as pwmN_enable = 1 and pwmN = 0
> according to our standard.

OK, will fix.


> > +static int PWM_RR_TO_REG(int val, int ix, int reg)
> > +{
> > +     int rr = ((val > 155) ? 8 : (val > 86) ? 9 :
> > +               (val > 55) ? 10 : (val > 33) ? 11 :
> > +               (val > 22) ? 12 : (val > 14) ? 13 :
> > +               (val > 14) ? 14 : (val > 0) ? 15 : 0);
>
> Bug here, you're doing the same comparison twice. According to the
> array above - which you could have reused) the second (val > 14) should
> be (val > 7).

Good catch, will fix.


> > +     /* enable a Vbat monitoring cycle every 30 secs */
> > +     if (time_after(jiffies, data->last_vbat + 30 * HZ) || !data->valid) {
> > +             dme1737_write(client, DME1737_REG_CONFIG, dme1737_read(client,
> > +                                             DME1737_REG_CONFIG) | 0x10);
> > +             data->last_vbat = jiffies;
> > +     }
>
> Do we really need a new battery reading every 30 seconds? I think I'd
> go for a much larger interval to not draw too much power from the
> battery.

How large? 5min?


> > +             data->config = dme1737_read(client, DME1737_REG_CONFIG);
>
> You only use the value of this register at device initialization time,
> so you don't need to refresh it. Make this a local variable in
> dme1737_init_client(), it's sufficient.

That's a leftover. Will remove.


> > +                     data->in[ix] |= (dme1737_read(client,
> > +                                     DME1737_REG_IN_LSB[ix]) >>
> > +                                     DME1737_REG_IN_LSB_SHR[ix]) & 0x0f;
>
> I would welcome a comment explaining that it is important to read the
> MSB first for integrity.

Will do.


> > +             /* fan registers */
> > +             for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {
>
> According to the datasheet, fans 5 and 6 (A and B in the datasheet)
> share their pins with other functions, and are not even the default.
> However you create the fan[5-6] and pwm[5-6] files unconditionally?
> Ideally you should check run-time registers 0x43 to 0x46 and only create
> the sysfs files (and read the registers) if the chip is configured that
> way.

I'll look into this.


> > +                     data->fan[ix] = dme1737_read(client,
> > +                                     DME1737_REG_FAN(ix));
> > +                     data->fan[ix] |= (dme1737_read(client,
> > +                                     DME1737_REG_FAN(ix) + 1) << 8);
>
> I would welcome a comment explaining that it is important to read the
> LSB first for value integrity. Have you tested if the DME1737 supports
> word reads on these registers? This would speed up the update a bit.

I'll check.


> > +                     data->fan_opt[ix] = dme1737_read(client,
> > +                                     DME1737_REG_FAN_OPT(ix));
> > +                     if (ix > 4) {
> > +                             data->fan_max[ix - 5] = dme1737_read(client,
> > +                                     DME1737_REG_FAN_MAX(ix));
> > +                     }
>
> This looks broken to me. Given that ix is in range 0 to 5, shouldn't
> this be "if (ix  >= 4)" and "data->fan_max[ix - 4]"?

Yeah, certainly is broken.


> > +                     if (ix < 2) {
> > +                             data->pwm_rr[ix] = dme1737_read(client,
> > +                                             DME1737_REG_PWM_RR(ix));
> > +                     }
>
> The "ix" in the last statement doesn't have the same meaning as in the
> rest of the loop, that's a bit confusing. Would you mind moving this
> last statement out of the loop?

Will do.


> > +                     if (ix < 2) {
> > +                             data->zone_hyst[ix] = dme1737_read(client,
> > +                                             DME1737_REG_ZONE_HYST(ix));
> > +                     }
>
> Same here.

Ditto.


> > +             data->alarms = dme1737_read(client,
> > +                                             DME1737_REG_ALARM1);
>
> If I read the datasheet properly, you could check the value of bit 7
> and skip the next two reads if it's clear.

I'll check.


> > +     case SYS_FAN_MAX:
> > +             /* only valid for fan[5-6] */
> > +             data->fan_max[ix - 5] = FAN_MAX_TO_REG(val);
> > +             dme1737_write(client, DME1737_REG_FAN_MAX(ix),
> > +                           data->fan_max[ix - 5]);
>
> Again I believe these should be "[ix - 4]".

Yes.


> > +     case SYS_FAN_TYPE:
> > +             /* only valid for fan[1-4] */
> > +             if (!(val = 2 || val = 3 || val = 5 || val = 9)) {
> > +                     count = -EINVAL;
> > +                     dev_warn(&client->dev, "Fan type value %ld not "
> > +                              "supported. Choose one of 2, 3, "
> > +                              "5, or 9.\n", val);
> > +                     goto exit;
> > +             }
> > +             data->fan_opt[ix] = FAN_TYPE_TO_REG(val, dme1737_read(client,
> > +                                     DME1737_REG_FAN_OPT(ix)));
>
> This isn't very efficient. You are doing again the same comparisons in
> FAN_TYPE_TO_REG() as you have been doing above. In general, when you
> need to validate discrete values from user input, it's better to not
> move the conversion to a separate function, so that you can do the
> validation and the conversion in one pass. Look at set_fan_div() in the
> fscher driver for example.

I'll check fscher.


> > +             if (PWM_EN_FROM_REG(data->pwm_config[ix]) != 1) {
> > +                     count = -EPERM;
> > +                     dev_warn(&client->dev, "Attribute is read-only. "
> > +                              "Pwm%d is not in manual mode\n", ix + 1);
> > +                     goto exit;
> > +             }
>
> What about actually turning the sysfs file read-only in this case? The
> f71805f driver does this, I think it's more elegant. An application can
> see that a file has been turned read-only, while an application won't
> read the system log.

I was thinking of going this way initially but dismissed the idea for
being to complicated. I'll revisit it.


> > +             if (val < -1 || val > 2) {
> > +                     count = -EINVAL;
> > +                     dev_warn(&client->dev, "PWM enable %ld not "
> > +                              "supported. Choose one of -1, 0, 1, or 2.\n",
> > +                              val);
> > +                     goto exit;
> > +             }
>
> As said earlier, -1 isn't actually an acceptable value.

Yes, will fix.


> > +             /* refresh the cache */
> > +             data->pwm_config[ix] = dme1737_read(client,
> > +                                             DME1737_REG_PWM_CONFIG(ix));
> > +             if (val = 2 &&
> > +                 PWM_EN_FROM_REG(data->pwm_config[ix]) != 2) {
> > +                     /* turn on auto mode using the saved temp channel
> > +                      * assignment */
> > +                     data->pwm_config[ix] = PWM_ACT_TO_REG(
> > +                                                     data->pwm_act[ix],
> > +                                                     data->pwm_config[ix]);
> > +                     dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
> > +                                   data->pwm_config[ix]);
> > +             } else if (val != 2) {
> > +                     /* set manual mode */
> > +                     if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
> > +                             /* save the current temp channel assignment
> > +                              * if we are currently in auto mode */
> > +                             data->pwm_act[ix] = PWM_ACT_FROM_REG(
> > +                                                     data->pwm_config[ix]);
> > +                     }
> > +                     data->pwm_config[ix] = PWM_EN_TO_REG(val,
> > +                                                     data->pwm_config[ix]);
> > +                     dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
> > +                                   data->pwm_config[ix]);
> > +             }
>
> You should be able to optimize/clean up this a bit:
> * Split the first test to two nested ifs, then you don't need to test
> if "val != 2", a simple "else" will do.
> * You can move the dme1737_write() call outside of the conditional
> blocks, as it's common to both blocks (worst case, you write the same
> value that was already there, which is OK.)

OK, will look into this.


> > +     case SYS_PWM_RAMP_RATE:
> > +             /* only valid for pwm[1-3] */
> > +             data->pwm_rr[ix > 0] = PWM_RR_TO_REG(val, ix,
> > +                                             dme1737_read(client,
> > +                                             DME1737_REG_PWM_RR(ix > 0)));
> > +             dme1737_write(client, DME1737_REG_PWM_RR(ix > 0),
> > +                           data->pwm_rr[ix > 0]);
>
> The datasheet says that ramp rate should be disabled in manual mode,
> but you driver doesn't do that?

I'm not aware of this requirement. I'll check the datasheet.


> > +static ssize_t show_alarms(struct device *dev,
> > +                        struct device_attribute *attr, char *buf)
> > +{
> > +     struct dme1737_data *data = dme1737_update_device(dev);
> > +
> > +     return sprintf(buf, "%d\n", data->alarms);
> > +}
>
> We don't want such compound alarms file in the new drivers. We're
> keeping them in older drivers only for backward compatibility purposes.

OK, will remove it.


> > +     SENSOR_ATTR_2(temp##ix##_auto_point2_temp_crit, S_IRUGO | S_IWUSR, \
> > +             show_temp, set_temp, \
> > +             SYS_TEMP_AUTO_POINT2_TEMP_CRIT, ix-1)
>
> We don't have this in our standard interface. This would rather be
> temp##ix##_auto_point3_temp, and pwm##ix##_auto_point3_pwm hard-coded
> to 255.

OK, will fix.


> > +     SENSOR_ATTR_2(pwm##ix##_ramp_rate, S_IRUGO | S_IWUSR, \
> > +             show_pwm, set_pwm, SYS_PWM_RAMP_RATE, ix-1), \
>
> I am curious, is this parameter really useful in practice?

Not sure :-) One can modify it through the BIOS (on my pundit) so I
thought it's worth exposing it through the driver as well.


> > +     /* force monitoring */
> > +     if (force_start) {
> > +             dme1737_write(client, DME1737_REG_CONFIG,
> > +                     dme1737_read(client, DME1737_REG_CONFIG) | 0x01);
> > +     }
> > +
> > +     data->config = dme1737_read(client, DME1737_REG_CONFIG);
> > +     /* inform if part is not monitoring/started */
> > +     if (!(data->config & 0x01)) {
> > +             dev_err(&client->dev, "Device is not monitoring. Use the "
> > +                     "force_start load parameter to override.\n");
> > +             return -EFAULT;
> > +     }
>
> This construct is rather confusing. When force_start is set, you read
> the configuration register twice, and you test a bit you just set
> yourself. What about this instead:
>
>         data->config = dme1737_read(client, DME1737_REG_CONFIG);
>         /* inform if part is not monitoring/started */
>         if (!(data->config & 0x01)) {
>                 if (!force_start) {
>                         dev_err(&client->dev, "Device is not monitoring. "
>                                 "Use the force_start load parameter to "
>                                 "override.\n");
>                         return -EFAULT;
>                 }
>
>                 /* force monitoring */
>                 data->config |= 0x01;
>                 dme1737_write(client, DME1737_REG_CONFIG, data->config);
>         }

Sure will fix.


> > +     /* inform if part is not ready or locked */
> > +     if (!(data->config & 0x04)) {
> > +             dev_err(&client->dev, "Device is not ready.\n");
> > +             return -EFAULT;
> > +     }
> > +     if (data->config & 0x02) {
> > +             dev_info(&client->dev, "Device is locked.\n");
> > +     }
>
> Shouldn't all sysfs files be switched to read-only in this case?

Yes, will look into this.


> > +     /* inform if fan-to-pwm mapping differs from the default */
> > +     if (reg != 0xa4) {
> > +             dev_err(&client->dev, "Unsupported fan to pwm mapping "
> > +                     "(fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
> > +                     "fan4->pwm%d). Please report to the driver "
> > +                     "maintainer.\n",
> > +                     (reg & 0x03) + 1, ((reg >> 4) & 0x03) + 1,
> > +                     ((reg >> 8) & 0x03) + 1, ((reg >> 12) & 0x03) + 1);
> > +             return -EFAULT;
> > +     }
>
> Why would this be a problem? I don't see where your driver is assuming
> anything about this mapping. It might be a good thing to report the
> mapping in the logs in any case, for the interested users. Or maybe we
> need a new sysfs file for this...

It becomes confusing. In case of a non-standard (non 1:1) mapping, one
might manually change pwmX and expect fanX_input to change accordingly
but instead fanY_input changes.


> > +     struct i2c_client *new_client = NULL;
>
> Please rename this to just "client". You don't need to initialize it to
> NULL, BTW.

OK.


> > +     /* For now, we assume we have a valid client. We now create the
> > +      * client structure, even though we cannot fill it completely yet. */
>
> Meaningless legacy comment, please discard.

OK.


> > +     new_client->addr    = address;
> > +     new_client->adapter = adapter;
> > +     new_client->driver  = &dme1737_driver;
> > +     new_client->flags   = 0;
>
> No alignment here please. And flags is already set to 0 by kzalloc
> above.

OK.


> > +     if (!((company = DME1737_COMPANY_SMSC) &&
> > +           ((verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP))) {
> > +             err = -ENODEV;
> > +             goto exit_kfree;
> > +     }
>
> You could use a few more registers to make the detection more reliable,
> as we did in sensors-detect.
>
> Also, you should skip this detection step if kind >= 0 (user used a
> force module parameter.)

OK, will do.


> > +     data->valid = 0;
>
> This one too is already initialized by kzalloc.

OK.


> > +     for (i = 0; i < ARRAY_SIZE(dme1737_sysfs_misc); i++) {
> > +             if ((err = device_create_file(&new_client->dev,
> > +                             &dme1737_sysfs_misc[i]))) {
> > +                     goto exit_remove;
> > +             }
> > +     }
>
> Why don't you use sysfs groups instead? sysfs_create_group() and
> sysfs_remove_group() work well, and you can even put all the attributes
> in one group.

I'll look into it.


> > +     .id             = I2C_DRIVERID_DME1737,
>
> Not needed.

OK.


> > +       If you say yes here you get support for the hardware monitoring
> > +       and fan control features of the SMSC DME1737 and ASUS A8000
> > +       Super-I/O chips.
>
> As far as I know, the SMSC SCH5027D is compatible as well. At least it
> is listed as such on our Devices wiki page.

I wouldn't know. Shall I add it blindly?


> ASUS should be spelled Asus, it's not an acronym AFAIK.

OK.


> > +#define I2C_DRIVERID_DME1737 1049
>
> You simply don't need this ID - they will all be removed soon anyway.
> Leave it to 0 in the driver.

OK.


> Nice driver overall, good job! Please provide an updated patch (or
> incremental patch on top of this one, at your option) for upstream
> inclusion.

Thanks. I learned from the master :-)
It'll take me a while to come up with a new patch. I disassembled the
box for noise reduction.

...juerg


> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
