From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 14:47:54 +0000
Subject: Re: [lm-sensors] Need some guidance on adhering to the sysfs
Message-Id: <20070419164754.1f0f14f8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On Thu, 12 Apr 2007 10:50:30 -0600, George T. Joseph \(development\) wrote:
> I'm wrapping up the Andigilog driver and am having problems trying to
> adhere to the sysfs auto_point definitions.
> 
> These chips have 2 temp points.  The low temp (auto_point1_temp) is
> simple enough to map to the corresponding register.  The high point
> (auto_point2_temp) isn't so easy because it's implemented as a range
> with the low temp as a base.  Even worse, range is not an arbitrary
> value; it's a value from a list of 16.  So if a user chooses 26 for a
> low point and 50 for a high point, that's a range of 24 except that 24
> isn't a valid range value.  The closest values are either 20 or 26.67.
> Also, if the user sets the high point then changes the low point, the
> high point will probably have to be changed because the new calculated
> range might not be a valid value.

Pick the nearest possible value for auto_point2_temp. If
auto_point1_temp is changed afterwards, indeed the range register
should be adjusted so that auto_point2_temp is preserved as much as
possible (principle of least surprise). I understand there will be some
loss, but that's better than ignoring the issue altogether. I do not
expect it to be a big deal in practice, as I think the users typically
set auto_point1 first.

> Auto_point_pwm is also an issue.  Where there are 4 temp zones, there
> are only 3 pwm outputs and the assignment of pwm to zone can be changed
> by the user or automatically by the chip.   

Automatically, based on what?
What is a "temp zone" for this device?

We have a mapping file (auto_channels) between PWM outputs and
temperature inputs which is supposed to address this issue.

> Finally, there's only 1 hysteresis value per zone, not 1 per auto_point
> so should I do an auto_point1_temp_hyst and an auto_point2_temp_hyst and
> have them both point to the same register or maybe a
> auto_point_temp_hyst without an index?

Make auto_point1_temp_hyst writable and auto_point2_temp_hyst read-only.

> I guess I have 4 options...
> 
> 1) Don't implement auto_point functionality at all.  A bad choice I
> believe.
> 
> 2) Implement the logic to get as close as possible to the standard but
> this is going to be very confusing to a user especially the range
> business since changing 1 value can force change of others.  It's also
> going to increase the complexity of the driver significantly.

Yes, please do this. It shouldn't be so hard. See my advice above.

Feel free to create a file under Documentation/hwmon for your driver
and document the limitations if you think the user might be confused.

> 3) Adhere to the standard where possible without creating the compound
> relationships.  So what I'd do is...
>  temp[1-4]_auto_point_temp_min
>  temp[1-4]_auto_point_temp_range
>  temp[1-4]_auto_point_temp_hyst
>  pwm[1-3]_auto_channels_temp
>  pwm[1-3]_auto_point_pwm_min
>  pwm[1-3]_auto_point_pwm_max
> 
> 4) Or I could just name them what they're named in the data sheet...
> 
>  temp[1-4]_fan_temp_limit
>  temp[1-4]_range
>  temp[1-4]_hyst
>  pwm[1-3]_config
>  pwm{1-3]_min
>  pwm[1-3]_max

This would be particularly confusing, as these names don't show the
relations between the items.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
