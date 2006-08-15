From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 15 Aug 2006 20:46:41 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608151346w5051e7d2vcbd16c7a6434ecf9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks a lot for the review. Please see my inlined comments.


> > +     tristate "Via VT1211"
>
> VIA should always be spelled all in capitals.

OK.


> The logical order would suggest to put this entry before the VT8231
> entry.

OK.


> >  obj-$(CONFIG_SENSORS_W83627EHF)      += w83627ehf.o
> >  obj-$(CONFIG_SENSORS_W83L785TS)      += w83l785ts.o
> > +obj-$(CONFIG_SENSORS_VT1211) += vt1211.o
>
> In alphabetical order please.

OK.


> static int uch_config = -1;
> module_param(uch_config, int, 0);
>
> Strange that nobody noticed, because your driver currently forces
> uch_config to 0 rather than preserving the chip defaults (possibly set
> by the BIOS.)

OK, let me check that. I'm pretty sure that the uch_config wasn't set
to 0 by the driver, otherwise it wouldn't have worked correctly. I'll
check it later when I have access to the machine.


> > +MODULE_PARM_DESC(uch_config, "Initialize the universal channel configuration");
>
> Do you know systems where this is actually needed? When porting the
> vt8231 driver, we made the choice to always trust the BIOS. Nobody
> complained about this. The right configuration depends on the hardware,
> and the user is unlikely to know better than the BIOS.

Legacy reasons I guess. It was in the 2.4 driver (I believe someone
reported that some BIOSes didn't set it properly) so I kept it around.
I'd like to keep it unless you insist in removing it.


> > + * -12V            in6                        Reserved
>
> Has in6 been reported to work for anyone? The Linux 2.4 driver didn't
> have it, I don't see it in the VT1211 datasheet, and I don't see any
> pin for it on the VT1211 pin diagram. I suggest to drop it.

No, it's not there, I just kept it because it was mentioned in the 2.4
driver. I'll get rid of it.


> > +static const u8 regtemp[]    = {0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25};
> > +static const u8 regtempmax[] = {0x1d, 0x3d, 0x39, 0x2b, 0x2d, 0x2f, 0x31};
> > +static const u8 regtemphyst[]        = {0x1e, 0x3e, 0x3a, 0x2c, 0x2e, 0x30, 0x32};
>
> The Linux 2.4 driver has the limits of temp1 and temp3 swapped. I
> assume this is a bug in the 2.4 driver, and yours is correct? If so, we
> should fix the 2.4 driver.

No, this matches the 2.4 driver. So temp1 and temp3 are swapped. I had
a discussion with Rudolf (I believe) about this a while ago and we
decided to match 2.4 first and once the 2.6 driver is accepted I'll
fix both 2.4 and 2.6 at the same time. Otherwise I have to patch 2.4
now and I'm busy enough getting 2.6 accepted :-)


> > +#define VT1211_REG_TEMP(ix)          (regtemp[(ix)])
> > +#define VT1211_REG_TEMP_MAX(ix)              (regtempmax[(ix)])
> > +#define VT1211_REG_TEMP_HYST(ix)     (regtemphyst[(ix)])
>
> Please access the arrays directly.

OK.


> > +#define VT1211_REG_PWM_AUTO_PWM(ix, ap)      (0x55 + 2 * (ix) + ap)
>
> Missing parentheses around "ap". I think I'd also prefer it written:
> (0x56 + 2 * (ix) + ((ap) - 1))
> Result is the same, but easier to match against the datasheet.

OK.


> > +#define VT1211_BIT_ALARM_IN(ix)              (bitalarmin[ix])
> > +#define VT1211_BIT_ALARM_TEMP(ix)    (bitalarmtemp[ix])
> > +#define VT1211_BIT_ALARM_FAN(ix)     (bitalarmfan[ix])
>
> Same here, please access the arrays directly.

OK.


> > +     struct mutex lock;
>
> This lock isn't used anywhere, you can drop it.

OK.


> > +#define IN_TO_REG(ix, val)   ((ix) = 5 ? \
> > +                              SENSORS_LIMIT((((val) * 958 / 15882) + 3), \
> > +                                     0, 255) : \
> > +                              SENSORS_LIMIT((((val) * 958 / 10000) + 3), \
> > +                                     0, 255))
>
> Please add proper rounding.

OK.


> > +#define TEMP_TO_REG(ix, val) ((ix) = 0 ? \
> > +                              SENSORS_LIMIT((((val) / 1000) + 51), \
> > +                                     0, 255) : \
> > +                              SENSORS_LIMIT(((val) / 1000), 0, 255))
>
> No official formula for temp1? Indeed I can't find any in the datasheet
> nor BIOS porting guide :( I think it's OK to "scale" temp1 inside the
> driver, however the Linux 2.4 driver didn't, so if we want a common
> configuration file we'll have to modify the Linux 2.4 driver. It would
> also be nice to check on another system how accurate your empirical
> formula is.

Hmm... Are you leaning toward userspace scaling for temp1? I really
don't care...
If I take the same approach as with the temp1/temp3 swapping I'd say I
match the 2.4 implemenation first and fix both 2.4 and 2.6 later. OK?


> For all other temperature channels, I'm not OK. These are
> thermistor-based measurements with external resistors and thermistors,
> so most scaling belongs to userspace. What we want to export here is
> the voltage at the pins, in mV. This wasn't done correctly in the
> Linux 2.4 driver, but in 2.6 we have a standard interface and we have
> to respect it. This is exactly the same as for the VT8231 so the same
> formula should work:
>
> #define TEMP_FROM_REG(reg)              (((253 * 4 - (reg)) * 550 + 105) / 210)
> #define TEMP_MAXMIN_FROM_REG(reg)       (((253 - (reg)) * 2200 + 105) / 210)
> #define TEMP_MAXMIN_TO_REG(val)         (253 - ((val) * 210 + 1100) / 2200)

Hmm.... I'll have to think about this first.


> Of course we will have to change the configuration file to accomodate
> the change, as we did for the vt8231 driver.
>
> BTW, I see you don't export the additional precision bits for these
> temperature channels. Any reason why? The original driver supported
> them.

Lazyness. I don't think those 2 LSBs justify the effort to export
them. Really, who cares about centi-degrees and how much actual value
do they really provide (other than white noise)?


> > +#define DIV_TO_REG(val)      ((val) = 8 ? 3 : \
> > +                              (val) = 4 ? 2 : \
> > +                              (val) = 1 ? 0 : 1)
>
> We now try to return errors on invalid divider values, rather than
> using a default value. This means that you should no more have a macro
> for this, instead you should check for valid values in the set_fan
> function directly (return -EINVAL on invalid values.) Take a look af
> fscher.c:set_fan_div() for an example.

OK, will do.


> > +#define PWM_FROM_REG(val)    (val)
>
> Useless macro, please drop.

OK.


> > +#define PWM_TO_REG(val)      SENSORS_LIMIT((val), 0, 255)
>
> Here too, recent implementations tend to return an error on
> out-of-range values.

OK.


> > +#define RPM_FROM_REG(val, div)       ((val) <= 0   ? 0 : \
> > +                              (val) >= 255 ? 0 : \
> > +                              1310720 / (val) / DIV_FROM_REG(div))
>
> val < 0 and val > 255 just can't happen ;)

OK.


> > +#define RPM_TO_REG(rpm, div) ((rpm) = 0 ? 0 : \
> > +                              SENSORS_LIMIT((1310720 / (rpm) / \
> > +                                     DIV_FROM_REG(div)), 1, 255))
>
> The datasheet suggests that 255 should be written to disable the alarm,
> rather than 0. If so, the SENSORS_LIMIT should also be done with (...,
> 1, 254) as its parameters, i.e. pick the lowest possible limit rather
> than 0 when a very low value is requested.

Let me check that.


> > +#define TEMPIX_FROM_REG(val) (pwmctl2tempix[val])
> > +#define TEMPIX_TO_REG(ix)    (tempix2pwmctl[ix])
>
> Same as above, please access the arrays directly.

OK.


> > +static u8 vt1211_read8(struct vt1211_data *data, u8 reg)
> > +{
> > +     return inb(data->addr + reg);
> > +}
> > +
> > +static void vt1211_write8(struct vt1211_data *data, u8 reg, u8 val)
> > +{
> > +     outb(val, data->addr + reg);
> > +}
>
> These two should certainly be inlined for performance.

OK and what exactly does inline do?


> > +                     } else {
> > +                             data->in[ix] = 0;
> > +                             data->in_min[ix] = 0;
> > +                             data->in_max[ix] = 0;
> > +                     }
> > +             }
>
> This is inefficient. Given that uch_config never changes, you will end
> up writing 0 to the same array locations over and over again. You
> should do it once at device initialization time instead. And actually
> you don't need to, because 0 is the default value (thanks to kzalloc).

Makes sense, will do.


> > +             data->pwm_auto_pwm[1][3] = 0;   /* hard wired */
>
> Again, the values which are hard-wired do not belong to this update
> function, but to the device initialization.

dito.


> > +
> > +
>
> One too many blank line.

OK.


> > +     int ix = sensor_attr_2->index;
> > +     int fn = sensor_attr_2->nr;
> > +     int res = 0;
>
> Please add a blank line after variable declarations in all your
> callback functions, it greatly increases the readability.

OK.


> > +     default:
> > +             printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
>
> As I understand it, the default case can't happen unless the driver is
> broken. Thus it would make sense to make this a debug message. Also,
> please convert all these printk calls to dev_err, dev_dbg, etc. These
> provide a uniform way to print device messages.
>
> You can also move the initialization of res to 0 here, as other cases don't need it.

OK.


> > + *  -------------------------------------------------------------------- */
>
> Missing dash ;)

:-)


> > +     case SHOW_SET_FAN_DIV:
> > +             data->fan_div[ix] = DIV_TO_REG(val);
> > +             vt1211_write8(data, VT1211_REG_FAN_DIV,
> > +                           ((data->fan_div[1] << 6) |
> > +                            (data->fan_div[0] << 4) |
> > +                             data->fan_ctl));
> > +             break;
>
> Not correct. You assume the data cache is in synch with register
> VT1211_REG_FAN_DIV, while it may not be (e.g. if this function is
> called before the update function ever is.) Please read the contents of
> VT1211_REG_FAN_DIV so that you are sure you won't change bits in that
> register.

OK.


> > +/* ---------------------------------------------------------------------
> > + * PWM sysfs interfaces
> > + * ix = [0-1]
> > + * --------------------------------------------------------------------- */
>
> Was PWM tested on the VT1211? Both manual and automatic modes? I
> remember we dropped it from the vt8231 driver because it didn't
> actually work for anyone.

See other thread
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017192.html.


> > +     int en, sg;
>
> What explicit variable names ;) Care to make them a bit longer, or at
> least add a short comment for each?

:-) sure


> > +     case SHOW_SET_PWM_ENABLE:
> > +             en = (data->pwm_ctl[ix] >> 3) & 1;
> > +             sg = data->fan_ctl & 1;
> > +             res = (en && sg) ? 2 : en ? 1 : 0;
>
> What does it mean when en = 0? Fan stopped, or fan at full speed? I
> hope the latter.

It means PWM output disabled but I don't know what state the pin will
be in. I'll try to check with a voltmeter.


> > +             vt1211_write8(data, VT1211_REG_FAN_DIV,
> > +                           ((data->fan_div[1] << 6) |
> > +                            (data->fan_div[0] << 4) |
> > +                             data->fan_ctl));
> > +             break;
>
> Here again, you assume that your cached values are up-to-date. You must
> instead read them from the chip. Same for all other similar cases.

OK.


> I think I understand that setting one PWM channel in automatic mode
> will set the other channel in automatic mode as well, right?

Yes, there's only one SmartGuardian controller that controls both PWM
outputs simultaneously.


> > +             /* calculate tmp = log2(val) */
> > +             tmp = 0;
> > +             for (val >>= 1; val > 0; val >>= 1) {
> > +                     tmp++;
> > +             }
>
> Wow, this is clever :)

love it!


> > +     case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> > +             tmp = TEMPIX_TO_REG(SENSORS_LIMIT(val, 1, 7) - 1);
>
> You should make sure that this channel is actually a temperature
> channel!

OK.


> > +             data->pwm_ctl[ix] = (data->pwm[ix] & 8) | tmp;
>
> Isn't it a wonderful typo I see here?

Oops..


> > +             vt1211_write8(data, VT1211_REG_PWM_CTL,
> > +                           ((data->pwm_ctl[1] << 4) | data->pwm_ctl[0]));
> > +             break;
>
> Do we agree that changing the temperature channel may also change the
> temperature points as a side effect? Don't we want to prevent that?

Not sure what you mean, I'll have to think about it.


> > + * Note that there is only a single set of temp auto points that controls both
> > + * PWM controllers. We still create 2 sets of sysfs files to make it look
> > + * more consistent even though they map to the same registers.
>
> The second set should be made read-only to help clear the confusion.

OK.


> > + * 0  0  : pwm1/pwm2 full speed temperature (pwm_auto_temp[0])
> > + * 0  1  : pwm1/pwm2 high speed temperature (pwm_auto_temp[1])
> > + * 0  2  : pwm1/pwm2 low speed temperature (pwm_auto_temp[2])
> > + * 0  3  : pwm1/pwm2 off temperature (pwm_auto_temp[3])
>
> Iirk, you have it all reversed. point 0 should be fan off, point with
> the higher number should be fan at full speed.

Is this a standard? I just followed the datasheet.


> > +     if (ap = 1 || ap = 2) {
>
> No, you want to set the sysfs files read-only for ap = 0 and ap = 3,
> so this test is no more needed. It's better because then the user (or
> user-space application) sees right away that these values can't be
> changed.

Yep, that's a good idea.


> > +     struct vt1211_data *data = vt1211_update_device(dev);
>
> No need to update! The vrm value is not read from the chip.

OK.


> > +     struct vt1211_data *data = vt1211_update_device(dev);
>
> Same here, the VID value is read at init time and not updated so this
> call is not needed.

OK.


> > +     SENSOR_ATTR_2(pwm##ix##_frequency, S_IRUGO | S_IWUSR, \
> > +             show_pwm, set_pwm, SHOW_SET_PWM_FREQUENCY, ix-1), \
>
> We don't have a standard sysfs name for this yet. I would suggest the
> shorter pwmN_freq. Would you mind adding an entry in
> Documentation/hwmon/sysfs-interface so that other drivers can follow it?

Sure, will do.


> > +     SENSOR_ATTR_2(pwm##ix##_auto_channels_temp, S_IRUGO | S_IWUSR, \
> > +             show_pwm, set_pwm, SHOW_SET_PWM_AUTO_CHANNELS_TEMP, ix-1)
> > +
> > +#define SENSOR_ATTR_PWM_AUTO_POINT(ix, ap) \
> > +     SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_temp, S_IRUGO | S_IWUSR, \
> > +             show_pwm_auto_point_temp, set_pwm_auto_point_temp, \
> > +             ap-1, ix-1), \
> > +     SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_pwm, S_IRUGO | S_IWUSR, \
> > +             show_pwm_auto_point_pwm, set_pwm_auto_point_pwm, \
> > +             ap-1, ix-1)
>
> This needs to be refined a bit to set some of these files read-only.

OK, will do.


> > +
> > +static struct sensor_device_attribute_2 vt1211_sensor_attr_2[] = {
> > +     SENSOR_ATTR_IN(0),
> > +     SENSOR_ATTR_IN(1),
> > +     SENSOR_ATTR_IN(2),
> > +     SENSOR_ATTR_IN(3),
> > +     SENSOR_ATTR_IN(4),
> > +     SENSOR_ATTR_IN(5),
> > +     SENSOR_ATTR_IN(6),
> > +     SENSOR_ATTR_TEMP(1),
> > +     SENSOR_ATTR_TEMP(2),
> > +     SENSOR_ATTR_TEMP(3),
> > +     SENSOR_ATTR_TEMP(4),
> > +     SENSOR_ATTR_TEMP(5),
> > +     SENSOR_ATTR_TEMP(6),
> > +     SENSOR_ATTR_TEMP(7),
> > +     SENSOR_ATTR_FAN(1),
> > +     SENSOR_ATTR_FAN(2),
> > +     SENSOR_ATTR_PWM(1),
> > +     SENSOR_ATTR_PWM(2),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(1, 1),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(1, 2),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(1, 3),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(1, 4),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(2, 1),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(2, 2),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(2, 3),
> > +     SENSOR_ATTR_PWM_AUTO_POINT(2, 4)
> > +};
>
> You are creating files even for functions which are not available! Not
> OK. You must only enable one set of files for each UCH, either temp, of
> voltage, but not both! This will make the code a bit more complex, I
> concede, but this is the very fundamental idea behind the standard
> interface: user-space must be able to guess the available features just
> by scanning the available interface files.

Now that sounds like a smart idea! Will do...


> Also, please always add a comma at the end of the last line of array
> declarations. This makes appending lines later easier.

OK.


> > +     /* The VT1211 implements 3 different modes for clearing interrupts:
> > +      * 1) Clear INT when temp falls below max limit.
> > +      * 2) Clear INT when status register is read. Regenerate INT as long
> > +      *    as temp stays above hysteresis limit.
> > +      * 3) Clear INT when status register is read. DON'T regenerate INT
> > +      *    until temp falls below hysteresis limit and exceeds hot limit
> > +      *    again.
>
> It's a bit confusing that these values don't match the datasheet. The
> three modes you describe are 2, 0 and 1 on the datasheet, respectively,
> if I'm not mistaken.

I'll double check.

> > +      * We make sure that we're using mode 2 which is not the default
> > +      * (at least not on an EPIA M10000) */
> > +     vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0);
> > +     vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0);
> > +}
>
> I don't much like drivers changing the interrupt modes. Interrupt lines
> are physical and may be wired to any kind of system handling them, e.g.
> shutting the system down or starting an emergency fan etc. Changing the
> interrupt mode may cause great confusion in this case.

Hmm... this has been copied from the 2.4 driver. AFAIK nobody
complained about it. I noticed that on my EPIA M-10000 the interrupt
mode wasn't set correctly by the BIOS. But then I'm not a 100% sure
what the correct interrupt mode would be.
Are you suggesting to take it out or should I add it as a load parameter?


> > +             printk(KERN_ERR DRVNAME ": Out of memory\n");
>
> dev_err()

OK.


> > +     if (IS_ERR(data->class_dev)) {
> > +             err = PTR_ERR(data->class_dev);
> > +             dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> > +             goto EXIT_FREE;
> > +     }
>
> Class registration should be moved at the end - after creating the
> sysfs files.

OK.


> > +     for (i = 0; i < ARRAY_SIZE(vt1211_sensor_attr); i++) {
> > +             err = device_create_file(&pdev->dev, &vt1211_sensor_attr[i]);
> > +             if (err) {
> > +                     goto EXIT_DEV_UNREGISTER;
> > +             }
> > +     }
>
> You fail to delete all the files which were created if an error occurs.
> Most other hardware monitoring drivers do as well, but we are currently
> trying to get them fixed so it'd be nice if the vt1211 was OK right
> away. Note that it's OK to delete a file which was never created, and
> that makes the cleanup step much easier.

OK.


> > +EXIT_FREE:
>
> Missing platform_set_drvdata(pdev, NULL);

OK.

> > +static int __devexit vt1211_remove(struct platform_device *pdev)
> > +{
> > +     struct vt1211_data *data = platform_get_drvdata(pdev);
> > +
> > +     platform_set_drvdata(pdev, NULL);
> > +     hwmon_device_unregister(data->class_dev);
> > +     kfree(data);
> > +
> > +     return 0;
> > +}
>
> Here too you must delete all the files you created.

OK.


> > +static struct platform_driver vt1211_driver = {
> > +     .driver = {
> > +             .owner = THIS_MODULE,
> > +             .name  = DRVNAME,
> > +     },
> > +     .probe  = vt1211_probe,
> > +     .remove = __devexit_p(vt1211_remove),
> > +};
>
> Please align with tabs, not spaces.

OK.


> > +     val = ((superio_inb(SIO_VT1211_BADDR) << 8) |
> > +            (superio_inb(SIO_VT1211_BADDR + 1)));
> > +     *address = val & SIO_VT1211_BADDR_MASK;
>
> I see nothing in the datasheet justifying this masking.

I'll check.


> > +     if (*address = 0) {
> > +             printk(KERN_WARNING DRVNAME ": Base address not set, "
> > +                    "skipping\n");
> > +             goto EXIT;
> > +     }
>
> You should check the "Hardware Monitor Activate" register too (0x30).
> If bit 0 isn't set, the device isn't activated so the driver won't work.

OK.


> > +     printk(KERN_INFO DRVNAME ": Found VT1211 chip at %#x, revision %u\n",
>
> Last time I checked, the %#x form wasn't properly supported by printk
> and I had to revert it to 0x%x.

I'll check.


> > +     if (vt1211_find(&address)) {
> > +             err = -ENODEV;
> > +             goto EXIT;
> > +     }
>
> You could return the error from vt1211_find rather than hardcoding your
> own. (Granted, it's the same value anyway.)

OK.


> > + EXIT_DRV_UNREGISTER:
> > +     platform_driver_unregister(&vt1211_driver);
> > + EXIT:
> > +     return err;
> > +}
>
> No space before labels.

OK.


> > +           "Lars Ekman <emil71se at yahoo.com>, "
> > +           "Mark D. Studebaker <mdsxyz123 at yahoo.com>");
>
> I think you can drop Mark from the list, this driver is pretty much a
> rewrite and he didn't participate in it.

OK, will do.


> > +/* ---------------------------------------------------------------------
> > + * End of file
> > + * --------------------------------------------------------------------- */
>
> Please drop this comment. Seriously, everybody sees that's the end of
> the file, so what's the point?

:-) will do.


> To more general comments now:
>
> 1* At first I didn't much like the switch/case approach you took.
> There's not much point in putting all the code in the same function if
> only one chunk is executed each time. It has a performance cost. It
> also requires that you introduce arbitrary constants. Now I have to
> admit it brings some order in the source file. I wonder if the benefit
> is worth the drawbacks. But it's your driver anyway, I won't argue.

I like it.


> 2* Your driver doesn't provide the old-style all-in-one alarms file. As
> libsensors isn't aware of individual alarm files, this means alarms
> won't be reported for now. I suggest that you add this file, it doesn't
> cost much and guarantees backward compatibility for now.

OK, will do.


> 3* I am worried about the automatic PWM mode. I understand that there's
> only one set of temperature registers for both PWM outputs. However
> both PWM outputs may be mapped to different temperature channels, and
> these channels may measure the temperature in a different way. So the
> single register set may lead to related, but different fan behaviors.
> This will be very confusing for the user. Shouldn't we prevent the user
> from using temperature channels of different types for PWM1 and PWM2?

I agree, the VT1211 auto PWM implementation is far from optimal. I'm
not sure how to go about it though. I can't really tell if it can be
setup properly using different temp channels for the 2 PWM outputs
since I don't have a system with PWM controlled fans. I don't like
limiting the functionality of the driver for some theoretical reason
just because I don't have the ability to test it. On the other hand
things can really get screwed up if care is not taken properly...
At this point I would like to keep it the way it is and just hint in
the documentation that whoever mocks around with it better knows what
she/he is doing.


> OK, don't be frightened by the number of my comments, I am actually
> quite happy with your code in general. I see you've been putting energy
> in sticking to the coding style and the sysfs interface standard, and
> you also took benefit of the latest technologies available (dynamic
> sysfs callbacks, platform driver etc.) It's very nice.

Sigh... I don't want to see an unfavorable review :-)

Thanks a lot for the thorough review, Jean! I really appreciate it.

...juerg


> Next steps:
> * Process my complaints and submit a new driver.
> * Test it again!
> * User-space fixes and tests.
> * 2.4 driver fixes (best effort).
> * Documentation (I'll go read your doc patch now.)
>
> Thanks! And sorry again for the delay.
>
> --
> Jean Delvare
>

