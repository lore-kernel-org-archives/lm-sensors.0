From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 13 Aug 2009 06:14:32 +0000
Subject: Re: [lm-sensors] Accelerometer
Message-Id: <4A83AF48.5000501@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A816C83.1070409@cam.ac.uk>
In-Reply-To: <4A816C83.1070409@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Trisal, Kalhan wrote:
> Thanks Jonathan.
>   Please find my comments inline.
Hi Kalhan,

Few responses below.  For reference, IIO (which might be a more
suitable location than hwmon) is going to go into the staging tree shortly.

If you are interested, I'd be happy to do a conversion if you'd be willing
to test against the hardware.  To support the current functionality should
be straight forward

...
>> +static unsigned int i2c_write_current_data(struct i2c_client *client,
>> +                                     unsigned int reg, unsigned int value)
>> +{
>> +     int ret_val;
>> +
>> +     ret_val = i2c_smbus_write_byte_data(client, reg, value);
>> +     return ret_val;
>> +}
> Why bother with above. Doesn't seem to being anything?  Presumably
> it was to allow for later inclusion of spi support, but as is you
> might as well call the smbus command directly.
> 
> 
>>> yes can be done but for future support/enhancement  let's keep it as modular as possible.
But it's not modular unless you make it take the say a struct acclero_data (with the i2c_client
as a member).  Thus when you add spi support, you can use function pointers to call the relevant
write function.  As is, it adds a module that doesn't do anything.

...
> 
> Not clear what state is refering to. Looking at the data sheet I
> can see that it is power down control. Do you want userspace access
> to this, or should it be done via the fine grained power management
> stuff that is working its way into the kernel?
> 
>>> in mids the Apps. manager are intelligent to check if no apps are going to use the device they can power down the device,
>>> power management can do this, but we decided that exposing this to app manager will be more effective as we can put the
>>> device in active mode only when needed.
There's been some recent work on runtime power management.
I've only been vaguely following it, but I believe the intention is to allow
for putting individual devices to sleep much as you are here.

http://lkml.org/lkml/2009/8/9/128

Having read the above posting, it appears that the i2c bus may need
support for this as well.  Perhaps your state sysfs interface
is the best way to go in the meantime.

> 
> Up to you whether you do a single access point for all 3 readings (scan
> across them) or individual reads.  Guess which makes sense depends on the
> application.
> 
>>> thought about this but apps want all the data at a given time stamp, this also many not be accurate but by calling individual x,y,z
>>> this seems to be more accurate at given time stamp what is the current position.
Make sense, though the average dma based i2c controller is going to make
knowing when a transfer occured complex, particularly with the 3 separate
transfers used below.
 
>> +static ssize_t xyz_pos_show(struct device *dev,
>> +                             struct device_attribute *attr, char *buf)
>> +{
>> +     int x, y, z;
>> +     struct i2c_client *client = to_i2c_client(dev);
> I haven't read the data sheet thoroughly, but is the device capable of
> doing more complex reads? (would be nice to cut down the bus load
> of this given the device is running at maybe 400 Hz).
> Table 14 of the data sheet seems to hint this can be done.
> I guess it would also be dependant on what your i2c adapter supports.
> 
>>> Agree It is adapter dependent, will put the note here saying that if the adapter support multiple
>>> register read simultaneously then that also can be performed.
That's fair enough.
>> +     x = i2c_smbus_read_byte_data(client, 0x29);
>> +     y = i2c_smbus_read_byte_data(client, 0x2B);
>> +     z = i2c_smbus_read_byte_data(client, 0x2D);
>> +     return sprintf(buf, "%d, %d, %d \n", x, y, z);
>> +}
>> +
>> +static ssize_t rate_store(struct device *dev,
>> +             struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     struct acclero_data *data = i2c_get_clientdata(client);
>> +     unsigned int ret_val, set_val;
>> +     unsigned long val;
>> +
>> +     if (strict_strtoul(buf, 10, &val))
>> +             return -EINVAL;
> Why bother locking for updates without protecting the reads as well?
> Given I'm guessing a given i2c write is atomic, I'm not sure you gain
> anything.
> 
> 
>  > > will remove mutex
Might be better to just move it to cover the read as well.  Although I don't
think there are any cases here that could lead to an undesirable state
I haven't read the data sheet thoroughly enough to be sure there aren't
any that might be added in the future.

 
>> +     ret_val = i2c_smbus_read_byte_data(client, 0x20);
>> +
>> +     mutex_lock(&data->update_lock);
>> +     if (val = ACCEL_DATA_RATE_100HZ)
>> +             set_val = (ret_val & 0x7F); /* setting the 8th bit to 0 */
>> +     else if (val = ACCEL_DATA_RATE_400HZ)
>> +             set_val = (ret_val | (1 << 7));
>> +     else
>> +             goto invarg;
>> +
>> +     i2c_write_current_data(client, 0x20, set_val);
>> +     mutex_unlock(&data->update_lock);
>> +     return count;
>> +invarg:
>> +     mutex_unlock(&data->update_lock);
>> +     return -EINVAL;
>> +}

>> +static ssize_t state_store(struct device *dev,
>> +             struct device_attribute *attr, const  char *buf, size_t count)
>> +{
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     struct acclero_data *data = i2c_get_clientdata(client);
>> +     unsigned int ret_val, set_val;
>> +     unsigned long val;
>> +
>> +     if (strict_strtoul(buf, 10, &val))
>> +             return -EINVAL;
>> +     ret_val = i2c_smbus_read_byte_data(client, 0x20);
>> +
>> +     mutex_lock(&data->update_lock);
>> +     if (val = ACCEL_POWER_MODE_DOWN)
>> +             set_val = ret_val & 0xBF; /* if value id 0 */
>> +     else if (val = ACCEL_POWER_MODE_ACTIVE)
>> +             set_val = (ret_val | (1<<6)); /* if value is 1 */
>> +     else
>> +             goto invarg;
>> +
>> +     i2c_write_current_data(client, 0x20, set_val);
>> +     mutex_unlock(&data->update_lock);
>> +     return count;
>> +invarg:
>> +     mutex_unlock(&data->update_lock);
>> +     return -EINVAL;
>> +}
> 
> Why do you want this exposed to userspace? To my reading
> the primary purpose in doing this is to reset any changes
> to the various calibrated parameters. Exporting to userspace
> might make sense if you were also exporting interfaces for them
> (HPcoeff for example) Even then, I'm not sure providing access
> to this isn't more confusing than ideal.
> 
>>> this is exposed to user space if the application manager is sensing that the values
>>> from the device are inconsistent, then best way is to reboot the device. This option is
>>> only for sensor application manager. I felt it will be useful when device misbehaves and can be rectified
>>> dynamically by rebooting the device.
Does this actually happen?  If so definitely worth adding some documentation
of the circumstances as this would be an out and out hardware bug and might
trip other people up.  In general I'd be loath to have such a command exported
to userspace, but if it's needed to work round a hardware problem, fair enough.
I'd have thought the principle reason for having the support in the hardware
was to ensure a known consistent state on driver load rather than to fix problems
during use.
> 
>> +static ssize_t reboot_mem_store(struct device *dev,
>> +             struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     struct acclero_data *data = i2c_get_clientdata(client);
>> +     unsigned int ret_val, set_val;
>> +     unsigned long val;
>> +
>> +     if (strict_strtoul(buf, 10, &val))
>> +             return -EINVAL;
>> +     ret_val = i2c_smbus_read_byte_data(client, 0x21);
>> +     if (val = ACCEL_MEMORY_REBOOT) {
>> +             mutex_lock(&data->update_lock);
>> +             set_val = (ret_val | (1 << 6)); /* setting the 6th  bit */
>> +             i2c_write_current_data(client, 0x21, set_val);
>> +             mutex_unlock(&data->update_lock);
>> +     } else
>> +             return -EINVAL;
>> +     return count;
>> +}
>> +
>> +static DEVICE_ATTR(data_rate, S_IRUGO | S_IWUSR, rate_show, rate_store);
>> +static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR, state_show, state_store);
>> +static DEVICE_ATTR(reboot_mem, S_IWUSR, NULL, reboot_mem_store);
>> +static DEVICE_ATTR(position, S_IRUGO, xyz_pos_show, NULL);
>> +
>> +static struct attribute *mid_att_acclero[] = {
>> +     &dev_attr_data_rate.attr,
>> +     &dev_attr_power_state.attr,
>> +     &dev_attr_reboot_mem.attr,
>> +     &dev_attr_position.attr,
>> +     NULL
>> +};
> This is a little odd, why have a device with an attribute group
> of the same name? I think this will lead to a somewhat unusual
> structure in sysfs.
> 
>>> I am not clear here, does it mean that we should rename it as accelerometer.
No, don't give it any name at all.  Then all the sysfs files should appear in 
/sys/class/hwmon/device0/device/ rather than adding an additional directory layer.
> 
>> +static struct attribute_group m_acclero_gr = {
>> +     .name = "lis331dl",
>> +     .attrs = mid_att_acclero
>> +};
...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
