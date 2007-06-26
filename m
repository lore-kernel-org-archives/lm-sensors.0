From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Jun 2007 18:19:51 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <20070626201951.14e7093e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Christian,

On Mon, 25 Jun 2007 07:19:33 +0200 (CEST), Christian Emmerich wrote:
> The first version of this message was to large and was rejected, so
> i had to cut the quote a little bit.

The reject message explained that you shouldn't be sending HTML mails.
This makes your mails more than twice as big as they should, and that
explains the reject.

> > Did pwmconfig work?
>
> I get it working now, i just have to set FCTEMPS and FCFANS correct in /e=
tc/fancontrol now it work.
> The only problem is, that if i stop fancontrol, the program set pwm1_enab=
le to 0, but
> after this the fan turns at 23rpm. This also happens if i set pwm1_enable=
 to 0 by hand.

Sounds like a bug in the driver then. Setting pwm1_enable to 0 should
turn the fan to full speed.

> > sensors output looks like:
> > mythtv@pc:~$ sensors F75373-*
> > F75373-i2c-1-2d
> > Adapter: SMBus nForce2 adapter at 5100
> > :
> > CPU PWM:    31      (enable =3D 1)
> >
> > Did you try setting limits?
> I try to set limits in sensors.conf but i could see no change.

You must run "sensors -s" after changing the limits
in /etc/sensors.conf for the new limits to be applied. Please test this,
this is a good way to test both the libsensors code you added, and the
driver itself.

> > Lastly, you really shouldn't have to divide the values by 1000. This
> > suggests that the magnitude wasn't set properly in libsensors (it
> > should be 3, I suggest it is 0). This issue is most probably related to
> > the incorrect symbol names.
>=20
> I saw values >800V so i thought i have to divide it by 1000 in sensors.co=
nf.
> Magnitude is 3 and the symbol name is correct now, but the values are sti=
ll
> over 800V. What's the reason?

I guess that's a bug in the driver. What values do you see in the
in*_input sysfs files?

> > This means that the driver isn't reporting the values in RPM as it
> > should. Usually no compute statement is needed for fans.
>
> That's correct, the value is not in RPM, in the document '2005111153128.p=
df' you can download on the fintek page
> ( http://www.fintek.com.tw/eng/products.asp?BID=3D4&SID=3D5 )its written =
on page 8:
> "Determine the fan counter according to:
> Count =3D (1.5=D710^6) / RPM "
> That means that the driver is reporting the count value, not the rpm.
> So i have to compute in sensors.conf:
> RPM =3D (1.5=D710^6)/ Count

Almost all chips do that, but that's not the point. Our sysfs-interface
standard says that the conversion to RPM must occur in the driver and
not in user-space. So the f75375 driver needs to be updated.

> > +#define SENSORS_F75373_FAN_FEATURES(nr) \
> > +        { { SENSORS_F75373_FAN(nr), "fan" #nr, \
> > +                NOMAP, NOMAP, R }, \
> > +                NOSYSCTL, VALUE(2), 0 }, \
> > +        { { SENSORS_F75373_FAN_MAX(nr), "fan" #nr "_max", \
> > +                SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW }, \
> > +                NOSYSCTL, VALUE(1), 0 }, \
> >
> > Strange, I've never seen a fan speed sensor with a high limit. What
> > does it correspond to exactly? Why don't you display this value in
> > "sensors"?
>
> I get the information out of the documentation on page 26:
> "When power on, the PWMOUT1 will output full duty cycle (FFh) to
> enable system FAN. After 10 seconds when detecting FANIN1
> signal, assuming the fan has been fully turned on, the fan speed
> count detected will be recorded in the register.".
> Dunno if it should be removed?

Oh, I see, it is recording the maximum possible speed. It should be
marked read-only then, I guess. I am also reluctant to naming this
feature fan1_max, even if we don't use that name yet, because the _max
suffix is only used for limits at the moment so it might be confusing
to use _max for something else now. Maybe fan1_full? This should be
discussed separately. In the meantime, I suggest that you omit this
value in libsensors.

> > +        { { SENSORS_F75373_FAN_MIN(nr), "fan" #nr "_min", \
> > +                SENSORS_F75373_FAN(nr), NOMAP, R }, \
> > +                NOSYSCTL, VALUE(1), 0 }
> >
> > SENSORS_F75373_FAN(nr) instead of NOMAP.
> >
> > Is it really read-only?
>
> I changed it to SENSORS_F75373_FAN(nr), it is RW.
> But fanX_min is allways zero, so it lead to an error on calling
> 'sensors_get_feature(*name, SENSORS_F75373_FAN_MIN(i), &min)',
> i have to disable it, sensors output is now
> CPU Fan:  1866 RPM  (min =3D    0 RPM)
> to
> CPU Fan:  1866 RPM

fan1_min =3D 0 isn't an error per se. If you see an error, then something
else must be wrong. Can you read the value from fan1_min directly from
sysfs?

> > +#define SENSORS_F75373_PWM_FEATURES(nr) \
> > +        { { SENSORS_F75373_PWM(nr), "pwm" #nr, \
> > +                NOMAP, NOMAP, RW }, \
> > +                NOSYSCTL, VALUE(1), 0 }, \
> > +        { { SENSORS_F75373_PWM_ENABLE(nr), "pwm" #nr "_enable", \
> > +                SENSORS_F75373_PWM(nr), SENSORS_F75373_PWM(nr), RW }, \
> > +                NOSYSCTL, VALUE(3), 0 }
> >
> > In fact we don't include PWM stuff in libsensors. They are not sensors,
> > and are better handled using pwmconfig and fancontrol.
>
> I only copied it from SENSORS_DME1737_PWM_FEATURES, should i remove it?

Ah, I hadn't noticed that the DME1737 had definitions for PWM. It's
more of an exception than the rule. So yes, please remove the PWM stuff.

> > +    if (valid) {
> > +      print_label(label, 10);
> > +      print_temp_info(cur, max, 0, HYST , 0, 0);
> > +      printf("%s\n", alarm ? "ALARM" : "");
> > +    }
> >
> > This doesn't make sense. What is SENSORS_F75373_TEMP_HYST exactly? Why
> > do you display it as an alarm?
>
> It was a mistake, i deleted the Alarm output, now it is only printf("\n"),
> there seems not to be a value for an alarm.
> temp1_max_hyst is always zero, i don't now what it is exactly and
> when it is not zero.

temp1_max_hyst is supposed to represent the hysteresis temperature
value for the temp1_max limit, and the value should be passed as the
3rd argument to print_temp_info(). If it reads 0, maybe that's a driver
bug. Again, try reading the value directly from sysfs. And please
report the problems you find to the driver author so that he can fix
them.

> >       { "coretemp", print_coretemp },
> >       { "dme1737", print_dme1737 },
> >      { "applesmc", print_applesmc },
> > +    { "F75373", print_f75373 },
> >
> > Should be "f75373", no capital. I'm even surprised it worked with the
> > capital.
>
> If i use f75373 i get following output:
> F75373-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 5100
> VCC: 1720.00 (in0)
>   in0_min: 0.00 (in0_min)
>   in0_max: 0.00 (in0_max)
> V1: 1336.00 (in1)
>   in1_min: 0.00 (in1_min)
>   in1_max: 0.00 (in1_max)
> V2: 1008.00 (in2)
>   in2_min: 0.00 (in2_min)
>   in2_max: 0.00 (in2_max)
> V3: 792.00 (in3)
>   in3_min: 0.00 (in3_min)
>   in3_max: 0.00 (in3_max)
> CPU Temp: 49.00 (temp1)
>   temp1_max: 0.00 (temp1_max)
>   temp1_hyst: 0.00 (temp1_hyst)
> Sys Temp: 46.00 (temp2)
>   temp2_max: 0.00 (temp2_max)
>   temp2_hyst: 0.00 (temp2_hyst)
> CPU Fan: 1787.84 (fan1)
>   fan1_max: 5681.82 (fan1_max)
> ERROR: Can't get feature `fan1_min' data!
> CPU PWM: 31.00 (pwm1)
> What's the reason? Did I still have to use "F75373"?

I see. This suggests that the driver itself identifies the chip as
F75373, and that's not correct. You need to put "f75373" in sensors,
and the driver needs to be updated in the same way.

> > Also, what about the F75375 support? As far as I know the f75375s
> >  driver
> > supports both chips, so it'd be nice to have user-space support for
> > both. Also, it might be less confusing to use F75375 for all the
> > libsensors defines, rather than F75373, so that they match the driver
> > name.
>
> I changed every define/function from F75373 to F75375, i added also:
> #define SENSORS_F75373_PREFIX "f75373"
> #define SENSORS_F75375_PREFIX "f75375"
> and
> { SENSORS_F75375_PREFIX, f75375_features },
> { SENSORS_F75373_PREFIX, f75375_features },
> and
> { "F75375", print_f75375 },
> { "F75373", print_f75375 },

Except for the leading capital, yes, it's OK. That being said, what's
the difference between the F75373 and the F75375? If the F75375 has
less inputs, then you'll need to adjust the code in "sensors" to not
try to display the missing inputs.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
