From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Feb 2006 11:27:02 +0000
Subject: [lm-sensors] 2.6.15.1 Kernel patch for hardware monitoring
Message-Id: <MDM16JAH.1141126021.9409450.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602272321260.3095@Laila>
In-Reply-To: <Pine.LNX.4.63.0602272321260.3095@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Hartmut,

On 2006-02-28, Hartmut Rick wrote:
> > For newer designs, we try to have one sysfs file per alarm type (here,
> > one for voltages and one for temperatures) with bits sorted for
> > userspace. That way userspace doesn't need to know about the chip
> > internals. Can you try to do that in your driver? You'd have one
> > alarms_in file and one alarms_temp file.
>
> What would I do with temperature sensor faults? Create another file?
> What would it be called?
> temp_faults ?
> alarms_temp_faults ?
> faults_temp ?
> ... ?
> I've used the first for now, but there's no problem to change that.

I didn't know that this chip had such a feature, and here again other
drivers do not export these values in a standard way. I remember that
the pc87360 driver exports tempN_status files, which contain three
flags: low limit crossed, high limit crossed, and open diode. The bit
order matches the hardware registers rather than a defined standard,
though. The FSC drivers also have "state" files, but the bits meaning
differs.

So at this point we have several possibilities:
* Go with an alarms-like file, grouping by event and sensor type. If we
follow the naming scheme, it would be named fault_temp.
* Go with a status file, grouping by channel; it would be named
tempN_status. We'd need to standardize the meaning of each bit, and
update the pc87360 and fsc* drivers accordingly where needed.
* Go with individual files: tempN_status_fault. These would hold boolean 
values (or almost-boolean if there are several possible fault cases).

Each of these possibilities has advantages and drawbacks in terms of
driver size, speed, and interface compatibility.

My personal preference goes to the choice #3 (individual files)
especially now that we have the dynamic sysfs callbacks in place. It's
also convenient in the temperature sensor case as usually only some
sensors will have a fault bit (external diodes). That being said, my
previous attempt to define a standard sysfs interface wasn't exactly a
success so I probably shouldn't be the one deciding.
Comments/suggestions anyone?

> Otherwise I think I've included all your comments and suggestions.
> The patch for 2.6.15.1 kernel is attached to this email.

Great, that was quick :)

> I'll send documentation for the chip driver later.

OK, thanks.

My comments follow:

> --- linux-2.6.15.1/Documentation/hwmon/sysfs-interface
> +++ linux-2.6.15.1_changed/Documentation/hwmon/sysfs-interface
> @@ -226,3 +232,2 @@ temp[1-2]_crit_hyst
>  
> -
>  ************

Please avoid such whitespace changes in your patches, as they make the
changes look bigger than they really are and make the review harder.

> @@ -263,2 +268,10 @@ alarms		Alarm bitmask.
>  
> +alarms_in	Alarm bit pattern for voltages, bits sorted in the order
> +		of the in[0-8]_input. Bit 0 is the alarm for in0_input.
> +alarms_temp	Alarm bit pattern for temperatures temp[1-4].
> +		Bit 0 is the alarm for temp1_input.

These were already added in 2.6.16-rc3, please don't add them again.

> --- linux-2.6.15.1/drivers/hwmon/Kconfig
> +++ linux-2.6.15.1_changed/drivers/hwmon/Kconfig
> @@ -341,2 +341,13 @@ config SENSORS_SMSC47B397
>  
> +config SENSORS_SMSC47M192
> +	tristate "SMSC LPC47M192 and compatibles"
> +	depends on HWMON && I2C && EXPERIMENTAL
> +	select HWMON_VID
> +	help
> +	  If you say yes here you get support for the hardware sensor
> +	  capabilities of the SMSC LPC47M192 and LPC47M997 chips.

It should be made clearer that this driver handles the temperature and
voltage sensors, while the older smsc47m1 driver handles the fans. Some
chips support both (47M15x and 47M192 I think), some will support only
one of the drivers (anyone knows if the 47M997 has fan monitoring and
control capabilities?)

At any rate, this option should immediately follow the smsc47m1 entry in
the configuration menu, to make it even clearer that both drivers are
related.

> +#define show_temp_index(index)					\
> +static SENSOR_DEVICE_ATTR(temp##index##_input, S_IRUGO, 		\
> +			show_temp, NULL, index);		\
> +static SENSOR_DEVICE_ATTR(temp##index##_min, S_IRUGO | S_IWUSR,	\
> +		show_temp_min, set_temp_min, index);		\
> +static SENSOR_DEVICE_ATTR(temp##index##_max, S_IRUGO | S_IWUSR,	\
> +		show_temp_max, set_temp_max, index);
> +
> +show_temp_index(1);
> +show_temp_index(2);
> +show_temp_index(3);

By slightly changing the SMSC47M192_REG_TEMP* macros, you should be able
to internally number your temperature channels from 0, moving the -1/+1
offset from all the callback and update functions to the attribute
declarations above, making it a bit more efficient. At your option
though, it's not critical either.

> +static SENSOR_DEVICE_ATTR(temp2_offset, S_IRUGO | S_IWUSR,
> +		show_temp_offset, set_temp_offset, 2);
> +static SENSOR_DEVICE_ATTR(temp3_offset, S_IRUGO | S_IWUSR,
> +		show_temp_offset, set_temp_offset, 3);

From your original post I had understood that temp1 and temp3 had
offsets, rather than temp2 and temp3 as your code now has. Typo?

Note that I might have been misleading you with a previous comment about
adding an unused u8 in the structure to make the temperature offset code
more simple. On second reading, it is not necessary to do so, so I'm
glad you didn't ;) But you still have a few offsets here and there,
which should not be necessary.

I might provide an incremental later to tidy it all if you don't want to
change it now.

> +static ssize_t show_raw_alarms(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct smsc47m192_data *data = smsc47m192_update_device(dev);
> +	return sprintf(buf, "%u\n", data->raw_alarms);
> +}
> +static DEVICE_ATTR(alarms, S_IRUGO, show_raw_alarms, NULL);

Otherwise I'm quite happy with your code, thanks for the good work.
There are a few more coding style issues I'll handle when pushing your
script upwards, together with a few recent changes which are required
for 2.6.16 compatibility.

--
Jean Delvare

