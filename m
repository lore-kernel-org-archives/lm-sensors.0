From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 25 Jul 2015 17:29:27 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add autopoint attributes
Message-Id: <55B3C777.902@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437819272-26611-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1437819272-26611-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/25/2015 03:14 AM, Constantine Shulyupin wrote:
> Introduced REG_PWM, pwm[1..3]_auto_point[1..5]_temp,
> pwm[1..3]_auto_point[1..5]_pwm, nct7802_auto_point_attrs,
> nct7802_auto_point_group, updated nct7802_regmap_is_volatile
>

Your Signed-off-by: is missing after I apply the patch.

> ---
>
> Changed in v3:
> - removed nct7802_auto_point_is_visible
> - removed usage of sysfs_update_group
> - introduced REG_PWM
> - removed S_IWUSR from RO attributes
> - added PWM registers to nct7802_regmap_is_volatile

You'll also need to update the documentation. The driver now does support
intelligent fan speed control.

> Changed in v2:
> - removed PWM_REG, TEMP_REG
> - removed auto_point[1..4]_temp, auto_point[1..4]_pwm
>    and auto_point_crit_temp
> - introduced pwm[1..3]_auto_point[1..5]_temp
>    and pwm[1..3]_auto_point[1..5]_pwm.
> - introduced nct7802_auto_point_is_visible
> - used sysfs_update_group in store_pwm_enable
>
> Notes:
> I think that better to leave function nct7802_auto_point_is_visible.
> Autopoints attributes have default values and enabling autopoint doesn't
> confuse the chip. The chip accepts changing autopoint (SmartFan)
> registers after enabling autopoint mode.

This is not how we commonly handle this situation, and it may be confusing
for the user. Setting parameters first and then enabling automatic fan speed
control is more consistent with what I would consider a normal workflow.

I don't think it is a good idea to change attribute visibility on the
fly based on configuration changes. It may be necessary in some situations,
but for the most part it is just confusing for the user.

>
> I'll think about validating auto point settings latter.
> The next fix I would like is to add OF support, which is more important.
>
ok, makes sense.

> BTW, Guenter, have you TODO list for the driver?
>
No. This was a fun project for me to start with; only reason to implement
the driver was that I happen to have a board using it.

> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Ah, here it is. It is after the "---", so it is not added to the commit.
Please move it up for the next revision.

>   static bool nct7802_regmap_is_volatile(struct device *dev, unsigned int reg)
>   {
> -	return reg != REG_BANK && reg <= 0x20;
> +	return reg != REG_BANK && reg <= 0x20
> +		|| reg >= REG_PWM(0) && reg <= REG_PWM(3);

this expression causes a compile warning. Please add ( ) as asked for by
the compiler. Also please move the "||" one line up as suggested by
checkpatch --strict.

It should be "<= REG_PWM(2)" instead of "<= REG__PWM(3)".

I am having some trouble on my system reading pwm temperature limit data.
After I load the driver, sometimes the pwm temperature attributes show 0
even though the chip register dump is correct. Here is an example:

hwmon4/pwm3:127
hwmon4/pwm3_auto_point1_pwm:0
hwmon4/pwm3_auto_point1_temp:0
hwmon4/pwm3_auto_point2_pwm:178
hwmon4/pwm3_auto_point2_temp:0
hwmon4/pwm3_auto_point3_pwm:216
hwmon4/pwm3_auto_point3_temp:0
hwmon4/pwm3_auto_point4_pwm:255
hwmon4/pwm3_auto_point4_temp:0
hwmon4/pwm3_auto_point5_pwm:255
hwmon4/pwm3_auto_point5_temp:0
hwmon4/pwm3_enable:1
hwmon4/pwm3_mode:1

The "wrong" attribute values tend to be different each time the driver
is loaded.

Can you check if you have that problem as well ? I can't see what
may be wrong with the driver, though. Maybe it is a regmap bug.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
