From: "Phil Endecott" <phil_lftzl_endecott@chezphil.org>
Date: Sat, 09 Jun 2007 22:47:13 +0000
Subject: Re: [lm-sensors] f71805f; getting fan speed temperature mode	working
Message-Id: <1181429233737@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> So the next challenge is temperature tracking.  I understand that this 
>> is not currently implemented by the driver (I'm looking at the 2.6.21 
>> source; please let me know and accept my apologies if this driver has 
>> been updated since then).  I could perhaps add this functionality, but 
>> first I'd like to know if there was some problem that prevented the 
>> original author from doing so.
>
> This is still not implemented. The reason was a mix of lack of time and
> lack of interest. My CPU fan is pretty silent anyway, so I could live
> with it at full speed all the time. However, if you want to implement
> this feature, this is welcome, and I'll be happy to review and test
> your patch. This is probably the last missing feature in this driver
> for the F71805F. (For the F71872F, VID support is also missing.)

This doesn't fit in very well with the scheme described in Documentation/hwmon/sysfs-interface:

<quote>
pwm[1-*]_auto_channels_temp
                 Select which temperature channels affect this PWM 
output in
                 auto mode. Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
                 Which values are possible depend on the chip used.
                 RW

pwm[1-*]_auto_point[1-*]_pwm
pwm[1-*]_auto_point[1-*]_temp
pwm[1-*]_auto_point[1-*]_temp_hyst
                 Define the PWM vs temperature curve. Number of trip 
points is
                 chip-dependent. Use this for chips which associate trip points
                 to PWM output channels.
                 RW

OR

temp[1-*]_auto_point[1-*]_pwm
temp[1-*]_auto_point[1-*]_temp
temp[1-*]_auto_point[1-*]_temp_hyst
                 Define the PWM vs temperature curve. Number of trip 
points is
                 chip-dependent. Use this for chips which associate trip points
                 to temperature channels.
                 RW
</quote>


In contrast to that framework,

1. This chip ties pwm<n>, fan<n> and temp<n> together, so the 
'channels' idea doesn't apply.
2. The points relate fan speeds and temperatures, not pwm values and temperatures.
3. It doesn't have variable hysteresis.

It defines a temp/speed staircase with three (temp,speed) pairs:

- When temp<temp1, fan is off.
- When temp1<temp<temp2, fan adjusts to make speed=speed1.
- When temp2<temp<temp3, fan adjusts to make speed=speed2.
- When temp3<temp, fan adjusts to make speed=speed3.

..except that actually it interpolates an additional two pairs between 
the ones that you define.

So, I propose the following sysfs files:

for n in 1 2 3
   for p in 1 2 3
     pwm$n_auto_point$p_temp
     pwm$n_auto_point$p_fan


but I'm open to alternative ideas.

So I believe that I need to:

- Create the sysfs stuff.
- Extend the mode-change stuff to adjust file permissions appropriately.
- Add show/set functions that access the device registers.

and that's about it.  What have I forgotten?


Regards,

Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
