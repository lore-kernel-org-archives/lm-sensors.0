From: gtj.devel@peakin.com (George T. Joseph (development))
Date: Thu, 28 Dec 2006 23:32:36 +0000
Subject: [lm-sensors] Working on a driver for the Andigilog aSC7621
Message-Id: <22E26940476D1E48AA6F292B5316C9C3376C@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I knew there were going to be serious objections.  That's why I didn't
write the userspace stuff yet.  :)

I started by looking at the LM85 driver and realized that there were way
too many places that the same thing appeared: Lots of functions whose
only difference is the name and register, too many places to change the
name of a sensor, code to handle different chip variants scattered over
the whole module, etc.  

The bottom line is that there are 16 bit values, 12 bit values, 10 bit
values, etc, etc.  Some have different formatting or scaling than others
but there are very few "one offs".  This makes it very easy to write a
descriptor table entry for each sensor value and write generic code to
handle it.  For instance, since the Andigilog family doesn't have the
problem with reading 2 byte values in a certain order, it's much more
efficient to read the 256 byte register space as simply an array of
bytes rather than a hundred plus discrete values.  It seems to me that
making the drivers more generic will only help maintainability going
forward.  You'll also notice that this driver handles 3 chips but the
actual code specific to each is very small compared to some of the other
drivers.

I followed the naming conventions where I could but chose to use the
data sheet's names where there was nothing close or that made sense.  I
can change some of them if you want.

More comments in line...

george

> -----Original Message-----
> From: Rudolf Marek [mailto:r.marek at assembler.cz] 
> Sent: Thursday, December 28, 2006 1:59 PM
> To: George T. Joseph (development)
> Cc: LM Sensors
> Subject: Re: [lm-sensors] Working on a driver for the 
> Andigilog aSC7621
> 
> Hello George,
> 
> Sorry for the delay. I had some time to look into the driver 
> before Jean will
> do. Jean will have final word, I'm just a preprocessor.
> 
> I'm afraid Jean will not accept your driver without some 
> major changes. Here is
> the list:
> 
> 1) Do you have some customer which requested all possible 
> registers to be
> exported? Our current policy is to export just what might be 
> necessary, like
> obvious things as voltages etc etc plus the trip points. The 
> advanced chip setup
> is not exported unless there is some reason for this - like 
> bad bios setup,
> silly default value etc...

Yeah, me.  What does it hurt to expose everything the chip is capable
of?  Maybe seeing the data will inspire someone to make a good use of
it.  Besides, if we don't exponse it, we might as well lump all the
drivers into one and export the least common denominator.

> 
> As you noticed we have a sysfs-interface file which describes 
> the "standard" for
> the exported files, we want to get rid of "raw" register 
> values as much as
> possible. If this is inevitable the documentation file in 
> Documentation/ should
> document the non-standard sysfs names and their I/O (pointing 
> to datasheet is
> always good, but we prefer to have the info right in that file ;)
> 
> Is it possible just to export what avarage user needs?

I adhered to the standard for the common things: voltages, fans, temps,
pwm.  The rest I named as they are in the data sheet.  To me it makes
much more sense rather than making up names for them that aren't
recognizable.  

I'll add more info to the doc file.

> 
> 2) Sysfs binding
> 
> It seems you have chosen very own way how to do that, and I 
> think this can't be
> accepted this way. We would prefer to use the method as other 
> drivers use.
> 
> Please use SENSOR_ATTR and SENSOR_ATTR_2 macros for your job. 
> You will get rid
> of that get_index_from_name and create_param functions which 
> sucks (looks like
> windows coding style to me)

"Windows coding style" Ouch, that hurts. :)
The macros expect string literals (they use _stringify) which makes it
very hard to consolidate the code.  The way I have it, there's only 1
line of code unique to each parameter.  

> 
> This is closely connected with the use of the "register" 
> cache and way how you
> handle the values stored in the driver (data->registers[i] 
> instead of the
> variable names) Please note that some MSB LSB registers often 
> require to readl
> them in particular order to "lock" the second value - to 
> obtain correct result.
> I'm not sure if this is always your case. This needs to be checked.

I checked.  The Andigilog family is bi-directional.  You can read either
the msb or lsb first and the other one will lock until you read it.

> 
> I would like to ask what you do not like on following design:
> 
> a) have the data->fan data->in etc etc Separate files for registers
> b) use of the SENSOR_ATTR_XXXX which construct the sysfs name 
> and pass index or
> more to the data->fan[ ][ ] arrays.

See my opening comments.  Discrete names just aren't needed.

> 
> If you think that you can't reuse one routine for a "integer 
> %d printout" that
> is not true. We have some drivers which (ab)use one index 
> member in SENSORS_ATTR
> to enumarate what "kind" of value is to be printed and later 
> in the code:
> 
> show_fan(struct device *dev, struct device_attribute *attr, char *buf)
> 
> {
> 
>         struct sensor_device_attribute_2 *sensor_attr > 
>             to_sensor_dev_attr_2(attr);
> 
>         int nr = sensor_attr->nr;
> 
>         int index = sensor_attr->index;
> 
>         struct w83793_data *data = w83793_update_device(dev);
> 
>         u16 val;
>        if (FAN_INPUT = nr) {
> 
>                 val = data->fan[index] & 0x0fff;
> 
>         } else {
> 
>                 val = data->fan_min[index] & 0x0fff;
> 
>         }
>         return sprintf(buf, "%lu\n", FAN_FROM_REG(val));
> 
> This function print either fan or fan_min value and use the 
> SENSOR_ATTR to store
> the index.
> 
> I think you did not use that because you missed a way how to 
> point to a custom
> array (I think you wanted to pass the string there???)

Thanks but my point is that there doesn't need to be a fan-specific
function in the first place.  

> 
> Also for a latest kernels you could use sysfs_create_group to 
> create whole bunch
> of sysfs files with one call.

I don't want to create them with one call because I need to do other
things at the same time for each parameter.

> 
> You will also need to add error code checking to the 
> device_create_file(dev,
> .,.. and also destroy all files when the driver is removed 
> (this is also a new
> stuff required by recent kernels)

I'll add the checking and the destroys.

> 
> 3) non-standard sysfs files
> 
> I spotted that you create sometimes non-standard sysfs files, 
> maybe there is
> away to make them standard or use standard names:
> 
> fan1_input OK (some drivers do not report -1 for stuck fan anymore)
> fan1_min OK
> fan1_alarm OK if there is just 0 or 1 in the file

Fanx_alarm is just a single bit.

The rest I named per the data sheet.  Pick any one, open the data 
sheet and you'll know exactly what it is.

> 
> 
> I'm attaching the rest without any notice right now. My time 
> is up. It needs to
> be discussed anyway.
> 
> fan1_config
> 
> fan1_spinup ???
> 
> temp1_abs_limit
> temp1_alarm
> temp1_fan_temp_limit
> temp1_high_alert_limit
> temp1_hyst
> temp1_input
> temp1_input_fault
> temp1_low_alert_limit
> temp1_max
> temp1_min
> temp1_offset
> temp1_range
> temp1_smoothing
> temp1_smoothing_enable
> temp1_source
> temp1_type
> 
> pwm1
> pwm1_config
> pwm1_config_alt
> pwm1_freq
> pwm1_invert
> pwm1_max
> pwm1_min
> pwm1_spinup
> 
> gpio1
> gpio1_func
> gpio2
> gpio2_func
> gpio3
> gpio3_func
> gpio_alert_assign
> peci_4domain
> peci_avg
> peci_cpu0_enable
> peci_cpu1_enable
> peci_cpu2_enable
> peci_cpu3_enable
> peci_diode
> peci_domain
> peci_enable
> peci_legacy
> peci_temp1_input
> peci_temp2_input
> peci_temp3_input
> peci_temp4_input
> 
> Please try to think about using the standard temperature/pwm 
> automatic control
> files like pwm[1-*]_auto_point[1-*]_pwm  or 
> temp[1-*]_auto_point[1-*]_pwm

I'll think about it but the names you suggest make no sense at all.
Try looking temp1_auto_point1_pwm up in the data sheet. :)

> 
> Thanks,
> 
> Rudolf
> 
> 

