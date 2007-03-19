From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 19 Mar 2007 17:11:23 +0000
Subject: [lm-sensors] DME1737 review (was Re:
Message-Id: <191fb4ca0703191011o62e44208m2952ce64851ba7a5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

First of all, thanks for the review, I really appreciate it. Please
see my comments embedded below.

> General remarks:
> - i2x writes / read status never gets checked anywhere, I dunno if this is done
>    in other lm_sensors drivers similary, but IMHO these things should be
>    checked!

Good point, never thought about it. I checked some of the other hwmon
drivers and none of them checks the return status (not that this is a
good excuse or anything). Checking all reads/writes sounds like an
overkill assuming that Jean is correct and these things hardly ever
fail. The least I can do is spit out a warning if something fails.


> +/* temperature input */
> +static int TEMP_FROM_REG(int reg, int res)
> +{
> +       return (((reg & (1 << (res - 1))) ? reg - (1 << res) : reg) *
> +               1000 / (1 << (res - 8)));
> +}
> +
> +static int TEMP_TO_REG(int val, int res)
> +{
> +       int temp = val * (1 << (res - 8)) / 1000;
> +       return SENSORS_LIMIT((temp < 0) ? temp + (1 << res) : temp,
> +                            0, (1 << res) - 1 );
> +}
>
> Wouldn't it be better readable / clearer when instead of:
> "x * 1000 / (1 << (res - 8))" you write "(x * 1000) >> (res - 8)" ?
> And the same for TEMP_TO_REG, instead of: "val * (1 << (res - 8)) / 1000",
> write: "(val << (res - 8)) / 1000" ?

Yeah, true. And more efficient too. Will fix.


> +static int TEMP_HYST_FROM_REG(int reg, int ix) {
> +       return ((((ix = 1) ? reg : reg >> 4) & 0x0f) * 1000);
> +}
> +
> +static int TEMP_HYST_TO_REG(int val, int ix, int reg)
> +{
> +       int hyst = SENSORS_LIMIT(val, 0, 15);
> +       return ((ix = 1) ? (reg & 0xf0) | hyst : (reg & 0x0f) | (hyst << 4));
> +}
>
> This doesn't seem consistent, when getting a hyst from the reg you multiply it
> by 1000 making it ready for sysfs, but when storing it to the reg, you don't
> divide it by 1000 (which should be done before the limit, or the limit should
> be adjusted)

Good catch! Will fix.


> Actually when using TEMP_HYST_TO_REG here:
> +       case SYS_TEMP_AUTO_POINT1_TEMP_HYST:
> +               data->zone_hyst[ix = 2] = TEMP_HYST_TO_REG(
> +                                       TEMP_FROM_REG(data->zone_low[ix], 8) -
> +                                       val, ix, dme1737_read(client,
> +                                       DME1737_REG_ZONE_HYST(ix = 2)));
> +               dme1737_write(client, DME1737_REG_ZONE_HYST(ix = 2),
> +                             data->zone_hyst[ix = 2]);
> +               break;
>
> You don't divide the temp past to TEMP_HYST_TO_REG by 1000, so its not
> inconsistent its actually a bug (fix please).

Ditto.


> Please add a comment that the pwm_freq registers hold the pwm freq in the lower
> nibble and the temp_range for the speed control in the higher nibble, without
> such a comment, this code looks rather strange:
> +       case SYS_TEMP_AUTO_POINT2_TEMP:
> +               res = TEMP_FROM_REG(data->zone_low[ix], 8) +
> +                     TEMP_RANGE_FROM_REG(data->pwm_freq[ix]);
> +               break;

Will do. I'll also rename the variable/register name to make it clearer.


> +       case SYS_TEMP_AUTO_POINT2_TEMP:
> +               data->pwm_freq[ix] = TEMP_RANGE_TO_REG(val -
> +                                       TEMP_FROM_REG(data->zone_low[ix], 8),
> +                                       dme1737_read(client,
> +                                       DME1737_REG_PWM_FREQ(ix)));
>
> Why do you use the cached temp here, but not the cached pwm_freq reg contents??
> Notice that you do this in several places.

Hmm... I want to make sure that I don't change the pwm_freq bits in
case the cache is out-of-sync with the register value. But if the
cache is stale the temp bits might be bogus and hence my calculated
temp value will be too. I guess you're right, I should read the temp
values from the register rather than using the cached values. Will
fix.


> +#define SYS_PWM                                0
> +#define SYS_PWM_FREQ                   2
> +#define SYS_PWM_ENABLE                 3
> +#define SYS_PWM_RAMP_RATE              4
> +#define SYS_PWM_AUTO_CHANNELS_TEMP     5
> +#define SYS_PWM_AUTO_POINT1_PWM                6
> +#define SYS_PWM_AUTO_POINT2_PWM                7
>
> Why is 1 not used in this "enum" ?

Will fix.


> Wouldn't it be cleaner to instead of:
> +#define SENSOR_ATTR_FAN_1TO4(ix) \
> +       SENSOR_ATTR_2(fan##ix##_type, S_IRUGO | S_IWUSR, \
> +               show_fan, set_fan, SYS_FAN_TYPE, ix-1)
> write:
> +#define SENSOR_ATTR_FAN_1TO4(ix) \
> +       SENSOR_ATTR_FAN(ix) \
> +       SENSOR_ATTR_2(fan##ix##_type, S_IRUGO | S_IWUSR, \
> +               show_fan, set_fan, SYS_FAN_TYPE, ix-1)
>
> And idem for 5to6, and the instead of:
> +       /* fans */
> +       SENSOR_ATTR_FAN(1),
> +       SENSOR_ATTR_FAN(2),
> +       SENSOR_ATTR_FAN(3),
> +       SENSOR_ATTR_FAN(4),
> +       SENSOR_ATTR_FAN(5),
> +       SENSOR_ATTR_FAN(6),
> +       /* fan[1-4] unique attrs */
> +       SENSOR_ATTR_FAN_1TO4(1),
> +       SENSOR_ATTR_FAN_1TO4(2),
> +       SENSOR_ATTR_FAN_1TO4(3),
> +       SENSOR_ATTR_FAN_1TO4(4),
> +       /* fan[5-6] unique attrs */
> +       SENSOR_ATTR_FAN_5TO6(5),
> +       SENSOR_ATTR_FAN_5TO6(6),
>
> write:
> +       /* fans */
> +       SENSOR_ATTR_FAN_1TO4(1),
> +       SENSOR_ATTR_FAN_1TO4(2),
> +       SENSOR_ATTR_FAN_1TO4(3),
> +       SENSOR_ATTR_FAN_1TO4(4),
> +       SENSOR_ATTR_FAN_5TO6(5),
> +       SENSOR_ATTR_FAN_5TO6(6),

Good suggestion. Will fix.


> Well thats it all in all it looks like a clean driver to me.


Thanks. Now on to yours...

Again, thanks a lot for the review. Modified patch coming soon...
...juerg

