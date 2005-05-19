From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] updated it87 for kernel 2.6 - Part1
Message-Id: <20040216231514.61a84c5e.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Feb 2004 13:39:43 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> > I found it87 in kernel 2.6 may be based on old module.
> > It lacks reset_it87 option and smart guardian (sg) features in
> > lm_sensors cvs.
> > 
> > So I tryed to add these features and made the patch for
> > linux-2.6.2-rc2. It works well for me.
> > 
> > If you think the attached patch is useful, please merge it in.
> 
> I like the idea of porting 2.4 changes to 2.6, but your patch is not
> correct. In 2.6, we decided that each sysfs file would hold a single
> value. I agree that this is a bit different here since the "smart
> guardian" feature is specific to the IT87 chips. Still I don't think
> that Greg KH will accept such a patch.

Sorry, I didn't know that decision. I should have read porting-client
guide carefully.

> What do the three values in sgpwm and the five values in sgtl mean?
> We would have to find that many filenames.
>
> How different is the "smart guardian" pwm from the standard pwm?

"Smart guardian" is the automatic temperature control mode for the fan.
sgpwm means pwm values for low, medium and high speed for fan, and
sgtl means the temperature limits for fan off, low, medium, hi speed
and over temperature.

How about the sysfs names for Smart guardian like:
 sgpwm_low[1-3] sgpwm_medium[1-3] sgpwm_high[1-3]
 sgtemp_off[1-3] sgtemp_low[1-3] sgtemp_medium[1-3] sgtemp_high[1-3]
 sgtemp_over[1-3]

Please read the documentation of it87 for more details.
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/it87

> I also think it would be easier for us if you could split your big
> patch in parts. It looks like you do four different, independant
> things here:
> * change the sensor type selection method
> * add it87_reset (which btw I would more simply call "reset")
> * add pwm support
> * add smart guardian support

O.K., I will post patches step by step.

Here's the first patch for changing the sensor type selection method.
The patch deletes temp_type option and make the sensor type be set at
runtime instead.

Thanks,
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.2-rc2_it87_sensor_type.patch
Type: application/octet-stream
Size: 2655 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040216/15558bfd/linux-2.6.2-rc2_it87_sensor_type.obj
